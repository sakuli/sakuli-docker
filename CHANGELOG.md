# Sakuli Docker change log

All notable changes to this project will be documented in this file.

### next


### 3.0.0
- Maintenance: Open Source [(#111)](https://github.com/sakuli/sakuli-docker/issues/111)
- Maintenance: Use node 16 in container

### 2.5.1
- security fixes
- Enhancement: german locale [(#108)](https://github.com/sakuli/sakuli-docker/issues/108)

## v2.5.0

- Enhancement: Add ip-utils and curl for debugging purposes [(#79)](https://github.com/sakuli/sakuli-docker/issues/79)
- Feature: Redirect log output to stdout in container by default [(#70)](https://github.com/sakuli/sakuli-docker/issues/70)
- Enhancement: Create separate sakuli docker base image [(#77)](https://github.com/sakuli/sakuli-docker/issues/77)
- Enhancement: Merge Sakuli logs instead of overwriting them [(#88)](https://github.com/sakuli/sakuli-docker/issues/88)
- Enhancement: Update 3rd party packages automatically  [(#80)](https://github.com/sakuli/sakuli-docker/issues/80)
- Maintenance: Use node 14 in container  [(#82)](https://github.com/sakuli/sakuli-docker/issues/82)
- Feature: Enable package installation [(#48)](https://github.com/sakuli/sakuli-docker/issues/48)
- Enhancement: Link log files instead of copying them [(#98)](https://github.com/sakuli/sakuli-docker/issues/98)
- Feature: Add ocr module to docker [(sakuli/sakuli-ocr#7)](https://github.com/sakuli/sakuli-ocr/issues/7)
- Maintenance: Update TigerVNC to latest version [(#95)](https://github.com/sakuli/sakuli-docker/issues/95)
- Maintenance: update typescript to match sakuli version [(#104)](https://github.com/sakuli/sakuli-docker/issues/104)

## v2.4.0-2

- Bugfix: Only sync required test suite on start + Only sync _logs back at the end [(#74)](https://github.com/sakuli/sakuli-docker/issues/74)
- Bugfix: Running container mode suppresses test suite execution [(#61)](https://github.com/sakuli/sakuli-docker/issues/61)
- Bugfix: Start container with different command AND different user [(#75)](https://github.com/sakuli/sakuli-docker/issues/75)
- Bugfix: dont rsync / if SAKULI_TEST_SUITE is the same location than test project [(#76)](https://github.com/sakuli/sakuli-docker/issues/76)
- Bugfix: [dont rsync / ...](https://github.com/sakuli/sakuli-docker/issues/76) broke sakuli S2I contract [(#90)](https://github.com/sakuli/sakuli-docker/issues/90)

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