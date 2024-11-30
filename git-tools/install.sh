#!/bin/bash
# shellcheck disable=1091

. colors.sh

set -euo pipefail

echo -e "$INFO Creating global git aliases..."
git config --global alias.dirty 'ls --dirty -e'
git config --global alias.get-hash rev-parse
git config --global alias.goto '!sh -c '"'git rev-parse \$0 | xargs git checkout'"

BINDIR="$HOME/.local/bin/git-tools"
mkdir -p "$BINDIR"
echo -e "$INFO Installing git extensions into $BINDIR..."
pushd bin > /dev/null
ln -s "$PWD"/git-bootstrap "$BINDIR/git-bootstrap"
ln -s "$PWD"/git-cleanup "$BINDIR/git-cleanup"
ln -s "$PWD"/git-hooks "$BINDIR/git-hooks"
ln -s "$PWD"/git-init-wrapper "$BINDIR/git-init-wrapper"
ln -s "$PWD"/git-ls "$BINDIR/git-ls"
ln -s "$PWD"/git-package-and-release "$BINDIR/git-package-and-release"
popd > /dev/null

echo -e "$INFO Installing git hooks into $BINDIR..."
cp -r hooks "$BINDIR"

SHAREDIR="$HOME/.local/share/git-tools/bootstrap/"
mkdir -p "$SHAREDIR"
echo -e "$INFO Installing git bootstrap files into $SHAREDIR..."
cp bootstrap/* "$SHAREDIR"

export PATH=$PATH:$HOME/.local/bin/git-tools/
echo -e "$SUCCESS Installation complete."

