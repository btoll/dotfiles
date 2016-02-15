#!/bin/bash

echo "$(tput setaf 2)[INFO]$(tput sgr0) Installing dotfiles in home directory..."

ln -s /usr/local/src/dotfiles/.bash_aliases ~/.bash_aliases
ln -s /usr/local/src/dotfiles/.bash_fortune ~/.bash_fortune
ln -s /usr/local/src/dotfiles/.bash_functions ~/.bash_functions
ln -s /usr/local/src/dotfiles/.bash_logout ~/.bash_logout
ln -s /usr/local/src/dotfiles/.bash_profile ~/.bash_profile
ln -s /usr/local/src/dotfiles/.bashrc ~/.bashrc
ln -s /usr/local/src/dotfiles/.cdargs ~/.cdargs
ln -s /usr/local/src/dotfiles/.eslint ~/.eslint
ln -s /usr/local/src/dotfiles/.gitconfig ~/.gitconfig
ln -s /usr/local/src/dotfiles/.screenrc ~/.screenrc
ln -s /usr/local/src/dotfiles/.tmux.conf ~/.tmux.conf
ln -s /usr/local/src/dotfiles/.vimrc ~/.vimrc

echo
echo "$(tput setaf 2)[INFO]$(tput sgr0) Installation complete."

