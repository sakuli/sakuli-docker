#!/bin/bash

docker build \
-t consol/sakuli:2.1.2 \
-f Dockerfile.sakuli-ubuntu-xfce . \
--build-arg=SAKULI_VERSION=2.1.2 \
--build-arg=FIREFOX_VERSION=68.0.2+build1-0ubuntu0.18.04.1 \
--build-arg=CHROMIUM_VERSION=76.0.3809.100-0ubuntu0.18.04.1 \
--build-arg=CHROMEDRIVER=76 \
--build-arg=LICENSE_TOKEN=
--build-arg=NPM_TOKEN=
