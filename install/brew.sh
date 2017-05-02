#!/bin/bash

# # Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

taps=(
  thoughbot/formulae
)

formulas=(
  coreutils
  git
  tmux
  python3
  node
  yarn
  nvm
  rbenv
  android-sdk
  elixir
  rcm
  the_silver_searcher
  tig
  reattach-to-user-namespace
)

casks=(
  macvim
  google-chrome
  iterm2
  virtualbox
  docker
)

brew tap ${taps[@]}
brew install ${formulas[@]}
brew cask install ${casks[@]}
