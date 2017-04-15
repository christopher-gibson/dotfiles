#!/bin/bash

# Install fish
curl -L http://get.oh-my.fish | fish

# Fix for theme rbenv issue
rbenv global system

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# terminal italics
tic -x ../iterm/xterm-256color-italic.terminfo
tic -x ../iterm/tmux-256color.terminfo
