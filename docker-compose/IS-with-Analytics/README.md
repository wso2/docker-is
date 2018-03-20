# WSO2 Identity Server with Analytics

![WSO2 Identity Server with Analytics](deployment-diagram.png)

Runs a pre configured Identity Server container and Identity Server Analytics container.

## Prerequisites

 * Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Docker](https://www.docker.com/get-docker) and [Docker Compose](https://docs.docker.com/compose/install/#install-compose)
   in order to run the steps provided in following Quick start guide. <br><br>
  * In order to run this Docker Compose setup, you will need an active [Free Trial Subscription](https://wso2.com/free-trial-subscription) 
   from WSO2 since the referring Docker images hosted at docker.wso2.com contains the latest updates and fixes for WSO2 Identity Server. You can sign up for a Free Trial Subscription [here](https://wso2.com/free-trial-subscription). <br><br>
 * If you wish to run the Docker Compose setup using Docker images built locally, build Docker images using [Identity Server Dockerfile](../../dockerfiles/is/README.md), [Identity Server Analytics Dockerfile](../../dockerfiles/is-analytics/README.md) and remove the `docker.wso2.com/` prefix from the `image` name In the `docker-compose.yml`. <br><br>
## How to deploy

  1. Clone WSO2 Identity Server Docker git repository.
     ```
     git clone https://github.com/wso2/docker-is
     ```
     > If you are to try out an already released zip of this repo, please ignore this 1st step.

  2. Switch to the `docker-compose/is-analytics` folder.
     ```
     cd [docker-is]/docker-compose/IS-with-Analytics
     ```
     > If you are to try out an already released zip of this repo, please ignore this 2nd step also. 
      Instead, extract the zip file and directly browse to `docker-is-<released-version-here>docker-compose/is-analytics` folder. 
     
     > If you want to try out an already released tag, after executing 2nd step, checkout the relevant tag, 
      i.e. for example: git checkout tags/v5.4.1.4 and continue below steps.

  3. Execute the following Docker Compose command to start the deployment.
     ```
     docker-compose up
     ```

  4. Access the Identity Server carbon console using the below URL via a web browser.
     ```
     https://localhost:9443/carbon
     ```
  5. Access the Identity Server Analytics portal using the below URL via a web browser.
     ```
     https://localhost:9444/portal/dashboards/IsAnalytics-AuthenticationData
     ```

  6. When configuring an application with Identity Server, use the following properties
      * IdPEntityId - wso2is
