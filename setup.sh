#!/bin/bash

# Install dependencies
sudo apt-get install -y rcm silversearcher-ag

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add neovim python
pip3 install --user neovim

# create vim undo directory
mkdir -p ~/.vim/undo

# symlink dotfiles
rcup -x README.md -x setup.sh -x install -x iterm -v
