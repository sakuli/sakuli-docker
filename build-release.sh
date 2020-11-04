#!/usr/bin/env bash

set -ex

SAKULI_VERSION=${1:-2.4.0}
NPM_TOKEN=${2:-549ada59-bb56-4c22-ac54-1d3ec05d6a4d}

echo "Sakuli version: $SAKULI_VERSION"
echo "npm token: $NPM_TOKEN"

docker build \
--no-cache \
-t taconsol/sakuli:${SAKULI_VERSION} \
-f Dockerfile.sakuli . \
--build-arg=SAKULI_VERSION=${SAKULI_VERSION} \
--build-arg=NPM_ACCESS_TOKEN=${NPM_TOKEN} \
--build-arg=BUILD_DATE=$(date +"%F")

cd ./.test/
chmod u+x test.sh
./test.sh
cd -
