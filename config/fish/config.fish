set -g theme_nerd_fonts yes
set -g theme_color_scheme gruvbox
set EDITOR "mvim -v"

alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

alias cleanup "find . -type f -name '*.DS_Store' -ls -delete"

alias vim "mvim -v"
alias vim-install "vim +PlugInstall +qa"
alias vim-update "vim +PlugUpdate +qa"
alias vim-clean "vim +PlugClean +y +qa"

alias tn "tmux new -s (pwd_name)"
alias tm "tmux"

alias ip "dig +short myip.opendns.com @resolver1.opendns.com"
alias localip "ipconfig getifaddr en0"

alias dc "docker-compose"
alias dvclean "docker volume rm (docker volume ls -qf dangling=true)"
alias diprune "docker rmi (docker images -f 'dangling=true' -q)"
alias dmu "eval (docker-machine env --unset)"

alias ag "ag --hidden --ignore .git"

status --is-interactive; and source (rbenv init -|psub)
