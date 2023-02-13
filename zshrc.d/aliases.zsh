alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias vim="nvim"

pwd_name() { basename $(pwd) | tr " ." - }
tn() { tmux new -s $(pwd_name) }
alias tm="tmux"

alias ag="ag --hidden --ignore .git"

fake() {
  echo "Fake $1!"
  pkill -9 -f $1
}

alias vim-update="vim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"
