#!/bin/sh

export MY_DOTFILES_DIR="$HOME/.my_dotfiles"
# This should match the one in bootstrap
DOTDIR=$HOME/.me
alias v="vim"

# todo: move to a dotedit function that auto-completes
alias sbash="source ~/.bashrc"
alias sgitrc="source $DOTDIR/aliases/git_aliases.sh"
alias skubectlrc="source $DOTDIR/aliases/kubectl_aliases.sh"

alias ls="ls -Gp --color"
alias ll="ls -l"
alias cls="clear && ls"
alias grep='grep --color=auto'
alias timestamp="date +%s"

# json pretty print
alias pretty_print_json="python -mjson.tool"
alias diff='colordiff'
alias less="less -r"

tnew() { tmux new-session -s "$1"; }
tkill() { tmux kill-session -t "$1"; }
tgo() { tmux a -t "$1"; }
alias tls="tmux ls" 

alias dps='docker ps'
alias dils='docker image ls'
dit() { docker exec -it "$1" /bin/bash; }
dzit() { docker exec -it "$1" zsh; }

source $MY_DOTFILES_DIR/aliases/git_aliases.sh
source $MY_DOTFILES_DIR/aliases/kubectl_aliases.sh