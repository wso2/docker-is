### This repository contains Identity Server 5.3.0 distributed deployment with Docker compose

![alt tag](../patterns/design/is-5.3.0-pattern-1.png)

## Pre-requisites

 * Docker 
 * Docker compose

#### Docker installation for linux
```
wget -qO- https://get.docker.com/ | sh
```

#### Docker installation for Mac

https://docs.docker.com/docker-for-mac/

#### Docker installation for Windows

https://docs.docker.com/docker-for-windows/

#### Docker Compose Installation

https://docs.docker.com/compose/install/


#### How to run

```docker login docker.wso2.com ```

```docker-compose pull```

```docker-compose up --build -d ```

This will deploy the following,

* Mysql server (container) with isdb, userdb, regdb
* IS Container


#### How to test

Add the following entries to the /etc/hosts
```
127.0.0.1 localhost
```
If you are using docker machine, please use the docker machine IP instead of the local machine IP.

#### How to access the environment

Identity Server

```
https://localhost:9443
```

Dashboard

```
https://localhost:9443/dashboard
```
