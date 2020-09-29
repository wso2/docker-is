# Docker Resources for WSO2 Identity And Access Management

This repository contains following Docker resources:

- Per profile Docker resources of WSO2 Identity Server version `5.11.0` for Alpine, CentOS, Ubuntu
- Docker Compose resources to evaluate most common Identity And Access Management (IAM) deployment patterns

Per profile Docker resources for WSO2 Identity Server help you build generic Docker images for deploying the
corresponding product servers in containerized environments. Each Docker image includes the JDK, the relevant product distribution
and a collection of utility libraries. Configurations, custom JDBC drivers other than the default MySQL JDBC driver provided,
extensions and other deployable artifacts are designed to be provided via volume mounts to the containers spawned.

Docker Compose resources have been created according to the most common IAM deployment patterns available for allowing users
to quickly evaluate product features along side their co-operate IAM requirements. The Compose files make use of per profile
Docker images of WSO2 Identity Server and MySQL.

**Change log** from previous `v5.10.0.3` [View Here](CHANGELOG.md)
