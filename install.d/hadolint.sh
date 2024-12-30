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
    rm -f hadolint-Linux-x86_64*
}

wget https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
wget https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64.sha256
if ! sha256sum -c hadolint-Linux-x86_64.sha256
then
    # We won't log anything to stdout here as the preceding check will have done it for us.
    echo "[ERROR] Hadolint checksum failed."
    exit 1
else
    mv hadolint-Linux-x86_64 /usr/local/bin/hadolint
    chmod +x /usr/local/bin/hadolint
fi

