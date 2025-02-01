# Excellent bookmarks functions from
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
set -Ux MARKPATH $HOME/.marks

function jump --description "Jump to the bookmark directory"
    if test -d "$MARKPATH/$argv[1]"
        cd (realpath "$MARKPATH/$argv[1]")
    else
        echo "No such mark: $argv[1]"
    end
end

function mark --description "Add a bookmark"
    mkdir -p $MARKPATH
    ln -s (pwd) "$MARKPATH/$argv[1]"
end

function unmark --description "Remove a bookmark"
    if test -e "$MARKPATH/$argv[1]"
        rm -i "$MARKPATH/$argv[1]"
    else
        echo "No such mark: $argv[1]"
    end
end

function marks --description "List all bookmarks"
    ls -l $MARKPATH | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
end