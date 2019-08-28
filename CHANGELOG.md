# Changelog
All notable changes to this project 5.8.x per each release will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

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

[v5.8.0.3]: https://github.com/wso2/docker-is/compare/v5.8.0.2...v5.8.0.3
