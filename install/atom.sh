#!/bin/bash

plugins=(
  Sublime-Style-Column-Selection
  atom-beautify
  atom-material-ui
  atom-typescript
  editorconfig
  file-icons
  git-blame
  git-time-machine
  language-elixir
  language-ethereum
  language-javascript-jsx
  linter
  linter-eslint
  linter-sass-lint
  linter-stylelint
  markdown-preview-plus
  merge-conflicts
  pigments
  project-plus
  rename-tabs
  smart-tab-name
)

apm install ${plugins[@]}
