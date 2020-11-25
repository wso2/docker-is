# Changelog
All notable changes to this project 5.6.x per each release will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [v5.6.0.2] - 2020-11-25

### Added
- Add git release tag as a label (refer to [issue](https://github.com/wso2/docker-is/issues/236))

### Changed
- Rename docker entrypoint script
- Download reosurces (i.e: product pack, db connector) from remote source with secured wget

For detailed information on the tasks carried out during this release, please see the GitHub milestone 
[v5.6.0.2](https://github.com/wso2/docker-is/milestone/21)

## Unreleased - 2018-08-23

### Added
- CentOS based Dockerfile for Identity Server v5.6.0
- CentOS based Dockerfile for Identity Server Analytics v5.6.0
- Alpine and OpenJDK based Dockerfile for Identity Server v5.6.0
- Alpine and OpenJDK based Dockerfile for Identity Server Analytics v5.6.0

### Changed
- Changed the folders to which configuration files with new changes to be copied are mounted. 
Originally this was <br>`wso2-server-volume` in general and for Kubernetes, the folder to which
ConfigMap volumes were to be mounted was `kubernetes-volumes`. But with this release, there will not be
any platform specific folders for mounting configuration files. Instead, we are introducing a single folder 
for this purpose by the name, `wso2-config-volume`. 

- Changed the folder to which any other non-configuration type artifacts to be copied are mounted.
Originally this was `wso2-server-volume`. But with this release, this is changed to `wso2-artifact-volume`.

### Compatibility with `wso2/kubernetes-is` releases
- If you are to use images built using this release with the latest v5.6.0.1 Kubernetes release, please do change
your deployment mount paths appropriately to match above folder changes.

[Unreleased]: https://github.com/wso2/docker-is/compare/v5.6.0.1...5.6.x
[v5.6.0.2]: https://github.com/wso2/docker-is/compare/v5.6.0.1...5.6.0.2