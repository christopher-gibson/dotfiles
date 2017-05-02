autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{white}:%F{white}%r'
zstyle ':vcs_info:*' enable git svn

theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%B%F{yellow}  %F{white}%b %c%u%F{white}'
    } else {
        zstyle ':vcs_info:*' formats '%B%F{yellow}  %F{white}%b %c%u%F{red}●%f'
    }

    vcs_info
}

setopt prompt_subst
PROMPT='%F{magenta}$(shrink_path -f)${vcs_info_msg_0_}%f %B%%%b '

RPROMPT='%F{08}%D{%a %b %d %H:%M:%S}%f'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

