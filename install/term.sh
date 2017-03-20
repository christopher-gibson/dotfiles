#!/bin/bash

# Install fish
curl -L http://get.oh-my.fish | fish

# Install oh my fish
omf install

# Install omf packages and theme
omfpackages=(
  nvm
  osx
  nvm
  rbenv
  foreign-env
  android-sdk
  bobthefish
)

omf install ${omfpackages[@]}
omf theme bobthefish

# Fix for theme rbenv issue
rbenv global system

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# terminal italics
tic -x ../iterm/xterm-256color-italic.terminfo
tic -x ../iterm/tmux-256color.terminfo
