#!/bin/sh

# Unifi Controller directories
mkdir -p /srv/unifi-controller/logs
mkdir -p /srv/unifi-controller/data
mkdir -p /srv/unifi-controller/run
rm -f /usr/lib/unifi-controller/logs
rm -f /usr/lib/unifi-controller/data
rm -f /usr/lib/unifi-controller/run
ln -s /srv/unifi-controller/logs /usr/lib/unifi/logs
ln -s /srv/unifi-controller/data /usr/lib/unifi/data
ln -s /srv/unifi-controller/run  /usr/lib/unifi/run

java -Xmx1024M -jar /usr/lib/unifi/lib/ace.jar start
