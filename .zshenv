
typeset -U path PATH
path=(
  /home/linuxbrew/.linuxbrew/bin(N-/)
  /usr/local/bin(N-/)
  $HOME/bin(N-/)
  $GOPATH/bin(N-/)
  $PYENV_ROOT/bin(N-/)
#  $(brew --prefix coreutils)/libexec/gnubin(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.local/bin(N-/)
  $path
)

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PYENV_ROOT="$HOME/.pyenv"

# awscli
#export AWS_DEFAULT_PROFILE=localstack
#export AWS_DEFAULT_PROFILE=

# cargo
. "$HOME/.cargo/env"

