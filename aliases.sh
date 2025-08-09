#!/bin/sh

tnew() { tmux new-session -s "$1"; }
tkill() { tmux kill-session -t "$1"; }
tgo() { tmux a -t "$1"; }
alias tls="tmux ls" 

dexec() { docker exec -it "$1" /bin/bash; }

alias k=kubectl
alias kpg="kubectl get pods"
kexec() { kubectl exec -it "$1" -- /bin/bash; }
alias node1="k exec -it yikai-node1-dev-pod-h100-0 -- /bin/bash"
alias node2="k exec -it yikai-dev-pod-h100-0 -- /bin/bash"