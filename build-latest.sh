#!/bin/bash

npm --prefix ./license-validator ci
rm -rf ./src/common/env
mkdir -p ./src/common/env
cp -rf ./license-validator/dist/index.js ./src/common/env/startup.js
cp -rf ./license-validator/node_modules ./src/common/env/node_modules

docker build \
--no-cache \
-t taconsol/sakuli \
-f Dockerfile.sakuli-ubuntu-openbox . \
--build-arg=SAKULI_VERSION=next \
--build-arg=NPM_ACCESS_TOKEN=b7fc5d41-1dbe-49f6-ba30-d74682ee0b6a \
--build-arg=NODE_VERSION=lts/erbium

cd ./.test/
sh test.sh latest
cd -
