# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS

# eval "$(jump shell --bind=z)"

# zsh起動時にtmux 起動
### [[ -z $TMUX && ! -z $PS1 ]] && exec tmux

# aliases
# alias ls='eza'
alias ll='eza -ahl --git'

alias g='git'
alias gcz='git-cz --disable-emoji'
alias gl='git log'
alias glo='git log --oneline -n 7'
alias glh="git log --graph --oneline --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)%ad%C(reset) %s%C(bold yellow)%d%C(reset) [%an]' --date=short"
alias gg='git log --all --pretty=full --graph'
alias gd='git diff'
alias gs='git status -sb'
alias gb='git branch'
alias gbr='git branch -r'
alias gbc='git rev-parse --abbrev-ref HEAD | pbcopy'
alias gco='git checkout'
alias gpp='git pull --prune'
alias gpr='git pull --rebase'
alias gpo='git push origin HEAD'
alias gcm='git commit -m'
alias gf='git fetch'
alias lg='lazygit'
alias gui='gitui'
alias lad='lazydocker'
alias vi='nvim'
alias d='docker'

function gopen() {
    local url=$(git remote get-url origin 2>/dev/null)
    url=${url%.git}
    url=${url/git@github.com:/https://github.com/}
    url=$(echo $url | sed 's|//.*@|//|')
    if [[ -n $url ]]; then
        open $url
    fi
}

function ssh-fzf() {
    local selected_host
    selected_host=$(grep -i '^host' ~/.ssh/config | awk '{print $2}' | fzf-tmux -d --reverse --prompt='ssh > ')
    if [[ -n ${selected_host} ]]; then
        BUFFER="ssh ${selected_host}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N ssh-fzf
bindkey '^U^I' ssh-fzf

function ghq-fzf() {
    # 1. 画面には短い名前（github.com/user/repo）を表示して選択
    local repo=$(ghq list | fzf-tmux -d --reverse --prompt='repo > ')

    if [[ -n $repo ]]; then
        # 2. 選択した名前から「フルパス」を逆引きする
        local full_path=$(ghq list --full-path --exact "$repo")
        
        # 3. zoxide (z) で移動。これでフルパスが正しく登録される
        BUFFER="cd $full_path"
        zle accept-line
    fi
}
zle -N ghq-fzf
bindkey '^U^U' ghq-fzf

function git-switch-fzf() {
    local selected_branch=$(git branch --all | sed 's/^[* ]*//' | fzf-tmux -d --reverse --prompt='git branch > ' | sed -e "s|remotes/origin/||g")
    if [[ -n $selected_branch ]]; then
        BUFFER="git switch $selected_branch"
        zle accept-line
    fi
}
zle -N git-switch-fzf
bindkey '^U^O' git-switch-fzf

function launch-zed() {
    zed .
    # zle accept-line
    zle reset-prompt
}
zle -N launch-zed
bindkey '^O^P' launch-zed

function launch-vscode() {
    code .
    # zle accept-line
    zle reset-prompt
}
zle -N launch-vscode
bindkey '^O^V' launch-vscode

function launch-helix() {
    hx
    # zle accept-line
    zle reset-prompt
}
zle -N launch-helix
bindkey '^O^O' launch-helix

function launch-nvim() {
    vi .
    # zle accept-line
    zle reset-prompt
}
zle -N launch-nvim
# bindkey '^O^O' launch-nvim


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function switch-remote() {
    if [ -f ~/.remote_work ]; then
        echo "turn off remote"
        rm ~/.remote_work 
    else
        echo "turn on remote"
        touch ~/.remote_work
    fi
}

function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/"$@" ;}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/yoshioka/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# ~/scripts ディレクトリ内のすべてのファイルを読み込む
if [ -d "$HOME/scripts" ]; then
    for file in "$HOME/scripts/"*.sh; do
        source "$file"
    done
fi

alias k=kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

eval "$(/opt/homebrew/bin/mise activate zsh)"

# zoxide
export _ZO_FZF_OPTS="--no-exact --reverse --height=40% --info=inline --bind=ctrl-z:ignore"
eval "$(zoxide init zsh)"

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# copilot CLI 起動用コマンド
c() {
  copilot \
    --allow-tool 'write' \
    --allow-tool "shell(git:*)" \
    --deny-tool "shell(git reset:*)" \
    --deny-tool "shell(git clean:*)" \
    --allow-tool "shell(curl)" \
    --allow-tool "shell(cd:*)" \
    --allow-url "api.github.com" \
    --allow-url "raw.githubusercontent.com" \
    --allow-url "github.com" \
    --allow-tool "shell(find:*)" \
    --allow-tool "shell(which:*)" \
    --allow-tool "shell(xargs:*)" \
    "$@"
}
# eval "$(zellij setup --generate-auto-start zsh)"

# copilot-env-load
# ~/.copilot/.env の環境変数を読み込み
if [ -f ~/.copilot/.env ]; then
  set -a
  source ~/.copilot/.env
  set +a
fi

# bun completions
[ -s "/Users/yoshioka/.bun/_bun" ] && source "/Users/yoshioka/.bun/_bun"
