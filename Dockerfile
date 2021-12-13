FROM ubuntu:16.04
LABEL maintainer="abel.silva@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
        binutils \
        less \
        ca-certificates \
        apt-transport-https \
        psmisc \
        sudo \
        lsb-release \
        openjdk-8-jre-headless \
        jsvc \
        cron \
        libpopt0 \
        logrotate

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
 && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends mongodb-org \
 && rm -rf /var/lib/apt/lists/*

RUN export DOWNLOAD_URL="https://dl.ubnt.com/unifi/5.14.23/unifi_sysvinit_all.deb" \
 && curl -L ${DOWNLOAD_URL} -o /tmp/unifi-controller.deb \
 && dpkg -i /tmp/unifi-controller.deb \
 && rm -f /tmp/unifi-controller.deb

RUN export DOWNLOAD_URL="https://dlcdn.apache.org/logging/log4j/2.15.0/apache-log4j-2.15.0-bin.tar.gz" \
 && curl -L ${DOWNLOAD_URL} -o /tmp/log4j.tar.gz \
 && tar -xzvf /tmp/log4j.tar.gz \
 && rm -rf /usr/lib/unifi/lib/log4j-api-2.12.1.jar \
 && rm -rf /usr/lib/unifi/lib/log4j-core-2.12.1.jar \
 && rm -rf /usr/lib/unifi/lib/log4j-slf4j-impl-2.12.1.jar \
 && cp /tmp/apache-log4j-2.15.0-bin/log4j-api-2.15.0.jar /usr/lib/unifi/lib \
 && cp /tmp/apache-log4j-2.15.0-bin/log4j-core-2.15.0.jar /usr/lib/unifi/lib \
 && cp /tmp/apache-log4j-2.15.0-bin/log4j-slf4j-impl-2.15.0.jar /usr/lib/unifi/lib \
 && rm -rf /tmp/log4j.tar.gz /tmp/apache-log4j-2.15.0-bin

ADD start.sh /srv/bin/start.sh
RUN chmod +x /srv/bin/start.sh

EXPOSE 3478/udp
EXPOSE 6789 8080 8081 8443 8843 8880
VOLUME /srv/unifi-controller

WORKDIR /srv/unifi-controller
CMD ["/srv/bin/start.sh"]

