# ------------------------------------------------------------------------
#
# Copyright 2024 WSO2, LLC. (http://wso2.com)
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

# Set base Docker image to Ubuntu 20.04 Docker image.
FROM ubuntu:20.04

LABEL maintainer="WSO2 Docker Maintainers <dev@wso2.org>" \
      com.wso2.docker.source="https://github.com/wso2/docker-is/releases/tag/v7.0.0.1"

# Install JDK Dependencies.
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION jdk-17.0.9+9

# Install JDK11.
RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
        amd64|x86_64) \
            ESUM='7b175dbe0d6e3c9c23b6ed96449b018308d8fc94a5ecd9c0df8b8bc376c3c18a'; \
            BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz'; \
            ;; \
        aarch64|arm64) \
            ESUM='e2c5e26f8572544b201bc22a9b28f2b1a3147ab69be111cea07c7f52af252e75'; \
            BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_aarch64_linux_hotspot_17.0.9_9.tar.gz'; \
            ;; \
       *) \
            echo "Unsupported arch: ${ARCH}"; \
            exit 1; \
            ;; \
    esac; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

# Set Docker image build arguments.
# Build arguments for user/group configurations.
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}
# Build arguments for WSO2 product installation.
ARG WSO2_SERVER_NAME=wso2is
ARG WSO2_SERVER_VERSION=7.0.0
# Hosted wso2is-7.0.0 distribution URL.
ARG WSO2_SERVER_DIST_URL=https://github.com/wso2/${WSO2_SERVER_REPOSITORY}/releases/download/v${WSO2_SERVER_VERSION}/${WSO2_SERVER}.zip
ARG WSO2_SERVER_REPOSITORY=product-is
ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}
# Hosted wso2is-7.0.0 distribution URL.
ARG WSO2_SERVER_DIST_URL=https://github.com/wso2/${WSO2_SERVER_REPOSITORY}/releases/download/v${WSO2_SERVER_VERSION}/${WSO2_SERVER}.zip
# Build arguments for external artifacts.
ARG DNS_JAVA_VERSION=3.6.1
ARG K8S_MEMBERSHIP_SCHEME_VERSION=1.0.10
# Build argument for MOTD.
ARG MOTD="\n\
Welcome to WSO2 Docker resources.\n\
------------------------------------ \n\
This Docker container comprises of a WSO2 product, running with its latest GA release \n\
which is under the Apache License, Version 2.0. \n\
Read more about Apache License, Version 2.0 here @ http://www.apache.org/licenses/LICENSE-2.0.\n"

# Create the non-root user and group and set MOTD login message.
RUN \
    groupadd --system -g ${USER_GROUP_ID} ${USER_GROUP} \
    && useradd --system --create-home --home-dir ${USER_HOME} --no-log-init -g ${USER_GROUP_ID} -u ${USER_ID} ${USER} \
    && echo '[ ! -z "${TERM}" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc; echo "${MOTD}" > /etc/motd

# Create Java prefs dir.
# This is to avoid warning logs printed by FileSystemPreferences class.
RUN \
    mkdir -p ${USER_HOME}/.java/.systemPrefs \
    && mkdir -p ${USER_HOME}/.java/.userPrefs \
    && chmod -R 755 ${USER_HOME}/.java \
    && chown -R ${USER}:${USER_GROUP} ${USER_HOME}/.java

# Copy init script to user home.
COPY --chown=wso2carbon:wso2 docker-entrypoint.sh ${USER_HOME}/

# Install required packages.
RUN \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        netcat \
        unzip \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN \
    wget -O ${WSO2_SERVER}.zip "${WSO2_SERVER_DIST_URL}" \
    && unzip -d ${USER_HOME} ${WSO2_SERVER}.zip \
    && chown wso2carbon:wso2 -R ${WSO2_SERVER_HOME} \
    && rm -f ${WSO2_SERVER}.zip

# Add libraries for Kubernetes membership scheme based clustering.
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/dnsjava/dnsjava/${DNS_JAVA_VERSION}/dnsjava-${DNS_JAVA_VERSION}.jar ${WSO2_SERVER_HOME}/repository/components/lib
ADD --chown=wso2carbon:wso2 http://maven.wso2.org/nexus/content/repositories/releases/org/wso2/carbon/kubernetes/artifacts/kubernetes-membership-scheme/${K8S_MEMBERSHIP_SCHEME_VERSION}/kubernetes-membership-scheme-${K8S_MEMBERSHIP_SCHEME_VERSION}.jar ${WSO2_SERVER_HOME}/repository/components/dropins

# Set the user and work directory.
USER ${USER_ID}
WORKDIR ${USER_HOME}

# Set environment variables.
ENV JAVA_OPTS="-Djava.util.prefs.systemRoot=${USER_HOME}/.java -Djava.util.prefs.userRoot=${USER_HOME}/.java/.userPrefs" \
    WORKING_DIRECTORY=${USER_HOME} \
    WSO2_SERVER_HOME=${WSO2_SERVER_HOME}

# Expose ports.
EXPOSE 4000 9763 9443

# Initiate container and start WSO2 Carbon server.
ENTRYPOINT ["/home/wso2carbon/docker-entrypoint.sh"]
