#!/bin/bash

SAKULI_VERSION=${1:-2.3.0}
NPM_TOKEN=${2:-549ada59-bb56-4c22-ac54-1d3ec05d6a4d}
NODE_VERSION=${3:-lts/erbium}

echo "Sakuli version: $SAKULI_VERSION"
echo "npm token: $NPM_TOKEN"
echo "node version: $NODE_VERSION"

npm --prefix ./license-validator ci
rm -rf ./src/common/env
mkdir -p ./src/common/env
cp -rf ./license-validator/dist/index.js ./src/common/env/startup.js
cp -rf ./license-validator/node_modules ./src/common/env/node_modules

docker build \
--no-cache \
-t taconsol/sakuli:${SAKULI_VERSION} \
-f Dockerfile.sakuli-ubuntu-openbox . \
--build-arg=SAKULI_VERSION=${SAKULI_VERSION} \
--build-arg=NPM_ACCESS_TOKEN=${NPM_TOKEN} \
--build-arg=NODE_VERSION=${NODE_VERSION}

cd ./.test/
sh test.sh ${SAKULI_VERSION}
cd -
