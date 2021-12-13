# Sakuli container with "headless" VNC session

This repository contains a Docker image with pre-installed headless VNC environment and Sakuli.


## Development

### Workstation setup
This project uses *dgoss* to verify the container setup and service functionality. Please follow the
[dgoss installation](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss#installation) instructions before you
start working.

## Automated builds

This repo uses [GitHub Actions](https://help.github.com/en/actions) to automate image builds.

`.github/workflows/build_latest.yml` contains the workflow to build, test and push a `latest` image which comes with Sakuli `@next` releases installed.

Two types of events trigger a build:

```
on:
  push:
    branches: [develop]
  repository_dispatch:
    types: [build-latest]
```

- `push`: Whenever a changes are pushed to `develop` a new workflow run gets triggered
- `repository_dispatch`: This event will be triggered from external sources, e.g. once our Travis build finished and published a new `@next` of Sakuli. This event will be triggered via webhook, as can be seen in the `trigger-image-build` stage of our Travis pipeline in [sakuli/sakuli](https://github.com/sakuli/sakuli).

The workflow itself re-uses the `build-latest.sh` script, so the overall process to build the image does not differ from building it locally.
