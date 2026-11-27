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
# Tags and releases WSO2 IS Docker resource branches.
#
# A release branch named <major>.<minor>.x (e.g. 7.2.x) is released with tags of the
# form v<major>.<minor>.0.<N> (e.g. v7.2.0.8). For every release branch this script:
#   1. creates the GitHub release for the branch's latest tag if that tag has none, and
#   2. if the branch head is ahead of the latest tag, tags the head as N+1 and creates
#      a release listing the pull requests merged since the previous tag.
# Branches whose head is already tagged are skipped, so the script is safe to re-run.
#
# Environment:
#   GITHUB_REPOSITORY  owner/repo (required)
#   GH_TOKEN           token with contents:write (required)
#   BRANCHES           space-separated branches to process; empty = all <major>.<minor>.x branches
#   DRY_RUN            "true" to print what would be done without creating anything

set -euo pipefail

REPO="${GITHUB_REPOSITORY:?GITHUB_REPOSITORY must be set}"
DRY_RUN="${DRY_RUN:-false}"
BRANCHES="${BRANCHES:-}"
RELEASE_TITLE="Docker and Docker Compose Resources for WSO2 Identity And Access Management"

if [[ -z "${BRANCHES// /}" ]]; then
  BRANCHES=$(gh api --paginate "repos/${REPO}/branches" --jq '.[].name' | grep -E '^[0-9]+\.[0-9]+\.x$' || true)
fi

# Current "Latest" release. Only a 404 means there is none; any other failure stops the run so a
# transient error can't cause an older release to be marked Latest.
lookup_err=$(mktemp)
if ! latest_release_tag=$(gh api "repos/${REPO}/releases/latest" --jq '.tag_name' 2>"$lookup_err"); then
  if grep -q 'HTTP 404' "$lookup_err"; then
    latest_release_tag=""
  else
    cat "$lookup_err" >&2
    echo "::error::Could not look up the latest release; aborting"
    exit 1
  fi
fi
rm -f "$lookup_err"

# Prints the release notes body for tag $1, covering commits from $2 (previous tag, may be empty) to $3.
release_notes() {
  local tag="$1" base="$2" head="$3" changes="" subjects pr title
  if [[ -n "$base" ]]; then
    subjects=$(gh api --paginate "repos/${REPO}/compare/${base}...${head}?per_page=100" \
      --jq '.commits[].commit.message | split("\n")[0]')
    local seen=" "
    while IFS= read -r subject; do
      [[ -z "$subject" ]] && continue
      pr=""
      if [[ "$subject" =~ ^Merge\ pull\ request\ \#([0-9]+) ]] || [[ "$subject" =~ \(\#([0-9]+)\)$ ]]; then
        pr="${BASH_REMATCH[1]}"
      fi
      if [[ -n "$pr" && "$seen" != *" ${pr} "* ]]; then
        seen+="${pr} "
        title=$(gh api "repos/${REPO}/pulls/${pr}" --jq '.title' 2>/dev/null || echo "$subject")
        changes+="* ${title} in #${pr}"$'\n'
      fi
    done <<< "$subjects"
    # Commits pushed directly (no PR): list their subjects instead.
    if [[ -z "$changes" ]]; then
      changes=$(printf '%s\n' "$subjects" | sed '/^$/d; s/^/* /')$'\n'
    fi
  else
    changes="* Initial release"$'\n'
  fi

  cat <<EOF
WSO2 Identity And Access Management Team is pleased to announce the release of Docker and Docker Compose resources for WSO2 Identity And Access Management ${tag}

This release covers the following.

## What's Changed
${changes}
How You Can Contribute?
Join our mailing list and correspond with the developers directly.
Developer List: dev@wso2.org
User List: user@wso2.org

Reporting Issues
We encourage you to report [issues](https://github.com/wso2/product-is/issues) and documentation faults regarding WSO2 Docker and Docker Compose resources by creating issues.

Thank you!
**WSO2 Identity And Access Management Team**
EOF
}

# Creates release $1. $2 = target sha (empty to use an existing tag), $3 = previous tag, $4 = notes head ref.
create_release() {
  local tag="$1" target="$2" prev="$3" head="$4" notes_file latest="false"
  notes_file=$(mktemp)
  release_notes "$tag" "$prev" "$head" > "$notes_file"

  # Mark as "Latest" only if this is the highest version released so far.
  if [[ -z "$latest_release_tag" ]] || \
     [[ "$(printf '%s\n%s\n' "${latest_release_tag#v}" "${tag#v}" | sort -V | tail -n1)" == "${tag#v}" ]]; then
    latest="true"
  fi

  local args=(release create "$tag" --repo "$REPO" --title "$RELEASE_TITLE" --notes-file "$notes_file" "--latest=${latest}")
  if [[ -n "$target" ]]; then args+=(--target "$target"); else args+=(--verify-tag); fi

  if [[ "$DRY_RUN" == "true" ]]; then
    echo "  [dry-run] would create release ${tag} (target: ${target:-existing tag}, latest: ${latest})"
    sed 's/^/  | /' "$notes_file"
  else
    gh "${args[@]}"
    echo "  created release ${tag} (latest: ${latest})"
  fi
  [[ "$latest" == "true" ]] && latest_release_tag="$tag"
  rm -f "$notes_file"
}

for branch in $BRANCHES; do
  if [[ ! "$branch" =~ ^([0-9]+)\.([0-9]+)\.x$ ]]; then
    echo "::warning::Skipping '${branch}': not a <major>.<minor>.x release branch"
    continue
  fi
  prefix="v${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.0."
  echo "== ${branch} (tags ${prefix}N)"

  head_sha=$(gh api "repos/${REPO}/branches/${branch}" --jq '.commit.sha')

  # Existing build numbers for this version, ascending.
  numbers=$(gh api --paginate "repos/${REPO}/git/matching-refs/tags/${prefix}" --jq '.[].ref' \
    | sed -n "s|^refs/tags/${prefix//./\\.}\([0-9][0-9]*\)$|\1|p" | sort -n)
  last=$(printf '%s\n' "$numbers" | sed '/^$/d' | tail -n1)
  prev=$(printf '%s\n' "$numbers" | sed '/^$/d' | tail -n2 | head -n1)

  if [[ -z "$last" ]]; then
    create_release "${prefix}1" "$head_sha" "" "$head_sha"
    continue
  fi

  last_tag="${prefix}${last}"
  prev_tag=""
  [[ "$prev" != "$last" ]] && prev_tag="${prefix}${prev}"

  # A tag pushed manually without a release: publish its release first.
  if ! gh release view "$last_tag" --repo "$REPO" >/dev/null 2>&1; then
    echo "  ${last_tag} has no release"
    create_release "$last_tag" "" "$prev_tag" "$last_tag"
  fi

  status=$(gh api "repos/${REPO}/compare/${last_tag}...${head_sha}" --jq '.status')
  case "$status" in
    ahead)
      create_release "${prefix}$((last + 1))" "$head_sha" "$last_tag" "$head_sha"
      ;;
    identical|behind)
      echo "  head ${head_sha:0:7} already released in ${last_tag}"
      ;;
    *)
      echo "::warning::${branch} head ${head_sha:0:7} has ${status} from ${last_tag}; not releasing"
      ;;
  esac
done
