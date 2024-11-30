#!/bin/bash
# shellcheck disable=1091

. colors.sh

set -euo pipefail

echo -e "$INFO Unsetting global git aliases..."
git config --global --unset alias.get-dirty
git config --global --unset alias.get-hash
git config --global --unset alias.goto

BINDIR="$HOME/.local/bin/git-tools"
echo -e "$INFO Removing symbolic links for git extensions..."
rm "$BINDIR/git-bootstrap"
rm "$BINDIR/git-cleanup"
rm "$BINDIR/git-hooks"
rm "$BINDIR/git-init-wrapper"
rm "$BINDIR/git-ls"
rm "$BINDIR/git-package-and-install"

SHAREDIR="$HOME/.local/share/git-tools"
echo -e "$INFO Removing symbolic links for git bootstrap files..."
rm "$SHAREDIR/LICENSE"
rm "$SHAREDIR/README.md"

MANDIR=/usr/share/man/man1
echo -e "$INFO Removing git man pages..."
rm "$MANDIR/git-bootstrap.1"
rm "$MANDIR/git-cleanup.1"
rm "$MANDIR/git-init-wrapper.1"
rm "$MANDIR/git-hub.1"
rm "$MANDIR/git-ls.1"
rm "$MANDIR/git-package-and-install.1"

echo -e "$SUCCESS Uninstall complete."

