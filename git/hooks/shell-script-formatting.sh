#!/bin/sh

exec 1>&2

detected=$(find . -name "*.sh" -type f -exec bash -c 'shellharden --check "$1" &>/dev/null || echo "$1"' none {} \;)

if [ "$detected" = "" ]; then
    exit 0
else
    echo "$detected" | xargs shellharden --replace
    echo "Reformatted ""$(echo "$detected" | wc -l) files"
    exit 1
fi
