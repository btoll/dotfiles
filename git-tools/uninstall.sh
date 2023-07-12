#!/bin/bash

set -euo pipefail

echo "$(tput setaf 2)[INFO]$(tput sgr0) Unsetting global git aliases..."
echo
git config --global --unset alias.get-hash
git config --global --unset alias.goto

echo "$(tput setaf 2)[INFO]$(tput sgr0) Removing symbolic links for git extensions..."
echo
rm "$HOME/bin/git-bootstrap"
rm "$HOME/bin/git-cleanup"
rm "$HOME/bin/git-init-wrapper"
rm "$HOME/bin/git-tools"
rm "$HOME/bin/git-ls"
rm "$HOME/bin/git-package-and-install"

echo "$(tput setaf 2)[INFO]$(tput sgr0) Removing git man pages..."
echo
rm /usr/local/share/man/man1/git-bootstrap.1
rm /usr/local/share/man/man1/git-cleanup.1
rm /usr/local/share/man/man1/git-init-wrapper.1
rm /usr/local/share/man/man1/git-hub.1
rm /usr/local/share/man/man1/git-ls.1
rm /usr/local/share/man/man1/git-package-and-install.1

echo
echo "$(tput setaf 2)[INFO]$(tput sgr0) Uninstall complete."

