# ------------------------------------------------------------------------
#
# Copyright 2018 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# ------------------------------------------------------------------------

# set to latest Centos
FROM centos:7
LABEL maintainer="WSO2 Docker Maintainers <dev@wso2.org>" \
      com.wso2.docker.source="https://github.com/wso2/docker-is/releases/tag/v5.6.0.2"

# set user configurations
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}
# set dependant files directory
ARG FILES=./files
# set JDK configurations
ARG JAVA_HOME=${USER_HOME}/java
ARG JDK_NAME=jdk-8u251-linux-x64.tar.gz
ARG JDK_URL
# set wso2 product configurations
ARG WSO2_SERVER=wso2is
ARG WSO2_SERVER_VERSION=5.6.0
ARG WSO2_SERVER_PACK=${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_DIST_URL
# mysql connector
ARG MYSQL_CONNECTOR_VERSION=5.1.49

# install required packages
RUN yum check-update && \
    yum install -y nc && \
    rm -rf /var/cache/yum/* && \
    >> /etc/bash.bashrc \
    ; echo "\n\
    Welcome to WSO2 Docker Resources \n\
    --------------------------------- \n\
    This Docker container comprises of a WSO2 product, running with its latest updates \n\
    which are under the End User License Agreement (EULA) 2.0. \n\
    Read more about EULA 2.0 here @ https://wso2.com/licenses/wso2-update/2.0 \n" \
    > /etc/motd

# create a user group and a user
RUN groupadd --system -g ${USER_GROUP_ID} ${USER_GROUP} && \
    useradd --system --create-home --home-dir ${USER_HOME} --no-log-init -g ${USER_GROUP_ID} -u ${USER_ID} ${USER}

# installe Oracle JDK
RUN \
    mkdir -p ${JAVA_HOME} \
    && wget -O ${JDK_NAME} ${JDK_URL} \
    && tar -xf ${JDK_NAME} -C ${JAVA_HOME} --strip-components=1 \
    && chown wso2carbon:wso2 -R ${JAVA_HOME} \
    && rm -f ${JDK_NAME}

# add the WSO2 product distribution to user's home directory
RUN \
    wget -O ${WSO2_SERVER_PACK}.zip "${WSO2_SERVER_DIST_URL}" \
    && unzip -d ${USER_HOME} ${WSO2_SERVER_PACK}.zip \
    && chown wso2carbon:wso2 -R ${WSO2_SERVER_HOME} \
    && mkdir -p ${USER_HOME}/wso2-tmp/deployment \
    && cp -r ${WSO2_SERVER_HOME}/repository/deployment ${USER_HOME}/wso2-tmp/deployment \
    && rm -f ${WSO2_SERVER_PACK}.zip

# copy init script to user home
COPY --chown=wso2carbon:wso2 init.sh ${USER_HOME}/
# add MySQL JDBC connector to server home as a third party library
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar ${WSO2_SERVER_HOME}/repository/components/lib/
# add libraries for Kubernetes membership scheme based clustering
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/dnsjava/dnsjava/2.1.8/dnsjava-2.1.8.jar ${USER_HOME}/${WSO2_SERVER_PACK}/repository/components/lib/
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/org/wso2/carbon/kubernetes/artifacts/kubernetes-membership-scheme/1.0.5/kubernetes-membership-scheme-1.0.5.jar ${USER_HOME}/${WSO2_SERVER_PACK}/repository/components/dropins/

# set the user and work directory
USER ${USER_ID}
WORKDIR ${USER_HOME}

# set environment variables
ENV JAVA_HOME=${JAVA_HOME} \
    PATH=$JAVA_HOME/bin:$PATH \
    WSO2_SERVER_HOME=${WSO2_SERVER_HOME} \
    WORKING_DIRECTORY=${USER_HOME}

# expose ports
EXPOSE 4000 9763 9443

# initiate container and start WSO2 Carbon Server
ENTRYPOINT ${WORKING_DIRECTORY}/init.sh
