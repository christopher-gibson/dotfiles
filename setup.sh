#!/bin/bash

source ./install/programming.sh
source ./install/vim.sh

ln -s ~/.dotfiles/iterm/themes ~/themes
rcup -x README.md -x setup.sh -x install -x iterm -v
