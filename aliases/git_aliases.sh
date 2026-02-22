## git specific
git config --global user.name "Yikai Zhu"
git config --global user.email "zhuyikai.zyk@gmail.com"
git config --global core.editor "vim"

alias ga="git add"
alias gs="git status"
alias gdc="git diff --cached"
alias gl="git log"
alias gl1="git log --oneline"
alias ggph="git log --oneline --all --graph"
alias glp="git log -p"

# git commit with message
alias gm="git commit -m"
alias gco="git checkout"
alias gb="git branch"
alias gg="git grep"
alias gdo="git diff origin"
alias gpo="git push origin"
alias gmrg="git mrg"
# git branch current, mainly useful for scripts
alias gbrc='git rev-parse --abbrev-ref HEAD'
alias gbrp='git reflog | sed -n "s/.*checkout: moving from .* to \(.*\)/\1/p" | sed "2q;d"'
# can supply a message, very useful
alias gss='git stash save'
alias gsa='git stash apply'
alias gcs="git add --all .;git commit -m \"checkpoint\""
alias gap='git add -p'
# go to git root, then home directory, then filesystem root
alias gup='[ $(git rev-parse --show-toplevel 2>/dev/null || echo ~) = $(pwd) ] && cd $([ $(echo ~) = $(pwd) ] && echo / || echo) || cd $(git rev-parse --show-toplevel 2>/dev/null)'
alias gdm="git diff master"
alias gam="git add .;git commit -m"
alias gg="git grep"