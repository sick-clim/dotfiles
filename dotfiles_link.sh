#!/bin/bash -eu
set -e

readonly DOTFILES=(
  .vimrc
  .zshrc
  .zshenv
#  .tool-versions
  .config/nvim/init.vim
  .config/tmux/statusline.conf
  .config/tmux/tmux.conf
#  .config/lvim/config.lua
)

# aqua 使用案
# install aqua
# temp にaqua 設定ファイルGET
# ghq でget
# aqua install

# mise 使用案
# install mise with berw
# install ghq from mise
# setting ghq

type brew

ghq get sick-clim/dotfiles
repo_path=$(ghq list dotfiles)
ghq_root=$(ghq root)
cd $ghq_root/$repo_path

mkdir -p ~/.config
for d in nvim tmux; do
    mkdir -p ~/.config/${d}
done

for f in ${DOTFILES[@]}; do
    ln -snfv ${PWD}/${f} ~/${f}
done

