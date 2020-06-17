#!/bin/bash

# Current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..

docker build . -t registry.digitalocean.com/streetbot/coturn:latest

doctl registry login
docker push registry.digitalocean.com/streetbot/coturn:latest

