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
"""Raise release version values in a JSON file.

Usage: bump_versions.py <file> <line>=<version> ...   e.g. 7.2.0=7.2.0.10

For each <line>, the single JSON object that has one value equal to "<line>" and another of the
form "<line>.<N>" gets that second value raised to <version>. Set SCOPE to limit the search to the
object holding a value equal to SCOPE. Lines with no matching object are skipped, a version is never
lowered, and a line matching more than one object is an error. The file's formatting is preserved,
and the result is checked to differ from the original only in the intended values.
Prints "<line> <old> -> <new>" for each change.
"""
import copy
import json
import os
import re
import sys


def version_key(version):
    return tuple(int(part) for part in version.split("."))


def walk(node):
    """Yield every object in the JSON tree."""
    if isinstance(node, dict):
        yield node
        children = node.values()
    elif isinstance(node, list):
        children = node
    else:
        return
    for child in children:
        yield from walk(child)


def key_with_value(obj, value):
    return next((k for k, v in obj.items() if v == value), None)


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    path, pairs = sys.argv[1], sys.argv[2:]
    scope = os.environ.get("SCOPE", "")

    with open(path, encoding="utf-8") as f:
        text = f.read()
    try:
        data = json.loads(text)
    except ValueError:
        sys.exit("the target file is not valid JSON")
    expected = copy.deepcopy(data)

    # Text region and parsed subtree to work in.
    region_start, region_end, root, expected_root = 0, len(text), data, expected
    if scope:
        holders = [i for i, obj in enumerate(walk(data)) if key_with_value(obj, scope) is not None]
        if len(holders) != 1:
            sys.exit(f"scope must match exactly one object, matched {len(holders)}")
        root = list(walk(data))[holders[0]]
        expected_root = list(walk(expected))[holders[0]]
        scope_key = key_with_value(root, scope)
        # The scope object's text runs from its scope entry to the next sibling's entry with the same key.
        entry = re.compile(r'"%s"\s*:\s*' % re.escape(scope_key))
        start = re.compile(entry.pattern + r'"%s"' % re.escape(scope)).search(text)
        region_start = start.end()
        following = entry.search(text, region_start)
        region_end = following.start() if following else len(text)

    region = text[region_start:region_end]
    targets = list(zip(walk(root), walk(expected_root)))
    for pair in pairs:
        line, _, new = pair.partition("=")
        release = re.compile(r"^%s\.\d+$" % re.escape(line))
        matches = []
        for obj, expected_obj in targets:
            if key_with_value(obj, line) is None:
                continue
            keys = [k for k, v in obj.items() if isinstance(v, str) and release.match(v)]
            if len(keys) == 1:
                matches.append((obj, expected_obj, keys[0]))
        if not matches:
            continue
        if len(matches) > 1:
            sys.exit(f"{line} matches {len(matches)} objects; set SCOPE to choose one")
        obj, expected_obj, key = matches[0]
        old = obj[key]
        if version_key(new) <= version_key(old):
            continue

        value = re.compile(r'("%s"\s*:\s*")%s(")' % (re.escape(key), re.escape(old)))
        region, count = value.subn(lambda m: m.group(1) + new + m.group(2), region)
        if count != 1:
            sys.exit(f"could not update {line}: expected 1 match, found {count}")
        expected_obj[key] = new
        print(f"{line} {old} -> {new}")

    if expected == data:
        return
    text = text[:region_start] + region + text[region_end:]
    if json.loads(text) != expected:
        sys.exit("verification failed: the edited file does not match the intended changes")
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)


if __name__ == "__main__":
    main()
