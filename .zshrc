# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=100000
HISTFILE=~/.zsh_history

eval "$(jump shell --bind=z)"

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

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


### . /opt/homebrew/opt/asdf/libexec/asdf.sh

alias k=kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

eval "$(/opt/homebrew/bin/mise activate zsh)"

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
