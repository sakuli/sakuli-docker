#!/bin/bash

docker build \
-t taconsol/sakuli:2.1.2 \
-f Dockerfile.sakuli-ubuntu-xfce . \
--build-arg=SAKULI_VERSION=2.1.2 \
--build-arg=FIREFOX_VERSION=69.0+build2-0ubuntu0.18.04.1 \
--build-arg=CHROMIUM_VERSION=76.0.3809.100-0ubuntu0.18.04.1 \
--build-arg=CHROMEDRIVER=76 \
--build-arg=GECKODRIVER=1.16.2 \
--build-arg=NPM_ACCESS_TOKEN=b7fc5d41-1dbe-49f6-ba30-d74682ee0b6a
