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

# set base to Alpine 3.8(OpenJDK)
FROM openjdk:8u171-jdk-alpine3.8
LABEL maintainer="WSO2 Docker Maintainers <dev@wso2.org>" \
      com.wso2.docker.source="https://github.com/wso2/docker-is/releases/tag/v5.5.0.9"

# set user configurations
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}
# set wso2 product configurations
ARG WSO2_SERVER=wso2is-analytics
ARG WSO2_SERVER_VERSION=5.5.0
ARG WSO2_SERVER_REPOSITORY=product-is
ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}
ARG WSO2_SERVER_DIST_URL
# build arguments for external artifacts
ARG MYSQL_CONNECTOR_VERSION=5.1.49
# build argument for MOTD
ARG MOTD="\n\
Welcome to WSO2 Docker resources.\n\
------------------------------------ \n\
This Docker container comprises of a WSO2 product, running with its latest GA release \n\
which is under the Apache License, Version 2.0. \n\
Read more about Apache License, Version 2.0 here @ http://www.apache.org/licenses/LICENSE-2.0.\n"

# install required packages
RUN  \
     apk add --update --no-cache \
        curl \
        netcat-openbsd \
        unzip \
        wget \
        && rm -rf /var/cache/apk/*

# create the non-root user and group and set MOTD login message
RUN \
    addgroup -S -g ${USER_GROUP_ID} ${USER_GROUP} \
    && adduser -S -u ${USER_ID} -h ${USER_HOME} -G ${USER_GROUP} ${USER} \
    && echo ${MOTD} > "${ENV}"

# install Alpine Linux package to run binaries linked against glibc
RUN apk --no-cache add ca-certificates wget; \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub; \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk; \
    apk add glibc-2.27-r0.apk;

# create Java prefs dir
# this is to avoid warning logs printed by FileSystemPreferences class
RUN mkdir -p ${USER_HOME}/.java/.systemPrefs && \
    mkdir -p ${USER_HOME}/.java/.userPrefs  && \
    chmod -R 755 ${USER_HOME}/.java && \
    chown -R ${USER}:${USER_GROUP} ${USER_HOME}/.java

# copy docker-entrypoint script to user home
COPY --chown=wso2carbon:wso2 docker-entrypoint.sh ${USER_HOME}/

# add the WSO2 product distribution to user's home directory
RUN \
    wget --no-check-certificate -O ${WSO2_SERVER}.zip "${WSO2_SERVER_DIST_URL}" \
    && unzip -d ${USER_HOME} ${WSO2_SERVER}.zip \
    && chown wso2carbon:wso2 -R ${WSO2_SERVER_HOME} \
    && mkdir ${USER_HOME}/wso2-tmp/deployment \
    && cp -r ${WSO2_SERVER_HOME}/repository/deployment ${USER_HOME}/wso2-tmp/deployment \
    && rm -f ${WSO2_SERVER}.zip

# add MySQL JDBC connector to server home as a third party library
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar ${WSO2_SERVER_HOME}/repository/components/lib/

# add the missing snappy-java JAR artifact to eliminate the no class definition found error, during the server startup
# (https://docs.wso2.com/display/DAS320/Troubleshooting+the+Server+Startup)
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/org/xerial/snappy/snappy-java/1.1.1.7/snappy-java-1.1.1.7.jar ${USER_HOME}/${WSO2_SERVER_PACK}/repository/components/lib/
# add libraries for Kubernetes membership scheme based clustering
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/dnsjava/dnsjava/2.1.8/dnsjava-2.1.8.jar ${USER_HOME}/${WSO2_SERVER_PACK}/repository/components/lib/
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/org/wso2/carbon/kubernetes/artifacts/kubernetes-membership-scheme/1.0.5/kubernetes-membership-scheme-1.0.5.jar ${USER_HOME}/${WSO2_SERVER_PACK}/repository/components/dropins/

# create java prefs dir
# this is to avoid warning logs printed by FileSystemPreferences class
RUN mkdir -p ${USER_HOME}/.java/.systemPrefs && \
    mkdir -p ${USER_HOME}/.java/.userPrefs  && \
    chmod -R 755 ${USER_HOME}/.java && \
    chown -R ${USER}:${USER_GROUP} ${USER_HOME}/.java

# set the user and work directory
USER ${USER_ID}
WORKDIR ${USER_HOME}

# set environment variables
ENV WSO2_SERVER_HOME=${WSO2_SERVER_HOME} \
    WORKING_DIRECTORY=${USER_HOME} \
    JAVA_OPTS="-Djava.util.prefs.systemRoot=${USER_HOME}/.java -Djava.util.prefs.userRoot=${USER_HOME}/.java/.userPrefs"

# expose ports
EXPOSE 4000 9764 9444 7712 7612 11225 10006 11001 11501 8082 4041

# initiate container and start WSO2 Carbon server
ENTRYPOINT ${WORKING_DIRECTORY}/docker-entrypoint.sh
