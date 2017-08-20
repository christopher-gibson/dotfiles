#!/bin/bash

brew cask install atom

plugins=(
  Sublime-Style-Column-Selection
  atom-beautify
  atom-typescript
  editorconfig
  file-icons
  language-elixir
  language-javascript-jsx
  linter
  linter-eslint
  linter-sass-lint
  linter-stylelint
)

apm install ${plugins[@]}
