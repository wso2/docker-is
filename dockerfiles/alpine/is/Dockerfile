# ------------------------------------------------------------------------
#
# Copyright 2021 WSO2, LLC. (http://wso2.com)
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

# set base Docker image to Alpine Docker image
FROM alpine:3.16
LABEL maintainer="WSO2 Docker Maintainers <dev@wso2.org>" \
      com.wso2.docker.source="https://github.com/wso2/docker-is/releases/tag/v7.0.0.1"

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Install JDK Dependencies
RUN apk add --no-cache tzdata musl-locales musl-locales-lang \
    && rm -rf /var/cache/apk/*

ENV JAVA_VERSION jdk-11.0.20.1+1

# Install JDK11
RUN set -eux; \
    apk add --no-cache --virtual .fetch-deps curl; \
    ARCH="$(apk --print-arch)"; \
    case "${ARCH}" in \
        amd64|x86_64) \
            ESUM='1a94e642bf6cc4124d4f01f43184f9127ef994cbd324e2ee42cc50f715cbaedf'; \
            BINARY_URL='https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20.1%2B1/OpenJDK11U-jdk_x64_alpine-linux_hotspot_11.0.20.1_1.tar.gz'; \
            ;; \
        *) \
            echo "Unsupported arch: ${ARCH}"; \
            exit 1; \
            ;; \
    esac; \
    wget -O /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    tar --extract \
        --file /tmp/openjdk.tar.gz \
        --directory /opt/java/openjdk \
        --strip-components 1 \
        --no-same-owner \
    ; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH" ENV=${USER_HOME}"/.ashrc"

# set Docker image build arguments
# build arguments for user/group configurations
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}
# build arguments for WSO2 product installation
ARG WSO2_SERVER_NAME=wso2is
ARG WSO2_SERVER_VERSION=7.0.0
ARG WSO2_SERVER_REPOSITORY=product-is
ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}
# Hosted wso2is-7.0.0 distribution URL.
ARG WSO2_SERVER_DIST_URL=https://github.com/wso2/${WSO2_SERVER_REPOSITORY}/releases/download/v${WSO2_SERVER_VERSION}/${WSO2_SERVER}.zip
# build arguments for external artifacts
ARG DNS_JAVA_VERSION=2.1.8
ARG K8S_MEMBERSHIP_SCHEME_VERSION=1.0.10
ARG MYSQL_CONNECTOR_VERSION=8.0.29
# build argument for MOTD
ARG MOTD='printf "\n\
 Welcome to WSO2 Docker Resources \n\
 --------------------------------- \n\
 This Docker container comprises of a WSO2 product, running with its latest GA release \n\
 which is under the Apache License, Version 2.0. \n\
 Read more about Apache License, Version 2.0 here @ http://www.apache.org/licenses/LICENSE-2.0.\n"'

# create the non-root user and group and set MOTD login message
RUN \
    addgroup -S -g ${USER_GROUP_ID} ${USER_GROUP} \
    && adduser -S -u ${USER_ID} -h ${USER_HOME} -G ${USER_GROUP} ${USER} \
    && echo ${MOTD} > "${ENV}"

# create Java prefs dir
# this is to avoid warning logs printed by FileSystemPreferences class
RUN \
    mkdir -p ${USER_HOME}/.java/.systemPrefs \
    && mkdir -p ${USER_HOME}/.java/.userPrefs \
    && chmod -R 755 ${USER_HOME}/.java \
    && chown -R ${USER}:${USER_GROUP} ${USER_HOME}/.java

# copy init script to user home
COPY --chown=wso2carbon:wso2 docker-entrypoint.sh ${USER_HOME}/

# install required packages
RUN \
    apk update \
    && apk add --no-cache netcat-openbsd \
    && apk add unzip \
    && apk add wget

RUN \
    wget -O ${WSO2_SERVER}.zip "${WSO2_SERVER_DIST_URL}" \
    && unzip -d ${USER_HOME} ${WSO2_SERVER}.zip \
    && chown wso2carbon:wso2 -R ${WSO2_SERVER_HOME} \
    && rm -f ${WSO2_SERVER}.zip

# add libraries for Kubernetes membership scheme based clustering
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/dnsjava/dnsjava/${DNS_JAVA_VERSION}/dnsjava-${DNS_JAVA_VERSION}.jar ${WSO2_SERVER_HOME}/repository/components/lib
ADD --chown=wso2carbon:wso2 http://maven.wso2.org/nexus/content/repositories/releases/org/wso2/carbon/kubernetes/artifacts/kubernetes-membership-scheme/${K8S_MEMBERSHIP_SCHEME_VERSION}/kubernetes-membership-scheme-${K8S_MEMBERSHIP_SCHEME_VERSION}.jar ${WSO2_SERVER_HOME}/repository/components/dropins
# add MySQL JDBC connector to server home as a third party library
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar ${WSO2_SERVER_HOME}/repository/components/dropins/

# Set the user and work directory.
USER ${USER_ID}
WORKDIR ${USER_HOME}

# set environment variables
ENV WORKING_DIRECTORY=${USER_HOME} \
    WSO2_SERVER_HOME=${WSO2_SERVER_HOME}

# expose ports
EXPOSE 4000 9763 9443

# initiate container and start WSO2 Carbon server
ENTRYPOINT ["/home/wso2carbon/docker-entrypoint.sh"]
