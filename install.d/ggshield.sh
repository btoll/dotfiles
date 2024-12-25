#!/bin/bash
# shellcheck disable=2174

set -euo pipefail

LANG=C
umask 0022

if [ $EUID -ne 0 ]; then
echo -e "$ERROR This script must be run as root!" 1>&2
    exit 1
fi

apt-get update
apt-get install -y \
    apt-transport-https \
    curl \
    debian-archive-keyring \
    debian-keyring \

mkdir -p -m 755 /usr/share/keyrings
curl -1sLf 'https://dl.cloudsmith.io/public/gitguardian/ggshield/gpg.6739F7C655FE38C6.key' | gpg --dearmor >> /usr/share/keyrings/gitguardian-ggshield-archive-keyring.gpg
chmod go+r /usr/share/keyrings/gitguardian-ggshield-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/gitguardian/ggshield/config.deb.txt?distro=debian&codename=bookworm&component=main' > /etc/apt/sources.list.d/gitguardian-ggshield.list

apt-get update
apt-get install ggshield -y

