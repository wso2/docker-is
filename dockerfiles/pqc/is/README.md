# Dockerfile for WSO2 Identity Server with Post-Quantum TLS #

This section defines the step-by-step instructions to build an [Ubuntu](https://hub.docker.com/_/ubuntu/) Linux
based Docker image for WSO2 Identity Server `7.1.0` with [Post-Quantum TLS support](https://is.docs.wso2.com/en/7.1.0/deploy/security/configure-post-quantum-tls/).

## Prerequisites

* [Docker](https://www.docker.com/get-docker) `v17.09.0` or above
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) client

## How to build an image and run

##### 1. Checkout this repository into your local machine using the following Git client command.

```
git clone https://github.com/wso2/docker-is.git
```

>The local copy of the `dockerfiles/ubuntu/is` directory will be referred to as `IS_DOCKERFILE_HOME` from this point onwards.

##### 2.  Build the Docker image.

- Navigate to `<IS_DOCKERFILE_HOME>` directory. <br>
  Execute `docker build` command as shown below.
    + `docker build -t wso2is:7.1.0 .`

> Tip - If you require the container to run with a different UID and GID, pass the preferred values of the UID and GID
> as values for build arguments `USER_ID` and `USER_GROUP_ID` when building the image, as shown below. Note
> that setting lower values for the UID and GID is not recommended.
+ `docker build -t wso2is:7.1.0 --build-arg USER_ID=<UID> --build-arg USER_GROUP_ID=<GID> .`

##### 3. Running the Docker image.

- `docker run -it -p 9443:9443 wso2is:7.1.0`

>Here, only port 9443 (HTTPS servlet transport) has been mapped to a Docker host port.
You may map other container service ports, which have been exposed to Docker host ports, as desired.

##### 4. Accessing management consoles.

- To access the user interfaces, use the docker host IP and port 9443.
    + Management Console: `https://<DOCKER_HOST>:9443/console`
    + User Portal: `https://<DOCKER_HOST>:9443/myaccount`
    
>In here, <DOCKER_HOST> refers to hostname or IP of the host machine on top of which containers are spawned.

## How to update configurations

Configurations would lie on the Docker host machine and they can be volume mounted to the container. <br>
As an example, steps required to change the port offset using `deployment.toml` is as follows:

##### 1. Stop the Identity Server container if it's already running.

In WSO2 Identity Server version `7.1.0` product distribution, `deployment.toml` configuration file <br>
can be found at `<DISTRIBUTION_HOME>/repository/conf`. Copy the file to some suitable location of the host machine, <br>
referred to as `<SOURCE_CONFIGS>/deployment.toml` and change the `[server] -> offset` value to 1.

##### 2. Grant read permission to `other` users for `<SOURCE_CONFIGS>/deployment.toml`.

```
chmod o+r <SOURCE_CONFIGS>/deployment.toml
```

##### 3. Run the image by mounting the file to container as follows:

```
docker run \
-p 9444:9444 \
--volume <SOURCE_CONFIGS>/deployment.toml:<TARGET_CONFIGS>/deployment.toml \
wso2is:7.1.0
```

>In here, <TARGET_CONFIGS> refers to /home/wso2carbon/wso2is-7.1.0/repository/conf folder of the container.

## Docker command usage references

* [Docker build command reference](https://docs.docker.com/engine/reference/commandline/build/)
* [Docker run command reference](https://docs.docker.com/engine/reference/run/)
* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
