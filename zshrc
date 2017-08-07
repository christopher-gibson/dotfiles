# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gibson"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  docker-compose
  git-flow-avh
  golang
  nvm
  osx
  node
  npm
  yarn
  mix
  react-native
  history-substring-search
  shrink-path
)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Add android sdk path
export ANDROID_HOME=/usr/local/opt/android-sdk

# Preferred editor for local and remote sessions

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

pwd_name() { basename $(pwd) | tr " ." - }
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

alias vim="nvim"
alias vim-install="vim +PlugInstall +qa"
alias vim-update="vim +PlugUpdate +qa"
alias vim-clean="vim +PlugClean +y +qa"

tn() { tmux new -s $(pwd_name) }
alias tm="tmux"

alias dc="docker-compose"
dvclean() { for c in $(docker volume ls -qf dangling=true); do docker volume rm $c; done }
diprune() { for c in $(docker images -f 'dangling=true' -q); do docker rmi $c; done }
dkill() {
  for c in $(docker ps -q); do docker stop $c; done
  for c in $(docker ps -a -q); do docker rm $c; done
}

alias ag="ag --hidden --ignore .git"


[[ -s "/Users/cgibson026/.gvm/scripts/gvm" ]] && source "/Users/cgibson026/.gvm/scripts/gvm"
