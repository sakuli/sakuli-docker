#!/usr/bin/env bash

set -ex

NODE_VERSION=${1:-lts/erbium}

echo "node version: $NODE_VERSION"

echo "Running obfuscator"
npm --prefix ./license-validator ci
echo "Removing possible leftovers"
rm -rf ./src/common/env
mkdir -p ./src/common/env
echo "Copy files"
cp -rf ./license-validator/dist/index.js ./src/common/env/startup.js
cp -rf ./license-validator/node_modules ./src/common/env/node_modules

docker build \
--pull \
--no-cache \
-t taconsol/sakuli-base \
-f Dockerfile.sakuli-base . \
--build-arg=NODE_VERSION=${NODE_VERSION} \
--build-arg=BUILD_DATE=$(date +"%F")
