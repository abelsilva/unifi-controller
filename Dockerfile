FROM ubuntu:22.04
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
        openjdk-17-jre-headless \
        jsvc \
        cron \
        libpopt0 \
        logrotate \
        gnupg

ADD libssl.sh /tmp/libssl.sh

RUN chmod a+x /tmp/libssl.sh \
 && /tmp/libssl.sh \
 && sleep 5 \
 && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \
 && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.6.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        mongodb-org \
        mongodb-org-shell \
        mongodb-org-server \
        mongodb-org-mongos \
        mongodb-org-tools \
 && rm -rf /var/lib/apt/lists/*

RUN export DOWNLOAD_URL="https://dl.ui.com/unifi/7.5.172-39991973d0/unifi_sysvinit_all.deb" \
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

