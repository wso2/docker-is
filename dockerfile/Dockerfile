# ------------------------------------------------------------------------
#
# Copyright 2017 WSO2, Inc. (http://wso2.com)
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

# ------------------------------------------------------------------------

FROM openjdk:8-jdk-alpine
MAINTAINER dev@wso2.org

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV WSO2CARBON_ZIP wso2is-6.0.0-m1.zip
ENV INSTALL_PATH /home/wso2user/

RUN apk update && apk add --no-cache pwgen bash && addgroup wso2 && adduser -g '' -s /bin/bash -D -G wso2 wso2user

USER wso2user
WORKDIR /mnt

# Add the startup script
ADD init.sh /init.sh

# Copy carbon pack and required other resources
COPY $WSO2CARBON_ZIP $INSTALL_PATH
RUN unzip $INSTALL_PATH/$WSO2CARBON_ZIP -d $INSTALL_PATH/

EXPOSE 9292
CMD ["bash", "-c", "source /init.sh"]
