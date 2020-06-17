 #!/bin/bash

# Current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

RELEASE="cert-manager"
NAMESPACE="cert-manager"

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Create new namespace
kubectl create ns $NAMESPACE

# Apply CRDs
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.15.0/cert-manager.crds.yaml

# Install the cert-manager Helm chart
helm upgrade --install $RELEASE jetstack/cert-manager \
    --version v0.15.0 \
    --namespace $NAMESPACE \
    --values $SCRIPT_DIR/values.yaml 

echo "Waiting for 60s for the pods to become ready..."
sleep 60

# Install clusterissuer
kubectl apply -f $SCRIPT_DIR/production-issuer.yaml