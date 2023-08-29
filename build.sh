#!/bin/sh

docker buildx build --platform linux/amd64 --push -t abelsilva/unifi-controller .
