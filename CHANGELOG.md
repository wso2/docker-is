# Changelog
All notable changes to this project 5.5.x per each release will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [v2.5.0.8] - 2020-07-20

### Changed
- In the current Docker image build process it is instructed to copy the relevant JDK, Product pack and the MySQL JDBC connector to the file directory and in the Dockerfile its copying the files from the file directory. In order to compatible with WSO2 Docker image create automation process, this has been changed to get the product pack from WUM, JDK from the Jenkins and MySQL from the Maven central repository.

- Change the name of the ENTRYPOINT script as docker-entrypoint.sh

### Removed
- Remove copying the JDK, product pack and other libraries from file directory.

## [v5.5.0.7] - 2018-09-18

### Added
Introduced crypto-tool utility to the <CARBON_HOME>/bin directory to encrypt the secondary userstore password.

### Changed
- Refinements to existing Dockerfiles.

### Compatibility with kubernetes-is releases
- If you are to use images built using this release with the latest v5.5.0.4 Kubernetes release, please do change
your deployment mount paths appropriately to match above folder changes.<br><br>

## [v5.5.0.6] - 2018-08-24

### Changed
- Refinements to existing Dockerfiles and Docker image entrypoint scripts' content structure.

### Fixed
- Missing changes to the folder structure made in release v5.5.0.5 and introduction of a grace period
to test the availability of volume mounts in Alpine based Docker image of WSO2 Identity Server Analytics
(fixes [issue 89](https://github.com/wso2/docker-is/issues/89)).

### Compatibility with kubernetes-is releases
- If you are to use images built using this release with the latest v5.5.0.4 Kubernetes release, please do change
your deployment mount paths appropriately to match above folder changes.<br><br>

## [v5.5.0.5] - 2018-08-17
### Added
- CentOS based Dockerfile for Identity Server v5.5.0
- CentOS based Dockerfile for Identity Server Analytics v5.5.0
- Alpine and OpenJDK based Dockerfile for Identity Server v5.5.0
- Alpine and OpenJDK based Dockerfile for Identity Server Analytics v5.5.0

### Changed
- Changed the folders to which configuration files with new changes to be copied are mounted.
Originally this was <br>"wso2-volume" in general and for Kubernetes, this was
"kubernetes-volumes". But with this release, there will not be <br>any platform specific
folders for mounting configuration files. Instead we are introducing a single folder
for this purpose by the name, "wso2-config-volume".

- Changed the folder to which any other non-configuration type artifacts to be copied are mounted.
Originally this was "wso2-volume". But with this release, this is changed to "wso2-artifact-volume".

### Compatibility with kubernetes-is releases
- If you are to use images built using this release with the latest v5.5.0.4 Kubernetes release, please do change
your deployment mount paths appropriately to match above folder changes.

[v5.5.0.5]: https://github.com/wso2/docker-is/compare/v5.5.0.4...v5.5.0.5
[v5.5.0.6]: https://github.com/wso2/docker-is/compare/v5.5.0.5...v5.5.0.6
[v5.5.0.7]: https://github.com/wso2/docker-is/compare/v5.5.0.6...v5.5.0.7
[v5.5.0.8]: https://github.com/wso2/docker-is/compare/v5.5.0.7...v5.5.0.8
