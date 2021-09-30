#!/bin/bash

formulas=(
  rcm
)

brew tap ${taps[@]}
brew install ${formulas[@]}
