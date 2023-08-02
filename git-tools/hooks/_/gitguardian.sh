#!/bin/bash

set -uo pipefail

BIN=ggshield

if ! command -v "$BIN" > /dev/null
then
    echo "$INFO ${BOLD}${BIN}${OFF} is not present on the system..."
    exit 0
fi

echo "$INFO Running ${BOLD}${BIN}${OFF} pre-commit hook..."

if ! "$BIN" secret scan pre-commit
then
    exit 1
else
    echo "$INFO Completed successfully."
fi

