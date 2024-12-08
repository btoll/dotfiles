#!/bin/bash
# shellcheck disable=2174

#https://developer.hashicorp.com/vagrant/install
#https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html#ubuntu--debian

set -euo pipefail

LANG=C
umask 0022

if [ $EUID -ne 0 ]; then
echo -e "$ERROR This script must be run as root!" 1>&2
    exit 1
fi

apt-get update
apt-get install wget gnupg -y

mkdir -p -m 755 /usr/share/keyrings
wget -O- https://apt.releases.hashicorp.com/gpg \
    | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/hashicorp.list

apt-get update
apt-get install -y \
    nfs-kernel-server \
    ruby-libvirt \
    vagrant

usermod -aG libvirt "$USER"

apt-get build-dep -y \
    ruby-libvirt \
    vagrant

