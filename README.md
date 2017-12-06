# WSO2 Identity Server Docker Resources

This repository contains following Docker resources:

- Identity Server Dockerfile
- Identity Server Docker Compose Templates

The Identity Server Dockerfile builds a generic Docker image for deploying Identity Server in containerized environments. It includes the JDK, product distribution and a collection of utility libraries. Configurations, JDBC driver, extensions and other deployable artifacts are designed to be provided via volume mounts.

The Docker Compose templates have been created according to standard Identity Server deployment patterns for allowing users to evaluate the product and understand the deployment architecture in depth. The Docker Compose templates make use of the Identity Server Docker image, Identity Server Analytics Docker image, MySQL Docker image and HAProxy Docker image.