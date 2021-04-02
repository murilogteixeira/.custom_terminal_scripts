#!/bin/zsh

DEFAULT_MSG='[custom-script]'

update_zsh() {
    source ~/.zshrc
    echo "$DEFAULT_MSG scripts updated"
}

alias cdgt="cd ~/git"
alias gtst="git status"
alias gtadd="git add --all"
alias gtcmt="git commit"
alias gtpll="git pull"
alias gtpsh="git push"
alias gtftch="git fetch"

gtcmtmsg() {
    git commit -m $1
}

__feature() {
    
}

gtflw() {
    case $1 in
    -f) __feature;;
    *) ;;
}

clear