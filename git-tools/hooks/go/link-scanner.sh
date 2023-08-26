#!/bin/bash

set -uo pipefail

if ! command -v link-scanner > /dev/null
then
    echo -e "$INFO ${BOLD}link-scanner${OFF} is not present on the system..."
    exit 0
fi

EXIT_CODE=0
FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null | grep ".md\b")

if [ -n "$FILES" ]
then
    echo -e "$INFO Running ${BOLD}link-scanner${OFF} pre-commit hook..."

    for file in $FILES
    do
        if ! link-scanner -filename "$file" -filetype ".md"
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

