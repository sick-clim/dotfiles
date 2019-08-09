LANG=en_US.UTF-8

# Set up the prompt

#autoload -Uz promptinit
autoload -Uz vcs_info
autoload -Uz colors
colors
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info  }

# プロンプト（左）
PROMPT='${vcs_info_msg_0_} %{${fg[green]}%}%}'
PROMPT=$PROMPT'%{${fg[red]}%}[%~]%{${reset_color}%}
❯❯%{${reset_color}%} '

# プロンプト（右）

#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ----------------------------------------------------------------
# zsh起動時にtmux 起動
[[ -z $TMUX && ! -z $PS1 ]] && exec tmux

# setopt noflowcontrol
stty stop undef

setopt auto_cd
setopt auto_pushd
setopt correct

# aliases
alias ll='ls -al'
alias gl='git log'
alias glo='git log --oneline -n 7'
alias gd='git diff'
alias gs='git status -sb'
alias gb='git branch'
alias gbr='git branch -r'
alias gco='git chckout'
alias gcm='git commit -m'
alias gf='git fetch'

function ssh-fzf() {
    local selected_host
    selected_host=$(cat ~/.ssh/config | grep -i ^host | awk '{print $2}' | fzf-tmux -d --reverse --prompt='ssh > ')
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
        BUFFER="ghq look $selected_dir"
        zle accept-line
    fi
}
zle -N ghq-fzf
bindkey '^G^L' ghq-fzf

function git-status() {
    if [[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" == "true" ]]; then
        echo git status -sb
        BUFFER="git status -sb"
        zle accept-line
    fi
    #zle reset-prompt
}
zle -N git-status
bindkey '^Gs' git-status

function git-checkout-fzf() {
    local selected_branch=$(git branch --all | fzf-tmux -d --reverse --prompt='git branch > ' | sed -e "s|remotes/origin/||g")
    if [[ -n $selected_branch ]]; then
        BUFFER="git checkout $selected_branch"
        zle accept-line
    fi
}
zle -N git-checkout-fzf
bindkey '^O' git-checkout-fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

