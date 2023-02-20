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

# symlink dotfiles
alias link_dotfiles="rcup -x README.md -x setup.sh -x install -x iterm -v"

clean_nvim() {
  # Remove old backups
  rm -rf ~/.config/nvim.bak
  rm -rf ~/.local/share/nvim.bak
  rm -rf ~/.local/state/nvim.bak
  rm -rf ~/.cache/nvim.bak

  # Create a backup
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  mv ~/.local/state/nvim ~/.local/state/nvim.bak
  mv ~/.cache/nvim ~/.cache/nvim.bak

  # symlink dotfiles again
  link_dotfiles
}
