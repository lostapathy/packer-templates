#!/bin/bash -eux

apt-get update
apt-get -y dist-upgrade

# ensure the correct kernel headers are installed
apt-get -y install linux-headers-$(uname -r)

/sbin/shutdown -r now

