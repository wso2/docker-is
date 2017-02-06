# Dockerfile for WSO2 Identity Server #

## Try it out
Quick steps to build the WSO2 Identity Server docker image and run in your local machine

The cloned local copy of WSO2 Dockerfile will be referred as `DOCKERFILES_HOME`.

* Add product packs and dependencies
    - Download the WSO2 Identity Server zip file (http://wso2.com/products/identity-server/) and copy it to `<DOCKERFILES_HOME>/`.

* Build the docker image
    - Navigate to `<DOCKERFILES_HOME>`.
    - docker build -t $(PREFIX):$(TAG) .

* Docker run
    - docker run $(PREFIX):$(TAG) -p 127.0.0.1:9292:9292

* Access management console
    -  To access the user portal, use the docker host IP and port 9292.
        + `https:<DOCKER_HOST_IP>:9292/user-portal`

