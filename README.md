# Docker Resources for WSO2 Identity And Access Management

This repository contains following Docker resources:

- WSO2 Identity Server Dockerfile for Ubuntu, CentOS and Alpine
- WSO2 Identity Server Analytics Dockerfile for Ubuntu, CentOS and Alpine
- Docker Compose files to evaluate most common deployment profiles

The Identity Server and Identity Server Analytics Dockerfiles help you build generic Docker images for deploying Identity Server and
Identity Server Analytics in containerized environments. Each dockerfile includes the JDK, a product distribution and a collection of utility
libraries required to build an image. Configurations, custom JDBC drivers other than the default MySQL JDBC driver provided, extensions and other deployable artifacts are designed 
to be provided via volume mounts to the containers spawned.

Docker Compose files have been created according to the most common Identity Server deployment profiles available for allowing users to quickly evaluate
product features along side their co-operate identity and access management requirements. The Compose files make use of
Docker images of WSO2 Identity Server, Identity Server Analytics and MySQL.

**Change log** from previous v5.5.0.4 release: [View Here](CHANGELOG.md)
