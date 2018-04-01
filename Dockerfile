FROM ubuntu:16.04
LABEL maintainer="abel.silva@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
        binutils \
        less \
        ca-certificates \
        psmisc \
        sudo \
        lsb-release \
        mongodb-server \
        openjdk-8-jre-headless \
        jsvc \
 && rm -rf /var/lib/apt/lists/*

RUN export DOWNLOAD_URL="http://dl.ubnt.com/unifi/5.7.20/unifi_sysvinit_all.deb" \
 && curl -L ${DOWNLOAD_URL} -o /tmp/unifi-controller.deb \
 && dpkg -i /tmp/unifi-controller.deb \
 && rm -f /tmp/unifi-controller.deb

ADD start.sh /srv/bin/start.sh
RUN chmod +x /srv/bin/start.sh

EXPOSE 3478 6789 8080 8081 8443 8843 8880
VOLUME /srv/unifi-controller

WORKDIR /srv/unifi-controller
CMD ["/srv/bin/start.sh"]

