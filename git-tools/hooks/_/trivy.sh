#!/bin/bash
# shellcheck disable=2063

set -uo pipefail

BIN=trivy

if ! command -v $BIN > /dev/null
then
    echo "$(tput setab 7)$(tput setaf 4)[INFO]$(tput sgr0) $(tput bold)link-scanner$(tput sgr0) is not present on the system..."
    exit 0
fi

EXIT_CODE=0
FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null | grep -E "*.[bash|sh]")

if [ -n "$FILES" ]
then
    echo "$(tput setab 7)$(tput setaf 4)[INFO]$(tput sgr0) Running $(tput bold)$BIN$(tput sgr0) pre-commit hook..."

    for file in $FILES
    do
        if ! $BIN fs --scanners config,license,secret,vuln --severity HIGH,CRITICAL --exit-code 1 "$file"
        then
            EXIT_CODE=1
        fi
    done

    if [ $EXIT_CODE -eq 0 ]
    then
        echo "$(tput setab 7)$(tput setaf 2)[INFO]$(tput sgr0) Completed successfully."
    fi
fi

exit $EXIT_CODE

