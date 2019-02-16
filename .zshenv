
typeset -U path PATH
path=(
  /home/linuxbrew/.linuxbrew/bin(N-/)
  $HOME/bin(N-/)
  $GOPATH/bin(N-/)
  $path
)

export GOPATH=$HOME

