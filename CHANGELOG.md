# Changelog

All notable changes to Docker and Docker Compose resources for WSO2 Identity and Management version `5.11.x`
in each resource release, will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [v5.11.0.2] - 2020.07.03

### Changed

- Upgrade base docker image to fix the detected high security vulnerability. (refer to [issue](https://github.com/wso2/docker-is/issues/277))

## [v5.11.0.1] - 2020.12.03

### Added

- Docker resources of WSO2 Identity Server version `5.11.0` for Alpine, CentOS and Ubuntu (refer to [issue](https://github.com/wso2/docker-is/issues/238))

### Removed

- Avoid packaging MySQL JDBC Driver in Identity Server Docker images (refer to [issue](https://github.com/wso2/docker-is/issues/242))

For detailed information on the tasks carried out during this release, please see the GitHub milestone
[v5.11.0.1](https://github.com/wso2/docker-is/milestone/22).

[v5.11.0.1]: https://github.com/wso2/docker-is/compare/v5.10.0.3...v5.11.0.1
[v5.11.0.2]: https://github.com/wso2/docker-is/compare/v5.11.0.1...v5.11.0.2
