# vim:ft=zsh ts=2 sw=2 sts=2

autoload -Uz vcs_info
setopt prompt_subst

# zstyle ':vcs_info:*' stagedstr '%F{10}●'
# zstyle ':vcs_info:*' unstagedstr '%F{11}●'
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' enable git

# zstyle ':vcs_info:git+post-backend:*' hooks git-remote-staged

# function +vi-git-remote-staged() {
#   if [[ ! -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
#     zstyle ':vcs_info:*' formats '%F{11}  %f%b %c%u%F{9}●%f'
#   elif (( gitstaged || gitunstaged )); then
#     zstyle ':vcs_info:*' formats '%F{11}  %f%b %c%u%f'
#   else
#     zstyle ':vcs_info:*' formats '%F{11}  %f%b%f'
#   fi
# }

theme_precmd () {
  vcs_info
}

user() {
  echo -n '%F{9}[%n]%f '
}

# prompt_docker_machine() {
#   if [[ ! -z $DOCKER_MACHINE_NAME ]]; then
#     echo -n "($DOCKER_MACHINE_NAME) "
#   fi
# }

prompt_dir() {
  echo -n "%F{magenta}$(shrink_path -f)%f"
}

# prompt_git() {
#   echo -n "${vcs_info_msg_0_}"
# }

prompt_end() {
  echo -n "%B%(?.%F{15}.%F{9}%})"
  echo -n " %% "
  echo -n "%f%b"
}

prompt_time() {
  echo -n "%F{8}%D{%a %b %d %H:%M:%S}%f"
}

prompt_reset() {
  echo -n "%f%b"
}

build_left_prompt() {
  user
  # prompt_docker_machine
  prompt_dir
  # prompt_git
  prompt_end
}

build_right_prompt() {
  prompt_reset
  prompt_time
}

PROMPT='$(build_left_prompt)'
RPROMPT='$(build_right_prompt)'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

