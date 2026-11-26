#### ⚠️ DISCLAIMER

Use these artefacts as a reference to build your deployment artefacts. Existing artefacts only developed to demonstrate a reference deployment and should not be used as is in production

------------------------------------------------------------------

# Docker Resources for WSO2 Identity And Access Management

This repository contains following Docker resources:

- Per profile Docker resources of WSO2 Identity Server version `7.3.0` for Alpine, Rocky Linux and Ubuntu
- Docker Compose resources to evaluate most common Identity And Access Management (IAM) deployment patterns

Per profile Docker resources for WSO2 Identity Server help you build generic Docker images for deploying the
corresponding product servers in containerized environments. Each Docker image includes the JDK, the relevant product distribution
and a collection of utility libraries. Configurations, custom JDBC drivers, extensions and other deployable artifacts 
are designed to be provided via volume mounts to the containers spawned.

Docker Compose resources have been created according to the most common IAM deployment patterns available for allowing users
to quickly evaluate product features along side their co-operate IAM requirements. The Compose files make use of per profile
Docker images of WSO2 Identity Server and MySQL.

## Dockerfiles for each product version

Docker resources for each WSO2 Identity Server version are maintained in a separate branch of this repository.
Use the branch that matches the product version you want to deploy.

| Identity Server version | Branch |
|:-----------------------:|:------:|
| 7.3.0 | [7.3.x](https://github.com/wso2/docker-is/tree/7.3.x) |
| 7.2.0 | [7.2.x](https://github.com/wso2/docker-is/tree/7.2.x) |
| 7.1.0 | [7.1.x](https://github.com/wso2/docker-is/tree/7.1.x) |
| 7.0.0 | [7.0.x](https://github.com/wso2/docker-is/tree/7.0.x) |
| 6.1.0 | [6.1.x](https://github.com/wso2/docker-is/tree/6.1.x) |
| 6.0.0 | [6.0.x](https://github.com/wso2/docker-is/tree/6.0.x) |
| 5.11.0 | [5.11.x](https://github.com/wso2/docker-is/tree/5.11.x) |
| 5.10.0 | [5.10.x](https://github.com/wso2/docker-is/tree/5.10.x) |
| 5.9.0 | [5.9.x](https://github.com/wso2/docker-is/tree/5.9.x) |
| 5.8.0 | [5.8.x](https://github.com/wso2/docker-is/tree/5.8.x) |
| 5.7.0 | [5.7.x](https://github.com/wso2/docker-is/tree/5.7.x) |
| 5.6.0 | [5.6.x](https://github.com/wso2/docker-is/tree/5.6.x) |
| 5.5.0 | [5.5.x](https://github.com/wso2/docker-is/tree/5.5.x) |

Each branch is tagged for every release update of the corresponding product version (e.g. `v7.3.0.4`).
See the full list of tags [here](https://github.com/wso2/docker-is/tags).

**Change log** can be found [here](https://github.com/wso2/docker-is/blob/master/CHANGELOG.md).
