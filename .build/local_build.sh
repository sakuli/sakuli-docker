#!/usr/bin/env bash
set -e -o pipefail

## declare an array variable
dockerfiles=(
    "Dockerfile.sakuli-ubuntu-xfce"
)
tags=(
    "local/sakuli-ubuntu-xfce:dev"
)

len=${#dockerfiles[@]}

cd ..
## now loop through the above array
for ((i = 0; i < $len; i++)); do
    docker build -t "${tags[$i]}" -f "${dockerfiles[$i]}" .
done
