#!/bin/bash

# Install dependencies
sudo apt-get install -y rcm silversearcher-ag

# Add neovim python
pip3 install --user neovim

# create vim undo directory
mkdir -p ~/.vim/undo

# symlink dotfiles
rcup -x README.md -x setup.sh -x install -x iterm -v
