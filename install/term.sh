#!/bin/bash

# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Fix for theme rbenv issue
rbenv global system

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# terminal italics
tic -x ../iterm/xterm-256color-italic.terminfo
tic -x ../iterm/tmux-256color.terminfo
