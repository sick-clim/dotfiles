# dotfiles

dotfiles リポジトリを取得し、ホームディレクトリに dotfile へのシンボリックリンクを作成する
リポジトリの取得に ghq を使用

```bash
curl -fs https://raw.githubusercontent.com/sick-clim/dotfiles/master/dotfiles_link.sh | bash -s
```

git bare を使った方法
```bash
git config --global user.name <name>
git config --global user.email <e-mail>

git clone --bare https://github.com/sick-clim/dotfiles ~/dotfiles
cd
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME
```
