#!/bin/bash -eu
set -e

readonly DOTFILES=(.vimrc .tmux.conf .zshrc .zshenv .tool-versions)

which ghq

ghq get sick-clim/dotfiles
repo_path=$(ghq list dotfiles)
ghq_root=$(ghq root)
cd $ghq_root/$repo_path

for f in ${DOTFILES[@]}; do
    ln -snfv ${PWD}/${f} ~/${f}
done

