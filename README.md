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
