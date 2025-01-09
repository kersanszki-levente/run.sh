#!/usr/bin/env bash

set -eo pipefail

if ! [ -x "$(command -v kubectl)" ]; then
	echo "kubectl is not installed"
	exit 1
fi

if ! [ -x "$(command -v fzf)" ]; then
	echo "fzf is not installed"
	exit 1
fi


select_namespace() {
    kubectl get namespaces | fzf | awk '{ print $1 }'
}

select_pod() {
    namespace="$1"
    kubectl get pods -n "$namespace" | fzf | awk '{print $1}'
}

namespace="$(select_namespace)"
pod="$(select_pod "$namespace")"
kubectl exec --stdin --tty "$pod" -n "$namespace" -- /bin/bash
