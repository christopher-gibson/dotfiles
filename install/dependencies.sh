#!/bin/bash

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

taps=(
  thoughbot/formulae
)

formulas=(
  coreutils
  git
  rcm
)

casks=(
  google-chrome
  docker
)

brew tap ${taps[@]}
brew install ${formulas[@]}
brew cask install ${casks[@]}
