#!/usr/bin/env bash

set -ex

dgoss run \
    -e SAKULI_LICENSE_KEY=${SAKULI_LICENSE_KEY} \
    taconsol/sakuli:${1:-latest}
