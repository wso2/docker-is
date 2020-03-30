# Dockerfile for Dashboard Profile of WSO2 Identity Server Analytics #

This section defines the step-by-step instructions to build [CentOS](https://hub.docker.com/_/centos/) Linux based Docker image for Dashboard profile of
WSO2 Identity Server Analytics 5.7.0.

## Prerequisites

* [Docker](https://www.docker.com/get-docker) v17.09.0 or above
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) client
* WSO2 Identity Server Analytics version `5.7.0` product pack
   + Host the downloaded pack locally or on a remote location.
   > The hosted location will be passed as the build argument `WSO2_SERVER_DIST_URL` when building the Docker image. 

## How to build an image and run

##### 1. Checkout this repository into your local machine using the following Git client command.

```
git clone https://github.com/wso2/docker-is.git
```

> The local copy of the `dockerfile/ubuntu/is-analytics/dasboard` directory will be referred to as `ANALYTICS_DOCKERFILE_HOME` from this point onwards.

##### 2. Build the Docker image.

- Navigate to `<ANALYTICS_DOCKERFILE_HOME>` directory. <br>
  Execute `docker build` command as shown below.
    + `docker build --build-arg WSO2_SERVER_DIST_URL=<URL_OF_THE_HOSTED_LOCATION/FILENAME> -t wso2is-analytics-dashboard:5.7.0-centos .`

> eg:- Hosted locally: `docker build --build-arg WSO2_SERVER_DIST_URL=http://172.17.0.1:8000/wso2is-analytics-5.7.0.zip -t wso2is-analytics-dashboard:5.7.0-centos .`
> eg:- Hosted remotely: `docker build --build-arg WSO2_SERVER_DIST_URL=http://<public_ip:port>/wso2is-analytics-5.7.0.zip -t wso2is-analytics-dashboard:5.7.0-centos .`

##### 3. Running Docker images specific to each profile.

- `docker run -p 9643:9643 wso2is-analytics-dashboard:5.7.0-centos`

##### 4. Accessing the Dashboard portal.

- For dashboard,
    + `https:<DOCKER_HOST>:9643/portal`
    
> In here, <DOCKER_HOST> refers to hostname or IP of the host machine on top of which containers are spawned.

## How to update configurations

Configurations would lie on the Docker host machine and they can be volume mounted to the container. <br>
As an example, steps required to change the port offset using `deployment.yaml` is as follows:

##### 1. Stop the Identity Server Analytics container if it's already running.

In WSO2 Identity Server Analytics 5.7.0 product distribution, `deployment.yaml` configuration file <br>
can be found at `<DISTRIBUTION_HOME>/conf/dashboard`. Copy the file to some suitable location of the host machine, <br>
referred to as `<SOURCE_CONFIGS>/deployment.yaml` and change the offset value under ports to 2.

##### 2. Grant read permission to `other` users for `<SOURCE_CONFIGS>/deployment.yaml`.

```
chmod o+r <SOURCE_CONFIGS>/deployment.yaml
```

##### 3. Run the image by mounting the file to container as follows:

```
docker run 
-p 7713:7713
--volume <SOURCE_CONFIGS>/deployment.yaml:<TARGET_CONFIGS>/deployment.yaml
wso2is-analytics-dashboard:5.7.0-centos
```

> In here, <TARGET_CONFIGS> refers to /home/wso2carbon/wso2is-analytics-5.7.0/conf/dashboard folder of the container.

## Docker command usage references

* [Docker build command reference](https://docs.docker.com/engine/reference/commandline/build/)
* [Docker run command reference](https://docs.docker.com/engine/reference/run/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
