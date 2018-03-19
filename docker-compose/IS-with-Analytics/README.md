# WSO2 Identity Server with Analytics

![WSO2 Identity Server with Analytics](deployment-diagram.png)

Runs a pre configured Identity Server container and Identity Server Analytics container.

## Prerequisites

 * [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Docker](https://www.docker.com/get-docker) and [Docker Compose](https://docs.docker.com/compose/install/#install-compose) are required for running this Docker Compose template.
 * In order to run the Docker Compose setup, you will need an active subscription from WSO2 since the 
  Docker images hosted at docker.wso2.com contains the latest updates and fixes to WSO2 Identity Server and 
  WSO2 Identity Server Analytics. You can sign up for a Free Trial Subscription [here](https://wso2.com/free-trial-subscription)
 * If you wish to run the Docker Compose setup using Docker images built locally, build Docker images using [Identity Server Dockerfile](../../dockerfiles/is/README.md), [Identity Server Analytics Dockerfile](../../dockerfiles/is-analytics/README.md) and remove the `docker.wso2.com/` prefix from the `image` name In the `docker-compose.yml`
## How to deploy

  1. Clone WSO2 Identity Server Docker git repository.
     ```
     git clone https://github.com/wso2/docker-is
     ```
  > Note that the local copy of `docker-is` repository will be referred to as `[docker-is]` from this point onwards.

  2. Switch to the docker-compose/is-analytics folder:
     ```
     cd [docker-is]/docker-compose/IS-with-Analytics
     ```

  3. Execute the following Docker Compose command to start the deployment:
     ```
     docker-compose up
     ```

  4. Once the deployment process is complete add a host entry pointing to the Docker host machine IP address. For an example if the Docker host is accessible via 127.0.0.1 on a Linux or Mac machine, add the following entry in /etc/hosts file:

     ```
     127.0.0.1 wso2is
     127.0.0.1 wso2is-analytics
     ```

  5. Access the Identity Server carbon console using the below URL via a web browser:
     ```
     https://wso2is:9443/carbon
     ```
  6. Access the Identity Server Analytics portal using the below URL via a web browser:
     ```
     https://wso2is-analytics:9444/portal/dashboards/IsAnalytics-AuthenticationData/
     ```

  7. When configuring an application with Identity Server, use the following properties
      * IdPEntityId - wso2is
