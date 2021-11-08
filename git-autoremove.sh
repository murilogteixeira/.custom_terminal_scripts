#!/bin/zsh

whitelist="master|main|dev|develop|feature/*"
git fetch --prune
if [ -z "$1" ]; then
    list=$(git branch --merged | egrep -v "(^\*|$whitelist)") &&
    cmd='echo "$list" | xargs -n 1 git branch -d'
else
    list=$(git branch -r --merged | grep "$1" | egrep -v "(>|$whitelist)") &&
    cmd='echo "$list" | cut -d'/' -f2- | xargs -n 1 git push "$1" --delete'
fi
echo "On branch $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'). "; echo ""
if [ -z "$list" ]; then
    echo "No branches to remove."
else
    echo "Branches to remove:"; echo "$list"; echo ""
    read -p 'Press enter to continue'; echo " "
    eval $cmd
fi
