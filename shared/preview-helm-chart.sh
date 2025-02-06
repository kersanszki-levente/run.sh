#!/usr/bin/env bash

set -eo pipefail

if ! [ -x "$(command -v helm)" ]; then
	echo "helm is not installed"
	exit 1
fi

if ! [ -x "$(command -v yq)" ]; then
	echo "yq is not installed"
	exit 1
fi

if ! [ -x "$(command -v rg)" ]; then
	echo "rg is not installed"
	exit 1
fi

if ! [ -x "$(command -v fzf)" ]; then
	echo "fzf is not installed"
	exit 1
fi

CHART_NAME="$(cat Chart.yaml | yq '.name')"
helm template . | \
    rg -e "# Source: $CHART_NAME/(.*)" --replace '$1' | \
    fzf --no-multi --cycle --preview="helm template -s {} . | cat"
