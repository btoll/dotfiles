#!/bin/bash

set -uo pipefail

BIN=ggshield

if ! command -v "$BIN" > /dev/null
then
    echo "$(tput setab 7)$(tput setaf 4)[INFO]$(tput sgr0) $(tput bold)$BIN$(tput sgr0) is not present on the system..."
    exit 0
fi

echo "$(tput setab 7)$(tput setaf 4)[INFO]$(tput sgr0) Running $(tput bold)$BIN$(tput sgr0) pre-commit hook..."

if ! "$BIN" secret scan pre-commit
then
    exit 1
else
    echo "$(tput setab 7)$(tput setaf 2)[INFO]$(tput sgr0) Completed successfully."
fi

