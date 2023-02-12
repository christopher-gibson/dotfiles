#!/bin/bash

# install neovim supporting lua configs
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update

# Install dependencies
sudo apt-get install -y rcm silversearcher-ag neovim ripgrep

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add neovim python
pip3 install --user neovim

# create vim undo directory
mkdir -p ~/.vim/undo

# symlink dotfiles
rcup -x README.md -x setup.sh -x install -x iterm -v
