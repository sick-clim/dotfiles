#bindkey -v

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt share_history

eval "$(starship init zsh)"

[[ -r ~/.znap/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.znap/zsh-snap

source ~/.znap/zsh-snap/znap.zsh

# zsh plugins
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source ptavares/zsh-direnv

# `znap install` adds new commands and completions.
znap install zsh-users/zsh-completions

alias k=kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)


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
alias gco='git chckout'
alias gpp='git pull --prune'
alias gpr='git pull --rebase'
alias gpo='git push origin HEAD'
alias gcm='git commit -m'
alias gf='git fetch'
alias lg='lazygit'
alias gui='gitui'
alias lad='lazydocker'
alias vi='nvim'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

function gopen() {
    url=$(git config remote.origin.url)
    url=${url%.git}
    url=$(echo $url | sed 's|//.*@|//|')
    if [[ -n $url ]]; then
        open $url
    fi
}

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
bindkey '^H' ssh-fzf

function ghq-fzf() {
    local selected_dir=$(ghq list | fzf-tmux -d --reverse --prompt='repo > ')
    if [[ -n $selected_dir ]]; then
        BUFFER="ghq get --look $selected_dir"
        zle accept-line
    fi
}
zle -N ghq-fzf
bindkey '^G^L' ghq-fzf

function launch-vscode() {
    code .
    # zle accept-line
    zle reset-prompt
}
zle -N launch-vscode
bindkey '^O^V' launch-vscode

function launch-nvim() {
    nvim .
    # zle accept-line
    zle reset-prompt
}
zle -N launch-nvim
bindkey '^K^K' launch-nvim

function git-switch-fzf() {
    local selected_branch=$(git branch --all | fzf-tmux -d --reverse --prompt='git branch > ' | sed -e "s|remotes/origin/||g")
    if [[ -n $selected_branch ]]; then
        BUFFER="git switch $selected_branch"
        zle accept-line
    fi
}
zle -N git-switch-fzf
bindkey '^G^O' git-switch-fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}
