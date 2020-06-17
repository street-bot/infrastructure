#!/bin/bash

if [[ -z "${AWS_ACCESS_KEY}" ]]; then
  echo -e "AWS_ACCESS_KEY is not defined as an environment variable!"
  exit 1
fi

if [[ -z "${AWS_SECRET_KEY}" ]]; then
  echo -e "AWS_SECRET_KEY is not defined as an environment variable!"
  exit 1
fi

# Current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

RELEASE="external-dns"
NAMESPACE="utils"

kubectl create ns $NAMESPACE

helm upgrade --install $RELEASE bitnami/external-dns \
    --namespace $NAMESPACE \
    --values $SCRIPT_DIR/values.yaml \
    --set aws.credentials.secretKey=$AWS_SECRET_KEY \
    --set aws.credentials.accessKey=$AWS_ACCESS_KEY