#!/bin/bash

doctl registry kubernetes-manifest --namespace utils | kubectl apply -f -
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-streetbot"}]}'
