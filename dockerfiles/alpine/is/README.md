# Dockerfile for WSO2 Identity Server #

This section defines the step-by-step instructions to build an [Alpine](https://hub.docker.com/_/alpine/) Linux based Docker image for WSO2 Identity Server 5.7.0.

## Prerequisites

* [Docker](https://www.docker.com/get-docker) v17.09.0 or above
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) client
* WSO2 Identity Server version `5.7.0` product pack
   + Host the downloaded pack locally or on a remote location.
   > The hosted location will be passed as the build argument `WSO2_SERVER_DIST_URL` when building the Docker image. 

## How to build an image and run

##### 1. Checkout this repository into your local machine using the following Git client command.

```
git clone https://github.com/wso2/docker-is.git
```

>The local copy of the `dockerfiles/alpine/is` directory will be referred to as `IS_DOCKERFILE_HOME` from this point onwards.

##### 2. Build the Docker image.

- Navigate to `<IS_DOCKERFILE_HOME>` directory. <br>
  Execute `docker build` command as shown below.
    + `docker build --build-arg WSO2_SERVER_DIST_URL=<URL_OF_THE_HOSTED_LOCATION/FILENAME> -t wso2is:5.7.0-alpine .`

> eg:- Hosted locally: `docker build --build-arg WSO2_SERVER_DIST_URL=http://172.17.0.1:8000/wso2is-5.7.0.zip -t wso2is:5.7.0-alpine .`
> eg:- Hosted remotely: `docker build --build-arg WSO2_SERVER_DIST_URL=http://<public_ip:port>/wso2is-5.7.0.zip -t wso2is:5.7.0-alpine .`

##### 3. Running the Docker image.

- `docker run -it -p 9443:9443 wso2is:5.7.0-alpine`

>Here, only port 9443 (HTTPS servlet transport) has been mapped to a Docker host port.
You may map other container service ports, which have been exposed to Docker host ports, as desired.

##### 4. Accessing management console.

- To access the management console, use the docker host IP and port 9443.
    + `https://<DOCKER_HOST>:9443/carbon`
    
>In here, <DOCKER_HOST> refers to hostname or IP of the host machine on top of which containers are spawned.

## How to update configurations

Configurations would lie on the Docker host machine and they can be volume mounted to the container. <br>
As an example, steps required to change the port offset using `carbon.xml` is as follows:

##### 1. Stop the Identity Server container if it's already running.

In WSO2 Identity Server 5.7.0 product distribution, `carbon.xml` configuration file <br>
can be found at `<DISTRIBUTION_HOME>/repository/conf`. Copy the file to some suitable location of the host machine, <br>
referred to as `<SOURCE_CONFIGS>/carbon.xml` and change the offset value under ports to 1.

##### 2. Grant read permission to `other` users for `<SOURCE_CONFIGS>/carbon.xml`.

```
chmod o+r <SOURCE_CONFIGS>/carbon.xml
```

##### 3. Run the image by mounting the file to container as follows:

```
docker run \
-p 9444:9444 \
--volume <SOURCE_CONFIGS>/carbon.xml:<TARGET_CONFIGS>/carbon.xml \
wso2is:5.7.0-alpine
```

>In here, <TARGET_CONFIGS> refers to /home/wso2carbon/wso2is-5.7.0/repository/conf folder of the container.

## Docker command usage references

* [Docker build command reference](https://docs.docker.com/engine/reference/commandline/build/)
* [Docker run command reference](https://docs.docker.com/engine/reference/run/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
