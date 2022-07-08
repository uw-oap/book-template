#!/bin/sh

# Thanks https://stackoverflow.com/a/71765306

VERSION_STRING=$(
    git describe --tags --exact-match --match "v*.*.*" 2>/dev/null \
	|| git describe --match "v*.*.*" --tags 2>/dev/null \
	|| git describe --tags 2>/dev/null \
	|| git rev-parse HEAD )

if ! git diff --exit-code >/dev/null
then
    echo "$VERSION_STRING-unstaged"
elif ! git diff --cached --exit-code >/dev/null
then
    echo "$VERSION_STRING-uncommitted"
else
    echo $VERSION_STRING
fi
