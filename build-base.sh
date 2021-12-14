#!/usr/bin/env bash

set -ex

NODE_VERSION=${1:-lts/fermium}

echo "node version: $NODE_VERSION"

echo "Removing possible leftovers"
rm -rf ./src/common/env
mkdir -p ./src/common/env

docker build \
--pull \
--no-cache \
-t taconsol/sakuli-base \
-f Dockerfile.sakuli-base . \
--build-arg=NODE_VERSION=${NODE_VERSION} \
--build-arg=BUILD_DATE=$(date +"%F")
