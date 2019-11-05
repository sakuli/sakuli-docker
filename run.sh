#!/bin/bash

docker run \
    --rm \
    -it \
    -e SAKULI_LICENSE_KEY=${SAKULI_LICENSE} \
    -p 5902:5901 \
    -p 6902:6901 \
    taconsol/sakuli-openbox:2.1.3
