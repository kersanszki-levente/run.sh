#!/usr/bin/env bash

find . -name 'Cargo.toml' -type f -user "$UID" | \
    sed 's/Cargo.toml//g' | \
    find -name 'deps' -type d | \
    xargs du -h --max-depth 0 | \
    sort -h | \
    fzf --tac --cycle -m --print0 | \
    sed -z 's/.*\./\./g' | \
    xargs -0 -r rm -r
