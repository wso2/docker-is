# Changelog
All notable changes to this project 5.9.x per each release will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [v5.9.0.7] - 2023-01-31

### Changed
- Update jdk8u322-b06 to jdk8u362-b09

## [v5.9.0.6] - 2022-07-01

### Changed
- Update mysql-connector-java version to 8.0.29

## [v5.9.0.5] - 2022-03-10

### Added
-Changed base image of dockerfiles to an OS image and installed relevant JDK on it, instead of using a JDK installed OS image.

## [v5.9.0.4] - 2020-11-25

### Added
- Add git release tag as a label (refer to [issue](https://github.com/wso2/docker-is/issues/224))

### Changed
- Enable SSL verification when retrieving remote resources using wget (refer to [issue]https://github.com/wso2/docker-is/issues/223))

## [v5.9.0.3] - 2020-03-12

### Changed
- Align Docker Compose resources with WSO2 Software License (WSL).
- Set Docker Compose resources to use WSO2 Private Docker Registry Docker images, by default.

## [v5.9.0.2] - 2020-01-21

### Fixed
- Fix MySQL connector jar download URL in v5.9.0 

## [v5.9.0.1] - 2019-10-11

### Added
- Per profile Docker resources of WSO2 Identity Server v5.9.x for Alpine, CentOS and Ubuntu
- Docker Compose resources for WSO2 Identity And Access Management (IAM) deployment patterns

### Changed
- Use AdoptOpenJDK version `jdk8u222-b10` in Alpine, CentOS, Ubuntu based Docker resources

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.9.0.1](https://github.com/wso2/docker-is/milestone/8).

[v5.9.0.2]: https://github.com/wso2/docker-is/compare/v5.9.0.1...v5.9.0.2
[v5.9.0.3]: https://github.com/wso2/docker-is/compare/v5.9.0.2...v5.9.0.3
[v5.9.0.4]: https://github.com/wso2/docker-is/compare/v5.9.0.3...v5.9.0.4
[v5.9.0.5]: https://github.com/wso2/docker-is/compare/v5.9.0.4...v5.9.0.5