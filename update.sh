#!/bin/zsh

DIR="$HOME/.custom_terminal_scripts"

# Buscar alterações no repositório remoto
echo '[custom scripts] Buscando alterações no repositório remoto'
git -C $DIR pull
# Definindo arquivo de scripts
source $DIR/script.sh
echo '[custom scripts] Scripts atualizados '