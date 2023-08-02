#!/bin/bash

set -euo pipefail

if [ $EUID -ne 0 ]; then
echo -e "$ERROR This script must be run as root!" 1>&2
    exit 1
fi

echo "$INFO Installing git man pages..."
echo
pushd man
ln -s "$PWD"/git-bootstrap.1 /usr/share/man/man1/git-bootstrap.1
ln -s "$PWD"/git-cleanup.1 /usr/share/man/man1/git-cleanup.1
ln -s "$PWD"/git-init-wrapper.1 /usr/share/man/man1/git-init-wrapper.1
ln -s "$PWD"/git-hub.1 /usr/share/man/man1/git-hub.1
ln -s "$PWD"/git-ls.1 /usr/share/man/man1/git-ls.1
ln -s "$PWD"/git-package-and-release.1 /usr/share/man/man1/git-package-and-release.1
popd

echo
echo "$INFO Installation complete."

