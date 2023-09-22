#!/bin/bash -eu
set -e

readonly DOTFILES=(
  .vimrc
  .zshrc
  .zshenv
  .tool-versions
  .config/nvim/init.vim
  .config/tmux/statusline.conf
  .config/tmux/tmux.conf
  .config/lvim/config.lua
)

which ghq

ghq get sick-clim/dotfiles
repo_path=$(ghq list dotfiles)
ghq_root=$(ghq root)
cd $ghq_root/$repo_path

mkdir -p ~/.config/nvim

for f in ${DOTFILES[@]}; do
    ln -snfv ${PWD}/${f} ~/${f}
done

