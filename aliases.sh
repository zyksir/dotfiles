#!/bin/sh

tnew() { tmux new-session -s "$1"; }
tkill() { tmux kill-session -t "$1"; }
tgo() { tmux a -t "$1"; }
alias tls="tmux ls" 