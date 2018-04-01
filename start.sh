#!/bin/sh

# UniFi Controller directories
mkdir -p /srv/unifi-controller/logs
mkdir -p /srv/unifi-controller/data
mkdir -p /srv/unifi-controller/run
rm -f /usr/lib/unifi/logs
rm -f /usr/lib/unifi/data
rm -f /usr/lib/unifi/run
ln -s /srv/unifi-controller/logs /usr/lib/unifi/logs
ln -s /srv/unifi-controller/data /usr/lib/unifi/data
ln -s /srv/unifi-controller/run  /usr/lib/unifi/run

# Start UniFi Controller
java -Xmx1024M -Djava.awt.headless=true -Dfile.encoding=UTF-8 -jar /usr/lib/unifi/lib/ace.jar start
