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
    ca-certificates \
    curl \
    software-properties-common

mkdir -p -m 755 /usr/share/keyrings
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" \
    | tee /etc/apt/sources.list.d/microsoft-edge.list

apt-get update
apt-get install microsoft-edge-stable -y

