# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
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

function ssh_fzf() {
    local ssh_login_host
    ssh_login_host=$(cat ~/.ssh/config | grep -i ^host | awk '{print $2}' | fzf)
    if [[ ${ssh_login_host} == "" ]]; then
        return 1
    fi
    ssh ${ssh_login_host}
}
zle -N ssh_fzf
bindkey '^H' ssh_fzf

function ghq_fzf() {
    local selected_dir=$(ghq list | fzf)
    if [[ $selected_dir == "" ]]; then
         return 1
    fi
}
zle -N ghq_fzf
bindkey '^G^L' ghq_fzf

function git_status() {
    if [[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" == "true" ]]; then
        echo git status -sb
        git status -sb
    fi
    #zle reset-prompt
}
zle -N git_status
bindkey '^Gs' git_status


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

