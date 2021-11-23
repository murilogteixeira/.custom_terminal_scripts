#!/bin/zsh

# Alias
alias cdgt="cd ~/git"
alias gtst="git status"
alias gtpll="git pull"
alias gtftch="git fetch"
alias gtchck="git checkout"
alias updtpod="pod update"
alias instlpod="pod install"

# Cria atalhos para todas as pastas que estão dentro de ~/git/
for f in ~/git/*; do 
    if [ -d "$f" ]; then
        alias $(basename $f)="$f"
    fi
done

# Atualizar terminal
updtzsh() {
    source ~/.zshrc
}

# Pod functions
clnpod() {
    rm Podfile.lock
    rm -rf Pods
}

# Comitar alterações
gtcmt() {
    if [ $# -eq 0 ]
    then
        git commit -m 'Auto commit: Update files'
        return
    fi

    git commit -m $1
}

# Estagiar alterações
gtadd() {
    if [ $# -eq 0 ]
    then
        git add --all
        return
    fi

    git add $1
}

# Subir alterações
gtpsh() {
    if [ $# -eq 0 ]
    then
        git push
        return
    fi

    param=$1

    case $param in
    -u) 
        branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
        git push -u origin $branch
    ;;
    *) echo 'Parâmetro incorreto';;
    esac
}

# Comandos git
gt() {

    __branch() {
        param=$1
        branch=$2
        case $param in
        -dl | --delete-local)
            printf "Tem certeza que deseja deletar a branch local '$branch'? [y/n] "
            read ans 
            case $ans in
            y|Y) git branch -d $branch;;
            esac
        ;;
        # -dr | --delete-remote)
        #     printf "Tem certeza que deseja deletar a branch remota '$branch'? [y/n] "
        #     read ans 
        #     case $ans in
        #     y|Y) git push origin --delete $branch;;
        #     esac
        # ;;
        -r | --auto-remove)
            printf "Tem certeza que deseja deletar todas as branchs excluídas ou mescladas localmente? [y/n] "
            read ans 
            case $ans in
            y|Y|s|S) git autoremove;;
            *) echo 'Cancelado';;
            esac
        ;;
        -ra | --auto-remove-all)
            printf "Tem certeza que deseja deletar todas as branchs excluídas ou mescladas localmente e remotamente? [y/n] "
            read ans 
            case $ans in
            y|Y|s|S) git autoremoveall;;
            *) echo 'Cancelado';;
            esac
        ;;
        -f | --find-branch)
            if [ -n $branch ]; then
                git branch -ra | grep $branch
            else
                echo 'Insira o nome da branch ou parte dela para a busca'
            fi
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

# Git Flow
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

# Criar GIF usando ffmpeg e gifsicle
# brew install ffmpeg
# brew install gifsicle
# Como usar: gifly video.mp4
# Resultado: video.mp4.gif

gifly() {
    # obter largura e altura
    width=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 "$1") 
    height=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=s=x:p=0 "$1")
    # diminuir para 25% do tamanho
    width=$(($width * 0.5))
    height=$(($height * 0.5))
    # remover casas decimais
    width=${width%.*}
    height=${height%.*}
    # criar string no formato correto
    resolution="${width}x${height}"
    # converter video para gif
    ffmpeg -i "$1" -s "$resolution" -pix_fmt rgb24 -r 20 -f gif -  | gifsicle --optimize=3 --delay=5 > "$1.gif"
}