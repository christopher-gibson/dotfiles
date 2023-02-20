#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew install neovim the_silver_searcher rcm ripgrep
else
  # install neovim supporting lua configs
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt-get update

  # Install dependencies
  sudo apt-get install -y rcm silversearcher-ag neovim ripgrep
fi

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add neovim python
pip3 install --user neovim

# create vim undo directory
mkdir -p ~/.vim/undo

# symlink dotfiles
rcup -x README.md -x setup.sh -x install -x iterm -v
