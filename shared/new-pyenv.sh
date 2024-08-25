#!/usr/bin/env bash

set -eo pipefail

if ! [ -x "$(command -v pyenv)" ]; then
	echo "pyenv is not installed"
	exit 1
fi

if ! [ -x "$(command -v fzf)" ]; then
	echo "fzf is not installed"
	exit 1
fi

select_python_version() {
	pyenv install --list | fzf
}

create_venv() {
	pyenv virtualenv $1 $2; pyenv local $2; pyenv pyright
}

read -p "New venv name: " venv_name
selected_version=$(select_python_version)
create_venv "$selected_version" "$venv_name"
