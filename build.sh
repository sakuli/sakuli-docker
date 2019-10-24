#!/bin/bash

npm --prefix ./license-validator ci
rm -rf ./src/common/env
mkdir -p ./src/common/env
cp -rf ./license-validator/dist/index.js ./src/common/env/startup.js
cp -rf ./license-validator/node_modules ./src/common/env/node_modules

docker build \
-t taconsol/sakuli-openbox:2.1.3 \
-f Dockerfile.sakuli-ubuntu-xfce . \
--build-arg=SAKULI_VERSION=2.1.3 \
--build-arg=NPM_ACCESS_TOKEN=b7fc5d41-1dbe-49f6-ba30-d74682ee0b6a

cd ./.test/
sh test.sh
cd -
