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

## Git AutoRemove

1. Adicione as seguintes linhas no arquivo `~/.gitconfig`

```shell
[alias]
	autoremove = "!sh ~/.custom_terminal_scripts/git-autoremove.sh"
	autoremoveall = "!git remote | xargs -n 1 git autoremove; git autoremove"
```