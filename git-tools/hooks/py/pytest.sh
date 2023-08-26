#!/bin/bash

set -uo pipefail

if ! command -v pytest > /dev/null
then
    echo -e "$INFO ${BOLD}pytest${OFF} is not present on the system..."
    exit 0
fi

FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null | grep ".py\b")

if [ -n "$FILES" ]
then
    echo -e "$INFO Running ${BOLD}pytest${OFF} pre-commit hook..."

    cd tests || exit
    pytest -v
    EXIT_CODE="$?"

    if [ $EXIT_CODE -eq 0 ]
    then
        echo -e "$INFO Completed successfully."
    fi
fi

exit $EXIT_CODE

