#!/bin/zsh

echo 'Atualizando scripts'
git -C $HOME/.custom_terminal_scripts pull

updtzsh() {
    source ~/.zshrc
    echo "Updated scripts"
}

alias cdgt="cd ~/git"
alias gtst="git status"
alias gtadd="git add --all"
alias gtcmt="git commit"
alias gtcmtm="gtcmt -m"
alias gtpll="git pull"
alias gtpsh="git push"
alias gtftch="git fetch"
alias gtchck="git checkout"

gt() {
    __branch() {
        param=$1
        branch=$2
        case $param in
        -dl | --delete-local) git branch -d $branch
            printf "Tem certeza que deseja deletar a branch local '$branch'? [y/n] "
            read ans 
            case $ans in
            y|Y) git branch -d $branch;;
            esac
        ;;
        -dr | --delete-remote)
            printf "Tem certeza que deseja deletar a branch remota '$branch'? [y/n] "
            read ans 
            case $ans in
            y|Y) git push origin --delete $branch;;
            esac
        ;;
        *) echo "Parâmetro $param desconhecido";;
        esac
    }

    param=$1
    option=$2
    branch=$3

    case $param in
    -b | --branch) __branch $option $branch;;
    *) echo "Parâmetro $param desconhecido";;
    esac
}

gtflw() {
    __gtflw_option() {
        case $2 in
        -S) git flow $1 start $3;; 
        -F) git flow $1 finish $3;; 
        *) echo "[git flow $1] Parâmetro inválido ou incompleto";; 
        esac
    }
    
    case $1 in
    -f | features) __gtflw_option feature $2 $3;;
    -b | bugfix) __gtflw_option bugfix $2 $3;;
    -r | release) __gtflw_option release $2 $3;;
    -h | hotfix) __gtflw_option hotfix $1 $2 $3;;
    *) echo "[git flow $1] Parâmetro inválido ou incompleto";;
    esac
}

