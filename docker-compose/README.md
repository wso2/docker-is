# Docker Compose resources for a WSO2 Identity Server deployment

## Prerequisites

 * Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Docker](https://www.docker.com/get-docker)
   and [Docker Compose](https://docs.docker.com/compose/install/#install-compose) in order to run the steps provided in following Quick start guide.

 * In order to use Docker images with [WSO2 Updates](https://wso2.com/updates), you need an active [WSO2 Subscription](https://wso2.com/subscription).
   Otherwise, you can proceed with Docker images available at [DockerHub](https://hub.docker.com/u/wso2/), which are created using GA releases.

 * If you wish to run the Docker Compose setup using Docker images built locally, build Docker images using Docker resources available from [here](../../dockerfiles/)
and update the `image` name in the `docker-compose.yml` with the built image.
   
## How to deploy

  1. Clone WSO2 Identity Server Docker git repository.
     ```
     git clone https://github.com/wso2/docker-is
     ```
      > Alternatively you can download a [zip release](https://github.com/wso2/docker-is/releases)

  1. Switch to the `docker-compose` folder.
     ```
     cd [docker-is]/docker-compose
     ```
     
     > If you are to try out an already released zip of this repo, please ignore this 2nd step also. Instead, extract the zip file and directly browse to `docker-is-<released-version-here>/docker-compose` folder. 

  1. Execute following Docker Compose command to `start the deployment`.
     ```
     docker-compose pull && docker-compose up
     ```
     
  1. Access Management Console, My Account and Console applications via a web browser.
     ```
     For Identity Server Management Console - https://localhost:9443/carbon
     For Identity Server My Account - https://localhost:9443/myaccount
     For Identity Server Console - https://localhost:9443/console
     ```

  1. Execute following Docker Compose command to `stop the deployment`.
     ```
     docker-compose down
     ```

### Specifying a version

   > If you want to try out a released tag, after stopping the deployment, update the compose file `identity-server` image: <br>
   > `image: docker.wso2.com/wso2is:<IS-VERSION>`
