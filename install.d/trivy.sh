#!/bin/bash
# shellcheck disable=2174

set -euo pipefail

LANG=C
umask 0022

if [ $EUID -ne 0 ]; then
echo -e "$ERROR This script must be run as root!" 1>&2
    exit 1
fi

trap cleanup EXIT

cleanup() {
    rm -f kubectl-convert kubectl-convert.sha256
}

apt-get update
apt-get install wget gnupg -y

mkdir -p -m 755 /usr/share/keyrings
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
    | gpg --dearmor \
    | tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" \
    | tee -a /etc/apt/sources.list.d/trivy.list

apt-get update
apt-get install trivy -y

