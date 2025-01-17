#!/usr/bin/env bash

set -eo pipefail

if ! [ -x "$(command -v uv)" ]; then
	echo "uv is not installed"
	exit 1
fi

if ! [ -x "$(command -v fzf)" ]; then
	echo "fzf is not installed"
	exit 1
fi

select_python_version() {
	uv python list | \
        mawk '{ split($0, arr); print arr[1] }' | \
        fzf
}

setup_pyright() {
echo "
[tool.pyright]
exclude=[ \".venv\" ]
venvPath=\".\"
venv=\".venv\"" >> pyproject.toml
}

read -p "Name: " venv_name; \
    selected_version=$(select_python_version); \
    uv init --no-workspace --name "$venv_name" "$venv_name" --python "$selected_version"; \
    cd "$PWD/$venv_name"; \
    uv venv; \
    setup_pyright; \
    echo "source ./.venv/bin/active" > .envrc
