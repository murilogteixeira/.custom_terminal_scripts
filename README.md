# Script customizado

1. Clone este repositório na sua pasta de usuário (~/)
2. Implemente as seguintes linhas ao final do arquivo ~/.zshrc
3. Atualize o arquivo script.sh com os seus script customizados

```shell
# ---------------------------------------------------------------
# Meus scripts personalizados
source $HOME/.custom_terminal_scripts/update.sh
# ---------------------------------------------------------------
```
# Git autoremove

Para usar o comando `git autoremove`, adicione o seguinte trecho ao arquivo ~/.gitconfig:

```shell
[alias]
    autoremove = "!f() { \
        whitelist=\"master|dev|legacy\"; \
        git fetch --prune; \
        if [ -z \"$1\" ]; then \
            list=$(git branch --merged | egrep -v \"(^\\*|$whitelist)\") && \
            cmd='echo \"$list\" | xargs -n 1 git branch -d'; \
        else \
            list=$(git branch -r --merged | grep \"$1\" | egrep -v \"(>|$whitelist)\") && \
            cmd='echo \"$list\" | cut -d'/' -f2- | xargs -n 1 git push \"$1\" --delete'; \
        fi; \
        echo \"On branch $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \\(.*\\)/\\1/'). \"; echo \"\"; \
        if [ -z \"$list\" ]; then \
            echo \"No branches to remove.\"; \
        else \
            echo \"Branches to remove:\"; echo \"$list\"; echo \"\"; \
            read -p 'Press enter to continue'; echo \" \"; \
            eval $cmd; \
        fi \
    }; f"
    autoremoveall = "!git remote | xargs -n 1 git autoremove; git autoremove"
```

## Description 
Git alias to remove deleted and merged branches. It works locally, with any specific remote or both.

It should be added to your `.gitconfig` aliases. You can inline as displayed above, or create a `git-autoremove.sh` script, add it to your path, and call it like so: `autoremove = "!sh git-autoremove.sh"`.

## Usage

First of all, make sure to edit the `whitelist` to match your own protected branches. Afterwards, go forth and clean up.

To delete local branches that have been deleted or merged:
``` shell
git autoremove
```

To delete branches from a specific remote that have been deleted or merged:
``` shell
git autoremove origin # or any other remote
```

Most often than not, you'll want to delete all deleted / merged branches, regardless if local or belonging to any remote:
``` shell
git autoremoveall
```
