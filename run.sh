#!/usr/bin/env bash

docker run \
    --rm \
    -it \
    -e SAKULI_LICENSE_KEY= \
    -p 5902:5901 \
    -p 6902:6901 \
    taconsol/sakuli:2.1.3
