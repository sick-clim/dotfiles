#!/bin/bash

# for Ubuntu
apt install -y zip unzip

# install mise
if type mise >/dev/null 2>&1; then
  curl https://mise.run | sh
fi

~/.local/bin/mise activate zsh
mise i
