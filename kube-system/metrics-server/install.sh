#!/bin/bash

# Current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

RELEASE="metrics-server"
NAMESPACE="kube-system"

helm upgrade --install $RELEASE stable/metrics-server \
    --namespace $NAMESPACE \
    --values $SCRIPT_DIR/values.yaml