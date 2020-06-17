#!/bin/bash
# Current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

RELEASE="ingress"
NAMESPACE="nginx"

# Internally defined variables
VALUES=$SCRIPT_DIR/values.yaml

# Kubectl actions
kubectl create ns $NAMESPACE

# Helm actions
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade \
  --install $RELEASE bitnami/nginx-ingress-controller \
	--namespace $NAMESPACE \
	-f $VALUES