# Excellent bookmarks functions from
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2> /dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s $(pwd) "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

__bookmark_completions() {
    local current
    local bookmarks

    current="${COMP_WORDS[COMP_CWORD]}"
    bookmarks=$(find "$MARKPATH" -type l -exec basename {} \;)

    COMPREPLY=($(compgen -W "$bookmarks" -- "$current"))
}

# Add completion to the jump and unmark commands
complete -F __bookmark_completions jump
complete -F __bookmark_completions unmark
