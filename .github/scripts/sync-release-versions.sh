#!/usr/bin/env bash
# ------------------------------------------------------------------------
#
# Copyright 2026 WSO2, LLC. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# ------------------------------------------------------------------------
#
# Opens (or refreshes) a pull request in a target repository that raises the release versions
# recorded in one of its JSON files to the latest v<X.Y.Z>.<N> tags of this repository.
#
# The target's location comes only from a secret. This script masks every part of it and never
# prints it, the file's contents or the request URLs, so none of it reaches this repository's logs.
#
# Environment:
#   GITHUB_REPOSITORY  this repository, owner/repo (required)
#   GH_TOKEN           token that can read this repository's tags (required)
#   TARGET_TOKEN       token with contents:write and pull-requests:write on the target (required)
#   TARGET_REPO        target repository, owner/repo (required)
#   TARGET_REF_PATH    "<branch>/<path to file>"; the branch may itself contain "/" (required)
#   TARGET_PR_BRANCH   branch the bot pushes to (default: docker-is/release-versions)
#   DRY_RUN            "true" to only print the version changes

set -euo pipefail

: "${GITHUB_REPOSITORY:?}" "${GH_TOKEN:?}" "${TARGET_TOKEN:?}" "${TARGET_REPO:?}" "${TARGET_REF_PATH:?}"
PR_BRANCH="${TARGET_PR_BRANCH:-docker-is/release-versions}"
DRY_RUN="${DRY_RUN:-false}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

# Keep gh quiet on errors so request URLs (which contain the target location) never reach the log.
target_api() { GH_TOKEN="$TARGET_TOKEN" gh api "$@" 2>/dev/null; }
fail() { echo "::error::$1"; exit 1; }

# Latest tag per release line, e.g. "7.2.0=7.2.0.9", from this repository's v<X.Y.Z>.<N> tags.
pairs=$(gh api --paginate "repos/${GITHUB_REPOSITORY}/git/matching-refs/tags/v" --jq '.[].ref' \
  | sed -n 's|^refs/tags/v\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\)\.\([0-9][0-9]*\)$|\1 \2|p' \
  | sort -k1,1 -k2,2n \
  | awk '{ last[$1] = $2 } END { for (v in last) print v "=" v "." last[v] }' | sort -V)

# Split "<branch>/<path>" at the first prefix that is an existing branch, so branches may contain "/".
base_branch="" file_path="" base_sha="" rest="$TARGET_REF_PATH" prefix=""
while [[ "$rest" == */* ]]; do
  prefix="${prefix:+${prefix}/}${rest%%/*}"
  rest="${rest#*/}"
  if sha=$(target_api "repos/${TARGET_REPO}/git/ref/heads/${prefix}" --jq '.object.sha'); then
    base_branch="$prefix" file_path="$rest" base_sha="$sha"
    break
  fi
done
[[ -n "$base_sha" ]] || fail "Could not find the target branch (check the file URL secret and the token's access)"
echo "::add-mask::${base_branch}"
echo "::add-mask::${file_path}"

target_api "repos/${TARGET_REPO}/contents/${file_path}?ref=${base_sha}" --jq '.content' \
  | base64 -d > "$work/file.json" || fail "Could not read the target file"
cp "$work/file.json" "$work/original.json"

# shellcheck disable=SC2086 # pairs is a whitespace-separated list
changes=$(python3 "$SCRIPT_DIR/bump_versions.py" "$work/file.json" $pairs) || fail "Could not update the target file"

if [[ -z "$changes" ]]; then
  echo "Target already has the latest release versions."
  exit 0
fi
echo "Release version changes:"
while read -r line old _ new; do echo "  ${line}: ${old} -> ${new}"; done <<< "$changes"

if [[ "$DRY_RUN" == "true" ]]; then
  echo "[dry-run] not opening a pull request"
  exit 0
fi

list=$(while read -r line old _ new; do
  echo "* ${line}: ${old} → [${new}](https://github.com/${GITHUB_REPOSITORY}/releases/tag/v${new})"
done <<< "$changes")
title="Update release versions from ${GITHUB_REPOSITORY}"

# If the bot branch already holds exactly this content, there is nothing to push.
branch_exists=false
if target_api "repos/${TARGET_REPO}/git/ref/heads/${PR_BRANCH}" >/dev/null; then
  branch_exists=true
  if target_api "repos/${TARGET_REPO}/contents/${file_path}?ref=${PR_BRANCH}" --jq '.content' \
       | base64 -d > "$work/branch.json" && cmp -s "$work/branch.json" "$work/file.json"; then
    echo "The pull request branch is already up to date."
    branch_current=true
  fi
fi

if [[ "${branch_current:-false}" != "true" ]]; then
  # Build one commit on top of the base branch and move the bot branch to it in a single update,
  # so the branch is never level with its base (which would close an open pull request).
  base_tree=$(target_api "repos/${TARGET_REPO}/git/commits/${base_sha}" --jq '.tree.sha') || fail "Could not read the base commit"
  blob=$(jq -n --rawfile c "$work/file.json" '{content: $c, encoding: "utf-8"}' \
    | target_api -X POST "repos/${TARGET_REPO}/git/blobs" --input - --jq '.sha') || fail "Could not upload the file"
  mode=$(target_api "repos/${TARGET_REPO}/git/trees/${base_tree}?recursive=1" \
    | jq -r --arg p "$file_path" '.tree[] | select(.path == $p) | .mode' 2>/dev/null || true)
  tree=$(jq -n --arg base "$base_tree" --arg p "$file_path" --arg m "${mode:-100644}" --arg b "$blob" \
      '{base_tree: $base, tree: [{path: $p, mode: $m, type: "blob", sha: $b}]}' \
    | target_api -X POST "repos/${TARGET_REPO}/git/trees" --input - --jq '.sha') || fail "Could not create the tree"
  commit=$(jq -n --arg msg "${title}"$'\n\n'"${list}" --arg t "$tree" --arg p "$base_sha" \
      '{message: $msg, tree: $t, parents: [$p]}' \
    | target_api -X POST "repos/${TARGET_REPO}/git/commits" --input - --jq '.sha') || fail "Could not create the commit"
  if [[ "$branch_exists" == "true" ]]; then
    target_api -X PATCH "repos/${TARGET_REPO}/git/refs/heads/${PR_BRANCH}" -f sha="$commit" -F force=true >/dev/null \
      || fail "Could not update the pull request branch"
  else
    target_api -X POST "repos/${TARGET_REPO}/git/refs" -f ref="refs/heads/${PR_BRANCH}" -f sha="$commit" >/dev/null \
      || fail "Could not create the pull request branch"
  fi
fi

body="Raises release versions to the latest releases of [${GITHUB_REPOSITORY}](https://github.com/${GITHUB_REPOSITORY}/releases):

${list}

Opened and kept up to date by the release workflow in ${GITHUB_REPOSITORY}."

pr_number=$(target_api "repos/${TARGET_REPO}/pulls?state=open&head=${TARGET_REPO%%/*}:${PR_BRANCH}" --jq '.[0].number // empty') \
  || fail "Could not look up existing pull requests"
if [[ -n "$pr_number" ]]; then
  target_api -X PATCH "repos/${TARGET_REPO}/pulls/${pr_number}" -f body="$body" >/dev/null || fail "Could not update the pull request"
  echo "Updated the existing pull request."
else
  target_api -X POST "repos/${TARGET_REPO}/pulls" -f title="$title" -f head="$PR_BRANCH" \
    -f base="$base_branch" -f body="$body" >/dev/null || fail "Could not open the pull request"
  echo "Opened a pull request."
fi
