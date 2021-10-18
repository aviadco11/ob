#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

docker-compose up -d
sleep 7
