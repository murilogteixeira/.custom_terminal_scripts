#!/bin/zsh

echo 'Atualizando scripts'
git -C $HOME/.custom_terminal_scripts pull

updtzsh() {
    source ~/.zshrc
    echo "Scripts updated"
}

alias cdgt="cd ~/git"
alias gtst="git status"
alias gtadd="git add --all"
alias gtcmt="git commit"
alias gtcmtm="git commit -m"
alias gtpll="git pull"
alias gtpsh="git push"
alias gtftch="git fetch"

gtflw() {

    __gtflw_option() {
        case $2 in
        -S) git flow $1 start $3;; 
        -F) git flow $1 finish $3;; 
        *) echo "[git flow $1] Parâmetro inválido ou incompleto";; 
        esac
    }
    
    case $1 in
    -f) __gtflw_option feature $2 $3;;
    -b) __gtflw_option bugfix $2 $3;;
    -r) __gtflw_option release $2 $3;;
    -h) __gtflw_option hotfix $1 $2 $3;;
    *) echo '[git flow] Parâmetro inválido ou incompleto';;
    esac
}

clear
