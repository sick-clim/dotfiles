
#plug "zsh-users/zsh-autosuggestions"
#plug "zsh-users/zsh-syntax-highlighting"


# Load and initialise completion system
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# 補完時の大文字・小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS


# zsh起動時にtmux 起動
### [[ -z $TMUX && ! -z $PS1 ]] && exec tmux

# aliases
alias ls='eza'
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
alias gpp='git pull --prune'
alias gwl='git worktree list'
alias gpr='git pull --rebase'
alias gpo='git push origin HEAD'
alias gcm='git commit -m'
alias gf='git fetch'
alias lg='lazygit'
alias gui='gitui'
alias lad='lazydocker'
# alias vi='nvim'
alias vi='hx'
alias docker='nerdctl'
alias d='docker'

function ssh-fzf() {
    local selected_host
    selected_host=$(cat ~/.ssh/config | grep -i '^host' | awk '{print $2}' | fzf-tmux -d --reverse --prompt='ssh > ')
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

function ghq-herdr-fzf() {
    # 1. 画面には短い名前（github.com/user/repo）を表示して選択
    local repo=$(ghq list | fzf-tmux -d --reverse --prompt='herdr workspace > ')

    if [[ -n $repo ]]; then
        # 2. 選択した名前から「フルパス」を逆引きする
        local full_path=$(ghq list --full-path --exact "$repo")

        # 3. herdr の別ワークスペースとしてそのリポジトリを開く
        herdr workspace create --cwd "$full_path" --label "$(basename "$full_path")" --focus
    fi
    zle reset-prompt
}
zle -N ghq-herdr-fzf
bindkey '^U^N' ghq-herdr-fzf

function git-switch-fzf() {
    local selected_branch=$(git branch --all | fzf-tmux -d --reverse --prompt='git branch > ' | sed -e "s|remotes/origin/||g" -e "s/^[*+ ]*//")
    if [[ -n $selected_branch ]]; then
        BUFFER="git switch $selected_branch"
        zle accept-line
    fi
}
zle -N git-switch-fzf
bindkey '^U^O' git-switch-fzf

function gw() {
    local target_dir
    target_dir=$(git worktree list | fzf | awk '{print $1}')

    if [ -n "$target_dir" ]; then
      cd "$target_dir" || return
      echo "Moved to: $target_dir"
    fi
}
zle -N gw
bindkey '^U^W' gw

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


alias k=kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

eval "$(mise activate zsh)"

# zoxide
export _ZO_FZF_OPTS="--no-exact --reverse --height=40% --info=inline --bind=ctrl-z:ignore"
eval "$(zoxide init zsh)"

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
source <(fzf --zsh)

# claude CLI 起動用コマンド
c() {
  claude \
    --allowedTools \
      "Write" \
      "Bash(git *)" \
      "Bash(curl *)" \
      "Bash(cd *)" \
      "Bash(find *)" \
      "Bash(which *)" \
      "Bash(xargs *)" \
      "WebFetch(domain:api.github.com)" \
      "WebFetch(domain:raw.githubusercontent.com)" \
      "WebFetch(domain:github.com)" \
    --disallowedTools \
      "Bash(git reset *)" \
      "Bash(git clean *)" \
    "$@"
}

# copilot-env-load
# ~/.copilot/.env の環境変数を読み込み
if [ -f ~/.copilot/.env ]; then
  set -a
  source ~/.copilot/.env
  set +a
fi

# bun completions
[ -s "/Users/yoshioka/.bun/_bun" ] && source "/Users/yoshioka/.bun/_bun"

eval "$(starship init zsh)"

