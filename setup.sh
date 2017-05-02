#!/bin/bash

source ./install/brew.sh
source ./install/term.sh
source ./install/vim.sh
source ./install/atom.sh

rcup -x README.md -x setup.sh -x install -x iterm -v
