#!/bin/sh

tnew() { tmux new-session -s "$1"; }
tkill() { tmux kill-session -t "$1"; }
tgo() { tmux a -t "$1"; }
alias tls="tmux ls" 

dit() { docker exec -it "$1" /bin/bash; }
dzit() { docker exec -it "$1" /bin/zsh; }

git config --global user.name "Yikai Zhu"
git config --global user.email "zhuyikai.zyk@gmail.com"
git config --global core.editor "vim"

alias k=kubectl
alias kpg="kubectl get pods"
kit() { kubectl exec -it "$1" -- /bin/bash; }
alias node1="k exec -it yikai-node1-dev-pod-h100-0 -- /bin/bash"
alias node2="k exec -it yikai-dev-pod-h100-0 -- /bin/bash"
