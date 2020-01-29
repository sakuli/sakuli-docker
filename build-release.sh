#!/bin/bash

npm --prefix ./license-validator ci
rm -rf ./src/common/env
mkdir -p ./src/common/env
cp -rf ./license-validator/dist/index.js ./src/common/env/startup.js
cp -rf ./license-validator/node_modules ./src/common/env/node_modules

docker build \
--no-cache \
-t taconsol/sakuli:2.2.0 \
-f Dockerfile.sakuli-ubuntu-openbox . \
--build-arg=SAKULI_VERSION=2.2.0 \
--build-arg=NPM_ACCESS_TOKEN=b7fc5d41-1dbe-49f6-ba30-d74682ee0b6a

cd ./.test/
sh test.sh 2.2.0
cd -
