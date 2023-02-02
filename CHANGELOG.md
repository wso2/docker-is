# Changelog
All notable changes to this project 5.8.x per each release will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [v5.8.0.10] - 2023-02-01

### Changed
- Modified centos dockerfiles to have OS based base image and upgraded JDK 8 version in all dockerfiles.

## [v5.8.0.9] - 2022-04-28

### Changed
- Update centos base docker image to centos7 in IS Analytics 5.8.0.

## [v5.8.0.8] - 2022-01-18

### Changed
- Upgrade base docker image to Ubuntu20.04 and added Adoptium JDK jdk8u312-b07 in IS 5.8.0 and IS Analytics 5.8.0.

## [v5.8.0.7] - 2021-09-08

### Changed
- Upgrade base docker image to fix the detected high security vulnerability. (refer to [issue](https://github.com/wso2/docker-is/issues/304))

## [v5.8.0.6] - 2020-11-25

### Added
- Add git release tag as a label (refer to [issue](https://github.com/wso2/docker-is/issues/227))

### Changed
- Enable SSL verification when retrieving remote resources using wget (refer to [issue]https://github.com/wso2/docker-is/issues/228))

## [v5.8.0.4] - 2020-01-02

### Changed
- Package the latest version of Kubernetes Membership Scheme (`v1.0.7`) in WSO2 Identity Server Docker images.

## [v5.8.0.3] - 2018-08-28

### Added
- Package the Kubernetes Membership Scheme in Docker images for WSO2 Identity Server.

### Changed
- Use WSO2 product pack downloadable links to binaries available at JFrog Bintray.

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.8.0.3](https://github.com/wso2/docker-is/milestone/6).

## [v5.8.0.2] - 2019-06-19

### Added
- Add downloadable links for obtaining dependencies required to be available in Docker image build context
- Use Dockerfile LABEL construct for defining the maintainer

### Changed
- Fix incorrect MOTDs
- Remove temporarily persisted, default content of persistent runtime artifact folders
- Prevent prepackaging additional artifacts required for Kubernetes Membership Scheme
- Fix issue with container startup failure when Docker image indirect mount points are empty
- Fix issue with inability to access the WSO2 Identity Server dashboard portal

### Removed
- Remove WSO2 Identity Server Analytics base Docker resources for Alpine, CentOS and Ubuntu platforms.

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.8.0.2](https://github.com/wso2/docker-is/milestone/5).

## [v5.8.0.1] - 2018-05-24

### Added
- Per profile Docker resources of WSO2 Identity Server and Analytics v5.8.x for Alpine, CentOS and Ubuntu
- Docker Compose resources for WSO2 Identity And Access Management (IAM) deployment patterns
- Integrate support in Docker Compose resources for users with and without WSO2 subscriptions

### Changed
- Use AdoptOpenJDK version `jdk8u212-b03` in Alpine, CentOS, Ubuntu based Docker resources

[v5.8.0.4]: https://github.com/wso2/docker-is/compare/v5.8.0.3...v5.8.0.4
[v5.8.0.5]: https://github.com/wso2/docker-is/compare/v5.8.0.4...v5.8.0.5
