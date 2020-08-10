#!/usr/bin/env bash

set -ex

dgoss run \
    -e SAKULI_LICENSE_KEY=${SAKULI_LICENSE_KEY} \
    taconsol/sakuli:${1:-latest}

docker run \
    --rm \
    -e SAKULI_LICENSE_KEY=${SAKULI_LICENSE_KEY} \
    -e SAKULI_TEST_SUITE=/testsuite \
    -v $(pwd)/e2e:/testsuite \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

docker run \
    --rm \
    -e SAKULI_LICENSE_KEY=${SAKULI_LICENSE_KEY} \
    -e SAKULI_TEST_SUITE=/testsuite \
    -v $(pwd)/e2e:/testsuite \
    -u 45678:12345 \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}

docker run \
    --rm \
    -e SAKULI_LICENSE_KEY=${SAKULI_LICENSE_KEY} \
    -e GIT_URL=https://github.com/sakuli/sakuli.git \
    -e GIT_CONTEXT_DIR=packages/e2e \
    --shm-size=2G \
    taconsol/sakuli:${1:-latest}
