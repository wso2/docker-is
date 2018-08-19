# Docker Resources for WSO2 Identity And Access Management

This repository contains following Docker resources:

- WSO2 Identity Server Dockerfile for Ubuntu, CentOS and Alpine
- WSO2 Identity Server Analytics Dockerfile for Ubuntu, CentOS and Alpine
- Docker Compose files to evaluate most common deployment profiles

The Identity Server and Identity Server Analytics Dockerfiles build generic Docker images for deploying Identity Server and
Identity Server Analytics in containerized environments. It includes the JDK, product distributions and a collection of utility
libraries. Configurations, JDBC driver, extensions and other deployable artifacts are designed to be provided via Docker volume mounts.

Docker Compose file has been created according to most common Identity Server deployment profiles for allowing users to evaluate
product features to meet their co-operate identity and access management requirements. The Docker Compose files make use of the
per-profile Docker images of WSO2 Identity Server and Identity Server Analytics and MySQL Docker image.

**Change log** from previous v5.6.0.1 release: [View Here](CHANGELOG.md)
