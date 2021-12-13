#!/usr/bin/env bash

set -ex

dgoss run \
    taconsol/sakuli:${1:-latest}

# standard use case
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project/e2e-suite \
    -v $(pwd)/e2e:/sakuli-project \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

# standard use case in DEBUG mode
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project/e2e-suite \
    -e DEBUG=true \
    -v $(pwd)/e2e:/sakuli-project \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

# use case with altered user and group
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project/e2e-suite \
    -v $(pwd)/e2e:/sakuli-project \
    -u 45678:12345 \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

# git clone use case
docker run \
    --rm \
    -e GIT_URL=https://github.com/sakuli/sakuli.git \
    -e GIT_CONTEXT_DIR=packages/e2e/ \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

# ensure exit code on error
set +e
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project/e2e-broken \
    -v $(pwd)/e2e:/sakuli-project \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}
[[ "$?" == "0" ]] && echo "Expected error code != 0" && exit 1
set -e

# should not fail if license is provided
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project/e2e-suite \
    -e SAKULI_LICENSE_KEY="asdf42#0815" \
    -v $(pwd)/e2e:/sakuli-project \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

# start another command than sakuli
docker run \
    --rm \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest} \
    "echo success!"

# start with different user and another command than sakuli
docker run \
    --rm \
    --shm-size=2G \
    -u 45678:12345 \
    taconsol/sakuli:${1:-latest}  \
    "echo success!"

# start with project referenced in SAKULI_TEST_SUITE
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project \
    -v $(pwd)/e2e:/sakuli-project \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

# install 3rd party packages before executing Sakuli
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project/e2e-puppeteer \
    -e INSTALL_PACKAGES=true \
    -v $(pwd)/e2e:/sakuli-project \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

# OCR run
docker run \
    --rm \
    -e SAKULI_TEST_SUITE=/sakuli-project/e2e-ocr \
    -v $(pwd)/e2e:/sakuli-project \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}