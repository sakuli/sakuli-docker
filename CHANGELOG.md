# Sakuli Docker change log

All notable changes to this project will be documented in this file.

## Upcoming Release

- Enhancement: Add ip-utils and curl for debugging purposes [(#79)](https://github.com/sakuli/sakuli-docker/issues/79)
- Feature: Redirect log output to stdout in container by default [(#70)](https://github.com/sakuli/sakuli-docker/issues/70)
- Bugfix: Running container mode suppresses test suite execution [(#61)](https://github.com/sakuli/sakuli-docker/issues/61)


## v2.4.0-1

- Bugfix: Container does not sync sakuli project - just test suite [(#66)](https://github.com/sakuli/sakuli-docker/issues/66)
- Bugfix: container return code not working [(#65)](https://github.com/sakuli/sakuli-docker/issues/65)

## v2.4.0

- Feature: Clone git repo on container startup [(#19)](https://github.com/sakuli/sakuli-docker/issues/19)
- Bugfix: Stop running tests using `npm --prefix...` [(#53)](https://github.com/sakuli/sakuli-docker/issues/53)
- Bugfix: Missing Typescript support in container [(#47)](https://github.com/sakuli/sakuli-docker/issues/47)

## v2.3.0

- Feature: Install Prometheus forwarder [(#44)](https://github.com/sakuli/sakuli-docker/issues/44)
- Bugfix: Don't set NODE_NO_WARNINGS=1 globally [(#18)](https://github.com/sakuli/sakuli-docker/issues/18)
- Enhancement: Update Container to use Node 12 [(#32)](https://github.com/sakuli/sakuli-docker/issues/32)
- Bugfix: group id in container is 0 [(#37)](https://github.com/sakuli/sakuli-docker/issues/37)
- Bugfix: terminal pops up sometimes [(#17)](https://github.com/sakuli/sakuli-docker/issues/17)
- Feature: Enable importing custom CAs [(#13)](https://github.com/sakuli/sakuli-docker/issues/13)

## v2.2.0 (Initial Version)

- Bugfix: Desktop fails to start properly and causes test failures [(#7)](https://github.com/sakuli/sakuli-docker/issues/7)
- Feature: Add git to image [(#2)](https://github.com/sakuli/sakuli-docker/pull/2)