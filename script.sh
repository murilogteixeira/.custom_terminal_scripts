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

gtflw_option() {
    case $2 in
    -S) git flow $1 start $3;; 
    -F) git flow $1 finish $3;; 
    *) echo "[git flow $1] Parâmetro inválido ou incompleto";; 
    esac
}

gtflw() {
    case $1 in
    -f) gtflw_option feature $2 $3;;
    -b) gtflw_option bugfix $2 $3;;
    -r) gtflw_option release $2 $3;;
    -h) gtflw_option hotfix $1 $2 $3;;
    *) echo '[git flow] Parâmetro inválido ou incompleto';;
    esac
}

clear
