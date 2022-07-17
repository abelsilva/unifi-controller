#!/bin/bash

## from https://get.glennr.nl/unifi/install/unifi-7.1.67.sh

architecture=$(dpkg --print-architecture)

if [[ "${architecture}" =~ (amd64|arm64) ]]; then
  echo -e "# Installing a required package..\\n" && sleep 2
  libssl_temp="$(mktemp --tmpdir=/tmp libssl1.0.2_XXXXX.deb)" || abort
  if [[ "${architecture}" == "amd64" ]]; then
    libssl_url=$(curl -s http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/ | grep -io "libssl1.0.0.*amd64.deb" | sed '/u5_/d' | cut -d'"' -f1 | tail -n1)
    echo -e "# Downloading libssl..."
    if curl -L "http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/${libssl_url}" -o "$libssl_temp" ; then echo -e "# Successfully downloaded libssl!"; else echo -e "# Failed to download libssl..."; fi
  fi
  if [[ "${architecture}" == "arm64" ]]; then
    echo -e "# Downloading libssl..."
    if curl -L 'https://launchpad.net/ubuntu/+source/openssl1.0/1.0.2n-1ubuntu5/+build/14503127/+files/libssl1.0.0_1.0.2n-1ubuntu5_arm64.deb' -o "$libssl_temp" ; then echo -e "# Successfully downloaded libssl!"; else echo -e "# Failed to download libssl..."; fi
  fi
  echo -e "\\n# Installing libssl..."
  if dpkg -i "$libssl_temp" ; then echo -e "# Successfully installed libssl! \\n"; else echo -e "# Failed to install libssl...\\n"; fi
  rm --force "$libssl_temp" 2> /dev/null
fi