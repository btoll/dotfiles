#!/bin/bash

set -uo pipefail

EXIT_CODE=0
FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null)

echo "$INFO Running ${BOLD}EOF${OFF} pre-commit hook..."

for F in $FILES; do
    MIMETYPE=$(file --mime-type -b "$F")

    if [[
        ( "$MIMETYPE" == image/gif ) ||
        ( "$MIMETYPE" == image/jpg ) ||
        ( "$MIMETYPE" == image/jpeg ) ||
        ( "$MIMETYPE" == image/png )
    ]]; then
        continue
    fi

    if [[ $(awk 'END{print ($0=="")}' "$F" 2> /dev/null) == 0 ]]; then
        echo "$ERROR The script $F does not end with a blank line."
        EXIT_CODE=1
    fi
done

if [ $EXIT_CODE -eq 0 ]; then
    echo "$INFO Completed successfully."
fi

exit $EXIT_CODE

