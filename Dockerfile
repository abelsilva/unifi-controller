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
        jsvc

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
 && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends mongodb-org \
 && rm -rf /var/lib/apt/lists/*

RUN export DOWNLOAD_URL="https://dl.ubnt.com/unifi/5.10.19/unifi_sysvinit_all.deb" \
 && curl -L ${DOWNLOAD_URL} -o /tmp/unifi-controller.deb \
 && dpkg -i /tmp/unifi-controller.deb \
 && rm -f /tmp/unifi-controller.deb

ADD start.sh /srv/bin/start.sh
RUN chmod +x /srv/bin/start.sh

EXPOSE 3478/udp
EXPOSE 6789 8080 8081 8443 8843 8880
VOLUME /srv/unifi-controller

WORKDIR /srv/unifi-controller
CMD ["/srv/bin/start.sh"]

