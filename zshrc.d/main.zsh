ZSH_THEME="gibson"

plugins=(
  git
  node
  yarn
  history-substring-search
  shrink-path
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias vim="nvim"
alias vim-install="vim +PlugInstall +qa"
alias vim-update="vim +PlugUpdate +qa"
alias vim-clean="vim +PlugClean +y +qa"

pwd_name() { basename $(pwd) | tr " ." - }
tn() { tmux new -s $(pwd_name) }
alias tm="tmux"

alias ag="ag --hidden --ignore .git"

fake() {
  echo "Fake $1!"
  pkill -9 -f $1
}
