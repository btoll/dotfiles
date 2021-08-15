#!/bin/bash
#shellcheck disable=1090

set -euo pipefail

PACKAGES=(
    cowsay
    fortune
    stow
    tmux
    # Install the `setxkbmap` binary needed by `.bash_options` (sets caps lock to ctrl key).
    x11-xkb-utils
)

for package in "${PACKAGES[@]}"
do
    if ! command -v "$package" > /dev/null
    then
        echo "[$0] Installing package \`$package\`..."
        sudo apt-get install --no-install-recommends --yes "$package"
    fi
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

    echo "[$0] Installed \`$tool\` dotfile(s)."
done

# Download other dev dependencies.
echo -e "\n[$0] Installing \`vim-plug\` and \`fzf\`."
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --completion --key-bindings --no-update-rc

# Install vim plugins.
echo -e "\n[$0] Installing vim plugins."
# :help :qa (quit all)
# is just a shorthand notation of -c, see man vim.
vim +'PlugInstall --sync' +qa

#source "$HOME/.fzf.bash"
#source "$HOME/.bash_profile"

echo -e "\n[$0] The dotfiles and dev dependencies have been succesfully installed!"

