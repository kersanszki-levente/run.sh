#!/usr/bin/env bash

set -eo pipefail

if ! [ -x "$(command -v fzf)" ]; then
	echo >&2 "fzf is not installed"
	exit 1
fi

RUN_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

select_script() {
	available_scripts=$(find "$RUN_DIR/shared" "$RUN_DIR/local" -name "*.sh" -type f)
	echo "$available_scripts" | fzf --cycle -d "/" --with-nth=-1
}

selected=$(select_script)
# execute
"$selected"
