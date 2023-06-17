#!/bin/bash

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
    feh
    fortune
    i3
    kitty
    silversearcher-ag
    stow
    tmux
    # Install the `setxkbmap` binary needed by `.bash_options` (sets caps lock to ctrl key).
    x11-xkb-utils
    xsel
)

for package in "${PACKAGES[@]}"
do
    install_package "$package"
done

# Remove the default bash and vim files.
rm -f "$HOME/.bash"*
rm -rf "$HOME/.vim"*
rm -f "$HOME/.gitconfig"

TOOLS=(
    bash
    gdb
    git
    git-hub
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
        git-hub)
            mkdir -p "$HOME/bin"
            stow --dotfiles --target "$HOME/bin" --dir "$tool" bin
            stow --target /usr/share/man/man1/ --dir "$tool" man
            ;;
        i3)
            mkdir -p "$HOME/.config/$tool"
            stow --dotfiles --target "$HOME/.config/$tool" "$tool"
            ;;
        gnupg|templates)
            mkdir -p "$HOME/$tool"
            stow --target "$HOME/$tool" "$tool"
            ;;
        vim)
            stow --dotfiles --target "$HOME" "$tool"
            mkdir -p "$HOME/.$tool/ftplugin"
            stow --target "$HOME/.$tool/ftplugin" --dir "$tool" ftplugin
            ;;
        *)
            stow --dotfiles --target "$HOME" "$tool"
            ;;
    esac

    echo "$SUCCESS Installed \`$tool\` dotfile(s)."
done

# Download other dev dependencies.
#   fzf
#   vim-plug

# https://github.com/junegunn/fzf
if [ ! -d "$HOME/.fzf" ]
then
    git clone --depth 1 git@github.com:junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --completion --key-bindings --no-update-rc
    echo "$SUCCESS Installed \`fzf\`."
fi

# https://github.com/tmux-plugins/tpm
if [ ! -d "$HOME/.tmux" ]
then
    git clone git@github.com:tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [ ! -d "$HOME/.vim/autoload" ] || [ ! -f "$HOME/.vim/autoload/plug.vim" ]
then
    # https://github.com/junegunn/vim-plug
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "$SUCCESS Installed \`vim-plug\`."
fi

# Install vim plugins.
# + is just a shorthand notation of -c.
# +qa = quit all
vim +'PlugInstall --sync' +qa
echo "$SUCCESS Installed vim plugins."

#source "$HOME/.fzf.bash"
#source "$HOME/.bash_profile"

echo "$SUCCESS The dotfiles and dev dependencies have been succesfully installed!"

