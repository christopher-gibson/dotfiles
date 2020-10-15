#!/bin/bash

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
