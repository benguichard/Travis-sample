#/bin/sh
set -e
set -x

# install required packages
export DEBIAN_FRONTEND=noninteractive
apt-get -q update
apt-get -q -y install apache2

## Clear unneeded binaries
apt-get autoclean
apt-get --purge -y autoremove
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
