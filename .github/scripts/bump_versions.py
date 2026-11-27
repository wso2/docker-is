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

Every JSON object that has one value equal to "<line>" and another of the form "<line>.<N>" gets
that second value raised to <version> (e.g. each image built from the same release line). Lines with
no matching object are skipped and a version is never lowered. Only the selected values' text is
replaced, so the rest of the file keeps its formatting, and the result is checked to differ from the
original only in the intended values. Prints "<line> <old> -> <new>" once per distinct change.
"""
import copy
import json
import re
import sys

_WS = re.compile(r"[ \t\n\r]*")
_STRING = re.compile(r'"(?:[^"\\]|\\.)*"')
_LITERAL = re.compile(r"-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?|true|false|null")


class Node:
    """A JSON value with its location in the source text and its path from the root."""

    def __init__(self, path, start):
        self.path, self.start, self.end = path, start, start
        self.items = None  # object: list of (key, Node)
        self.elements = None  # array: list of Node
        self.value = None  # scalar value


def parse(text, i=0, path=()):
    """Parse the JSON value at text[i:] (already validated by json.loads) into Nodes."""
    i = _WS.match(text, i).end()
    node = Node(path, i)
    char = text[i]
    if char in "{[":
        closing = "}" if char == "{" else "]"
        children = []
        i = _WS.match(text, i + 1).end()
        while text[i] != closing:
            if char == "{":
                key = _STRING.match(text, i)
                i = _WS.match(text, key.end()).end() + 1  # past ':'
                name = json.loads(key.group())
                child = parse(text, i, path + (name,))
                children.append((name, child))
            else:
                child = parse(text, i, path + (len(children),))
                children.append(child)
            i = _WS.match(text, child.end).end()
            if text[i] == ",":
                i = _WS.match(text, i + 1).end()
        if char == "{":
            node.items = children
        else:
            node.elements = children
        node.end = i + 1
    else:
        match = (_STRING if char == '"' else _LITERAL).match(text, i)
        node.value, node.end = json.loads(match.group()), match.end()
    return node


def objects(node):
    """Yield every object node in the tree, depth first."""
    if node.items is not None:
        yield node
        children = [child for _, child in node.items]
    else:
        children = node.elements or []
    for child in children:
        yield from objects(child)


def string_children(obj):
    return [(key, child) for key, child in obj.items if isinstance(child.value, str)]


def version_key(version):
    return tuple(int(part) for part in version.split("."))


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    path, pairs = sys.argv[1], sys.argv[2:]

    with open(path, encoding="utf-8") as f:
        text = f.read()
    try:
        data = json.loads(text)
    except ValueError:
        sys.exit("the target file is not valid JSON")
    root = parse(text)

    expected = copy.deepcopy(data)
    edits = []  # (start, end, replacement text)
    for pair in pairs:
        line, _, new = pair.partition("=")
        release = re.compile(r"^%s\.\d+$" % re.escape(line))
        matches = []
        for obj in objects(root):
            strings = string_children(obj)
            if not any(child.value == line for _, child in strings):
                continue
            versions = [child for _, child in strings if release.match(child.value)]
            if len(versions) == 1:
                matches.append(versions[0])
        reported = set()
        for target in matches:
            if version_key(new) <= version_key(target.value):
                continue
            edits.append((target.start, target.end, json.dumps(new)))
            parent = expected
            for step in target.path[:-1]:
                parent = parent[step]
            parent[target.path[-1]] = new
            if target.value not in reported:
                reported.add(target.value)
                print(f"{line} {target.value} -> {new}")

    if not edits:
        return
    for start, end, replacement in sorted(edits, reverse=True):
        text = text[:start] + replacement + text[end:]
    if json.loads(text) != expected:
        sys.exit("verification failed: the edited file does not match the intended changes")
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)


if __name__ == "__main__":
    main()
