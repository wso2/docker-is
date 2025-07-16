# Changelog
All notable changes to Docker and Docker Compose resources for WSO2 Identity Server version `5.10.x` in each resource release,
will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [v5.10.0.25] - 2025-07-16

### Changed
- Update jdk8u362-b09 to jdk8u452-b09

## [v5.10.0.23] - 2024-12-18

### Changed
- Update alpine version 3.16 to 3.20.3

## [v5.10.0.17] - 2023-01-30

### Changed
- Update jdk-11.0.14+9 and jdk-11.0.13+8 to jdk-11.0.18+10 and jdk8u322-b06 to jdk8u362-b09

## [v5.10.0.16] - 2022-07-01

### Changed
- Update mysql-connector-java version to 8.0.29

## [v5.10.0.15] - 2022-04-28

### Changed
- Update kubernetes-membership-scheme library to 1.0.9.

## [v5.10.0.14] - 2022-03-09

### Changed
- Changed base image of dockerfiles to an OS image and installed relevant JDK on it, instead of using a JDK installed OS image. 

## [v5.10.0.13] - 2022-01-20

### Changed
- Remove redundant jdk11 dockerfile directory.

## [v5.10.0.9] - 2021-12-13

### Changed
- Add alpine, ubuntu and centos dockerfiles to dockerfiles directory for backward comfortability.

## [v5.10.0.8] - 2021-11-17

### Changed
- Change folder structure of dockerfile locations and introduced separate images for jdk8 and jdk11 (refer to [issue](https://github.com/wso2/docker-is/issues/306)

## [v5.10.0.7] - 2021-08-18

### Changed
- Upgrade base docker image to fix the detected high security vulnerability. (refer to [issue](https://github.com/wso2/docker-is/issues/302)

## [v5.10.0.6] - 2021-02-23

### Changed
- Upgrade base docker image to fix the detected high security vulnerability. (refer to [issue](https://github.com/wso2/docker-is/issues/271))

## [v5.10.0.5] - 2020-11-27

### Changed
- Upgrade AdoptOpenJDK 11 version to the latest version - `11.0.9_11-jdk` (refer to [issue](https://github.com/wso2/docker-is/issues/261))

## [v5.10.0.4] - 2020-11-20

### Added
- Add git release tag as a label (refer to [issue](https://github.com/wso2/docker-is/issues/220))

### Changed
- Enable SSL verification when retrieving remote resources using wget (refer to [issue](https://github.com/wso2/docker-is/issues/219))

## [v5.10.0.3] - 2020-07-23

### Added
- Upgrade the AdoptOpenJDK 11 update version to the latest for each base OS platform - `11.0.8_10-jdk`
- Package the latest version of Kubernetes Membership Scheme - `1.0.7`

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.10.0.3](https://github.com/wso2/docker-is/milestone/13).

## [v5.10.0.2] - 2020-06-12

### Added
- Upgrade the AdoptOpenJDK 11 update version to the latest for each base OS platform
- Add database tables required for consent management in Docker Compose resources

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.10.0.2](https://github.com/wso2/docker-is/milestone/12).

## [v5.10.0.1] - 2020-03-20

### Added
- Per profile Docker resources of WSO2 Identity Server v5.10.x for Alpine, CentOS and Ubuntu
- Docker Compose resources for WSO2 Identity And Access Management (IAM) deployment

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.10.0.1](https://github.com/wso2/docker-is/milestone/10).

[v5.10.0.14]: https://github.com/wso2/docker-is/compare/v5.10.0.13...v5.10.0.14
[v5.10.0.13]: https://github.com/wso2/docker-is/compare/v5.10.0.12...v5.10.0.13
[v5.10.0.12]: https://github.com/wso2/docker-is/compare/v5.10.0.11...v5.10.0.12
[v5.10.0.11]: https://github.com/wso2/docker-is/compare/v5.10.0.10...v5.10.0.11
[v5.10.0.10]: https://github.com/wso2/docker-is/compare/v5.10.0.9...v5.10.0.10
[v5.10.0.9]: https://github.com/wso2/docker-is/compare/v5.10.0.8...v5.10.0.9
[v5.10.0.8]: https://github.com/wso2/docker-is/compare/v5.10.0.7...v5.10.0.8
[v5.10.0.7]: https://github.com/wso2/docker-is/compare/v5.10.0.6...v5.10.0.7
[v5.10.0.6]: https://github.com/wso2/docker-is/compare/v5.10.0.5...v5.10.0.6
[v5.10.0.5]: https://github.com/wso2/docker-is/compare/v5.10.0.4...v5.10.0.5
[v5.10.0.4]: https://github.com/wso2/docker-is/compare/v5.10.0.4...v5.10.0.4
[v5.10.0.3]: https://github.com/wso2/docker-is/compare/v5.10.0.2...v5.10.0.3
[v5.10.0.2]: https://github.com/wso2/docker-is/compare/v5.10.0.1...v5.10.0.2
[v5.10.0.1]: https://github.com/wso2/docker-is/compare/v5.9.0.3...v5.10.0.1
