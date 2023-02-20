export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gibson"

plugins=(
  git
  node
  yarn
  history-substring-search
  shrink-path
)

if [[ "$OSTYPE" == "darwin"* ]]; then
  plugins+=(
    asdf
    macos
  )
fi

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home

export PATH=/Users/christophergibson/.local/bin:$PATH
export PATH="`yarn global bin`:$PATH"
