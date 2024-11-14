#!/bin/bash

set -uo pipefail

BIN=hadolint

if ! command -v $BIN > /dev/null
then
    echo -e "$INFO ${BOLD}${BIN}${OFF} is not present on the system..."
    exit 0
fi

EXIT_CODE=0
FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null | grep -i "Dockerfile.*")

if [ -n "$FILES" ]
then
    echo -e "$INFO Running ${BOLD}${BIN}${OFF} pre-commit hook..."

    for file in $FILES
    do
        if ! $BIN "$file"
        then
            EXIT_CODE=1
        fi
    done

    if [ $EXIT_CODE -eq 0 ]
    then
        echo -e "$INFO Completed successfully."
    fi
fi

exit $EXIT_CODE

