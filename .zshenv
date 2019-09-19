
typeset -U path PATH
path=(
  /home/linuxbrew/.linuxbrew/bin(N-/)
  /usr/local/bin(N-/)
  $HOME/bin(N-/)
  $GOPATH/bin(N-/)
  $PYENV_ROOT/bin(N-/)
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  $path
)

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export GOPATH=$HOME
export PYENV_ROOT="$HOME/.pyenv"
export AWS_DEFAULT_PROFILE=localstack

