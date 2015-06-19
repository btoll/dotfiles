#!/bin/bash

echo "$(tput setaf 2)[INFO]$(tput sgr0) Installing dotfiles in home directory..."

ln -s /usr/local/src/dotfiles/.bash_aliases ~/.bash_aliases
ln -s /usr/local/src/dotfiles/.bash_functions ~/.bash_functions
ln -s /usr/local/src/dotfiles/.bash_logout ~/.bash_logout
ln -s /usr/local/src/dotfiles/.bash_profile ~/.bash_profile
ln -s /usr/local/src/dotfiles/.bashrc ~/.bashrc
ln -s /usr/local/src/dotfiles/.cdargs ~/.cdargs
ln -s /usr/local/src/dotfiles/.gitconfig ~/.gitconfig
ln -s /usr/local/src/dotfiles/.screenrc ~/.screenrc
ln -s /usr/local/src/dotfiles/.tmux.conf ~/.tmux.conf
ln -s /usr/local/src/dotfiles/.vimrc ~/.vimrc

echo "$(tput setaf 2)[INFO]$(tput sgr0) Installing Vim plugins..."

mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

pushd ~/.vim/bundle
git clone https://github.com/vim-scripts/argtextobj.vim
git clone https://github.com/kien/ctrlp.vim

git clone https://github.com/mattn/gist-vim.git
git clone https://github.com/mattn/webapi-vim

git clone http://sjl.bitbucket.org/gundo.vim/
git clone https://github.com/scrooloose/syntastic
git clone https://github.com/marijnh/tern_for_vim
git clone https://github.com/bling/vim-airline
git clone https://github.com/bitc/vim-bad-whitespace
git clone https://github.com/flazz/vim-colorschemes
git clone https://github.com/ap/vim-css-color
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/maksimr/vim-jsbeautify
git clone https://github.com/tpope/vim-surround

popd

echo
echo "$(tput setaf 2)[INFO]$(tput sgr0) Installation complete."

