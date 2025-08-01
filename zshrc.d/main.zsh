export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gibson"

plugins=(
  git
  node
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

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

#### M4 and ruby 3
# export RUBY_CONFIGURE_OPTS="--with-zlib-dir=$(brew --prefix zlib) --with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline) --with-libyaml-dir=$(brew --prefix libyaml)"
