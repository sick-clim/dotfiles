#!/bin/bash -eu
set -e

readonly DOTFILES=(
  .vimrc
  .zshrc
  .zshenv
  #  .tool-versions
  #  TODO: artro へ移行
  #  .config/nvim/init.vim
  .config/tmux/statusline.conf
  .config/tmux/tmux.conf
  .config/karabiner/karabiner.json
  #  .config/lvim/config.lua
  .config/helix/config.toml
  .config/alacritty/alacritty.toml
)
type brew

# aqua 使用案
# install aqua
# temp にaqua 設定ファイルGET
# ghq でget
# aqua install

# mise 使用案
# install mise with berw
# install ghq from mise
# setting ghq

ghq get sick-clim/dotfiles
repo_path=$(ghq list dotfiles)
ghq_root=$(ghq root)
cd $ghq_root/$repo_path

# Memo: .config 配下をディレクトリ別にシンボリックリンクでも良いかも？
mkdir -p ~/.config
for d in nvim tmux karabiner; do
  mkdir -p ~/.config/${d}
done

for f in ${DOTFILES[@]}; do
  ln -snfv ${PWD}/${f} ~/${f}
done
