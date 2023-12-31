#!/bin/bash

# Note this script is to be run on Debian.
# It will fail on other distros, even Debian-derivatives like Ubuntu.
# ( For example, Ubuntu doesn't have `kitty`, and it downloads an older
# version of `stow` that doesn't support the `--dotfiles` option.
# There could be more. )
# Deal with it.

set -euo pipefail

install_package() {
    local package="$1"
    if ! command -v "$package" > /dev/null
    then
        sudo apt-get install --no-install-recommends --yes "$package"
        printf "%b Installed package \`%s\`.\n" "$SUCCESS" "$package"
    fi
}

# For colored output in this file :)
install_package tput

SUCCESS="$(tput setaf 5)[$0] $(tput setaf 2)[SUCCESS]$(tput sgr0)"

PACKAGES=(
    bash-completion
    bc
    bsdmainutils
    cowsay
    curl
    dmenu
    exuberant-ctags
    feh
    fonts-noto
    fortune
    gdb
    git
    i3
    i3lock
    i3status
    kitty
    python3
    python3-pip
    silversearcher-ag
    stow
    tmux
    # Install the `setxkbmap` binary needed by `.bash_options` (sets caps lock to ctrl key).
    x11-xkb-utils
    xsel
    vim
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
    git-tools
    gnupg
    i3
    systemd
    templates
    tmux
    vim
    xinit
)

for tool in "${TOOLS[@]}"
do
    case "$tool" in
        git-tools)
            mkdir -p "$HOME/bin"
            stow --dotfiles --target "$HOME/bin" --dir "$tool" bin
            #stow --target /usr/share/man/man1/ --dir "$tool" man
            ;;
        gnupg)
            mkdir -p "$HOME/.$tool"
            stow --target "$HOME/.$tool" "$tool"
            ;;
        i3)
            mkdir -p "$HOME/.config/$tool"
            stow --target "$HOME/.config/$tool" "$tool"
            ;;
        systemd)
            sudo cp "$tool"/* "/lib/systemd/system"
            ;;
        templates)
            mkdir -p "$HOME/$tool"
            stow --target "$HOME/$tool" "$tool"
            ;;
        vim)
            stow --dotfiles --target "$HOME" "$tool"
            # This is a kludge.  The `ftplugin` dir will be installed to
            # the home dir, so remove it and then put it in its proper
            # location.
            # Note that we're removing it rather than moving it to `.vim/`
            # because the files aren't linked (they will be below).
            rm -rf "$HOME/ftplugin"
            # Now, put `ftplugin` in its right spot and link them.
            mkdir -p "$HOME/.$tool/ftplugin"
            stow --target "$HOME/.$tool/ftplugin" --dir "$tool" ftplugin
            ;;
        *)
            stow --dotfiles --target "$HOME" "$tool"
            ;;
    esac

    printf "%b Installed \`%s\` dotfile(s).\n" "$SUCCESS" "$tool"
done

# Download other dev dependencies.
#   fzf
#   vim-plug

# We could go through contortions to determine if the pubkey is already in
# known_hosts, but it's not worth it just to prevent a possible duplicate.
ssh-keyscan github.com >> "$HOME/.ssh/known_hosts"

# https://github.com/junegunn/fzf
# `~/.fzf/bin` is appended to `PATH` when `~/.fzf.bash` is sourced in `.bash_vendor`.
if [ ! -d "$HOME/.fzf" ]
then
    git clone --depth 1 git@github.com:junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --completion --key-bindings --no-update-rc
    printf "%b Installed \`fzf\`.\n" "$SUCCESS"
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
    printf "%b Installed \`vim-plug\`.\n" "$SUCCESS"
fi

# Install vim plugins.
# + is just a shorthand notation of -c.
# +qa = quit all
vim +'PlugInstall --sync' +qa
printf "%b Installed vim plugins.\n" "$SUCCESS"

#source "$HOME/.fzf.bash"
#source "$HOME/.bash_profile"

printf "%b The dotfiles and dev dependencies have been succesfully installed!\n" "$SUCCESS"

