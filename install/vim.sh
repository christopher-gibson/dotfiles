#!/bin/bash

brew install neovim the_silver_searcher

# Python support for neovim
pip3 install --user neovim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create undodir
mkdir -p ~/.vim/undo

# Install plugins
vim +PlugInstall +qa
