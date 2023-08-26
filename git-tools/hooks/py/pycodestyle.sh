#!/bin/bash

set -uo pipefail

if ! command -v pycodestyle > /dev/null
then
    echo -e "$INFO ${BOLD}pycodestyle${OFF} is not present on the system..."
    exit 0
fi

FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null | grep ".py\b")

if [ -n "$FILES" ]
then
    echo -e "$INFO Running ${BOLD}pycodestyle${OFF} pre-commit hook..."

    for file in $FILES
    do
        if ! pycodestyle "$file"
        then
            # Note that pycodestyle's error messages are verbose enough that we don't need to have our own.
            EXIT_CODE=1
        fi
    done

    if [ $EXIT_CODE -eq 0 ]
    then
        echo -e "$INFO Completed successfully."
    fi
fi

exit $EXIT_CODE

