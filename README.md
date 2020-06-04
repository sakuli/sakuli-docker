# Sakuli container with "headless" VNC session

This repository contains a Docker image with pre-installed headless VNC environment and Sakuli.


## Development

### Workstation setup
This project uses *dgoss* to verify the container setup and service functionality. Please follow the
[dgoss installation](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss#installation) instructions before you
start working.

### Scripts
There are several scripts performing useful tasks to enhance development experience. Here is a short overview of the
provided functionality.

| Script         | Description                                                                  |
|----------------|------------------------------------------------------------------------------|
| set_version.sh | Sets the version of the project. Should always match the Sakuli version used.|

#### Sakuli license
To use these scripts, it is required to set the [`SAKULI_LICENSE_KEY` environment variable](https://sakuli.io/docs/enterprise/)
containing a valid Sakuli license of size M or above. To obtain such a license, please visit the
[Sakuli license](https://confluence.consol.de/x/zwBoBw) page in confluence and choose one of the licenses for internal
use.

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
- `repository_dispatch`: This event will be triggered from external sources, e.g. once our Travis build finished and published a new `@next` of Sakuli.

The workflow itself re-uses the `build-latest.sh` script, so the overall process to build the image does not differ from building it locally.
