# WSO2 Identity Server deployment with WSO2 Identity Server Analytics

## Prerequisites

 * Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Docker](https://www.docker.com/get-docker) and [Docker Compose](https://docs.docker.com/compose/install/#install-compose)
   in order to run the steps provided in following Quick start guide. <br><br>
 * In order to use Docker images with WSO2 updates, you need an active WSO2 subscription. If you do not possess an active WSO2
   subscription, you can sign up for a WSO2 Free Trial Subscription from [here](https://wso2.com/free-trial-subscription).
   Otherwise, you can proceed with Docker images which are created using GA releases.<br><br>
 * If you wish to run the Docker Compose setup using Docker images built locally, build Docker images using Docker resources available from [here](../../dockerfiles/) and remove the `docker.wso2.com/` prefix from the `image` name in the `docker-compose.yml`. <br><br>
   
## How to deploy

  1. Clone WSO2 Identity Server Docker git repository.
     ```
     git clone https://github.com/wso2/docker-is
     ```
     > If you are to try out an already released zip of this repo, please ignore this 1st step.

  2. Switch to the `docker-compose/is-with-analytics` folder.
     ```
     cd [docker-is]/docker-compose/is-with-analytics
     ```
     > If you are to try out an already released zip of this repo, please ignore this 2nd step also. 
      Instead, extract the zip file and directly browse to `docker-is-<released-version-here>/docker-compose/is-with-analytics` folder. 
     
     > If you want to try out an already released tag, after executing 2nd step, checkout the relevant tag, 
      i.e. for example: git checkout tags/v5.8.0.1 and continue below steps.

  3. Execute the `deploy.sh` script to start the deployment.
     ```
     ./deploy.sh
     ```
     
  4. Access management console via a web browser.

     ```
     For Identity Server - https://localhost:9443/carbon
     For Identity Server Analytics Portal - https://localhost:9643/portal/
     ```

  5. When configuring an application with Identity Server, use the following properties
      * IdPEntityId - wso2is
