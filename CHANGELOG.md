# Changelog
All notable changes to Docker and Docker Compose resources for WSO2 Identity Server version `5.10.x` in each resource release,
will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

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

[v5.10.0.5]: https://github.com/wso2/docker-is/compare/v5.10.0.4...v5.10.0.5
[v5.10.0.4]: https://github.com/wso2/docker-is/compare/v5.10.0.3...v5.10.0.4
[v5.10.0.3]: https://github.com/wso2/docker-is/compare/v5.10.0.2...v5.10.0.3
[v5.10.0.2]: https://github.com/wso2/docker-is/compare/v5.10.0.1...v5.10.0.2
[v5.10.0.1]: https://github.com/wso2/docker-is/compare/v5.9.0.3...v5.10.0.1
