#!/bin/bash
#shellcheck disable=1090

set -euo pipefail

install_package() {
    local package="$1"
    if ! command -v "$package" > /dev/null
    then
        sudo apt-get install --no-install-recommends --yes "$package"
        echo "$SUCCESS Installed package \`$package\`."
    fi
}

# For colored output in this file :)
install_package tput

SUCCESS="$(tput setaf 5)[$0] $(tput setaf 2)[SUCCESS]$(tput sgr0)"

PACKAGES=(
    cowsay
    curl
    fortune
    stow
    tmux
    # Install the `setxkbmap` binary needed by `.bash_options` (sets caps lock to ctrl key).
    x11-xkb-utils
)

for package in "${PACKAGES[@]}"
do
    install_package "$package"
done

# Remove the default bash files.
rm -f "$HOME/.bash"*

TOOLS=(
    bash
    gdb
    git
    gnupg
    i3
    templates
    tmux
    vim
    xinit
)

for tool in "${TOOLS[@]}"
do
    case "$tool" in
        i3)
            mkdir -p "$HOME/.config/i3"
            stow -t "$HOME/.config/i3" "$tool"
            ;;
        templates)
            cp -r "$tool" "$HOME"
            ;;
        *)
            stow -t "$HOME" "$tool"
            ;;
    esac

    echo "$SUCCESS Installed \`$tool\` dotfile(s)."
done

# Download other dev dependencies.
#   fzf
#   vim-plug

# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --completion --key-bindings --no-update-rc
echo "$SUCCESS Installed \`fzf\`."

# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "$SUCCESS Installed \`vim-plug\`."

# Install vim plugins.
# + is just a shorthand notation of -c.
# +qa = quit all
vim +'PlugInstall --sync' +qa
echo "$SUCCESS Installed vim plugins."

#source "$HOME/.fzf.bash"
#source "$HOME/.bash_profile"

echo "$SUCCESS The dotfiles and dev dependencies have been succesfully installed!"

