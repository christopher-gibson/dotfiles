# vim:ft=zsh ts=2 sw=2 sts=2

autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git

theme_precmd () {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats '%F{yellow}  %F{white}%b %c%u%f'
  } else {
    zstyle ':vcs_info:*' formats '%F{yellow}  %F{white}%b %c%u%F{red}●%f'
  }

  vcs_info
}


prompt_dir() {
  echo -n '%F{magenta}$(shrink_path -f)%f'
}

prompt_git() {
  echo -n '${vcs_info_msg_0_}'
}

prompt_end() {
  echo -n ' %f%B%%%b '
}

prompt_time() {
  echo -n '%F{08}%D{%a %b %d %H:%M:%S}%f'
}

build_left_prompt() {
  prompt_dir
  prompt_git
  prompt_end
}

build_right_prompt() {
  prompt_time
}

PROMPT="$(build_left_prompt)"
RPROMPT="$(build_right_prompt)"

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

