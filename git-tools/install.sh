#!/bin/bash

set -euo pipefail

mkdir -p "$HOME/bin"

echo "$(tput setaf 2)[INFO]$(tput sgr0) Creating global git aliases..."
git config --global alias.dirty 'ls --dirty -e'
git config --global alias.get-hash rev-parse
git config --global alias.goto '!sh -c '"'git rev-parse \$0 | xargs git checkout'"

#echo "$(tput setaf 2)[INFO]$(tput sgr0) Adding local pre-commit hooks to .git/config..."
#git config --local --add hooks.pre-commit.hook "EOF.bash"
#git config --local --add hooks.pre-commit.hook "debugger.bash"
#git config --local --add hooks.pre-commit.hook "eslint.bash"
#git config --local --add hooks.pre-commit.hook "gitguardian.sh"
#git config --local --add hooks.pre-commit.hook "pycodestyle.sh"
#git config --local --add hooks.pre-commit.hook "pytest.sh"
#git config --local --add hooks.pre-commit.hook "link-scanner.sh"

echo "$(tput setaf 2)[INFO]$(tput sgr0) Installing git extensions..."
echo
pushd bin
ln -s "$PWD"/git-bootstrap "$HOME/bin/git-bootstrap"
ln -s "$PWD"/git-cleanup "$HOME/bin/git-cleanup"
ln -s "$PWD"/git-init-wrapper "$HOME/bin/git-init-wrapper"
ln -s "$PWD"/git-tools "$HOME/bin/git-tools"
ln -s "$PWD"/git-ls "$HOME/bin/git-ls"
ln -s "$PWD"/git-package-and-release "$HOME/bin/git-package-and-release"
popd

echo
echo "$(tput setaf 2)[INFO]$(tput sgr0) Installation complete."

