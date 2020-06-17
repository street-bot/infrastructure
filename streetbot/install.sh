#!/bin/bash

kubectl apply -f namespace.yaml
doctl registry kubernetes-manifest --namespace streetbot | kubectl apply -f -
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-streetbot"}]}'
