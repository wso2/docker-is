# Changelog

All notable changes to Docker and Docker Compose resources for WSO2 Identity and Management version `5.11.x`
in each resource release, will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [v5.11.0.18] - 2023-01-26

### Changed
- Update jdk 11 to jdk-11.0.18+10 and jdk 8 to jdk8u362-b09

## [v5.11.0.17] - 2022-11-21

### Changed
- Update kubernetes-membership-scheme library to 1.0.10

## [v5.11.0.16] - 2022-09-14

### Changed
- Forcefully install glibc to jkd8 alpine docker images.

## [v5.11.0.15] - 2022-06-20

### Changed
- Update alpine base docker image version to 3.16

## [v5.11.0.14] - 2022-06-09

### Changed
- Update mysql-connector-java version to 8.0.29

## [v5.11.0.13] - 2022-04-11

### Changed
- Update alpine base image to 3.15.

## [v5.11.0.12] - 2022-04-08

### Changed
- Update alpine base image.
- Update kubenetes-membership-scheme library to 1.0.9.

## [v5.11.0.11] - 2022-03-08

### Changed
- Changed base image of dockerfiles to an OS image and installed relevant JDK on it, instead of using a JDK installed OS image.

## [v5.11.0.9] - 2022-01-20

### Changed
- Remove redundant jdk11 dockerfile folder.

## [v5.11.0.8] - 2021-12-13

### Changed
- Add alpine, ubuntu and centos dockerfiles to dockerfiles directory for backward comfortability.

## [v5.11.0.6] - 2021-11-17

### Changed
- Change folder structure of dockerfile locations and introduced separate images for jdk8 and jdk11 (refer to [issue](https://github.com/wso2/docker-is/issues/306)

## [v5.11.0.5] - 2021-08-16

### Changed
- Upgrade base docker image to fix the detected high security vulnerability. (refer to [issue](https://github.com/wso2/docker-is/issues/299)

## [v5.11.0.3] - 2021.07.16

### Changed

- Update kubernetes common version.

## [v5.11.0.2] - 2021.06.03

### Changed

- Update Docker OS base image.

## [v5.11.0.1] - 2020.12.03

### Added

- Docker resources of WSO2 Identity Server version `5.11.0` for Alpine, CentOS and Ubuntu (refer to [issue](https://github.com/wso2/docker-is/issues/238))

### Removed

- Avoid packaging MySQL JDBC Driver in Identity Server Docker images (refer to [issue](https://github.com/wso2/docker-is/issues/242))

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.11.0.1](https://github.com/wso2/docker-is/milestone/22).

[v5.11.0.1]: https://github.com/wso2/docker-is/compare/v5.10.0.3...v5.11.0.1
[v5.11.0.2]: https://github.com/wso2/docker-is/compare/v5.11.0.1...v5.11.0.2
[v5.11.0.3]: https://github.com/wso2/docker-is/compare/v5.11.0.2...v5.11.0.3

## [v5.11.0.10] - 2022.02.25

### Changed
- Upgrade base docker image to Ubuntu20.04 and added Adoptium JDK jdk8u312-b07 in IS 5.11.0
- Upgrade base docker image to Ubuntu20.04 and added Adoptium JDK jdk-11.0.13+8 in IS 5.11.0
