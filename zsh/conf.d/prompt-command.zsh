# If this is an xterm set the title to user@host:dir
case "$TERM" in
    (xterm*|rxvt*)
        precmd() {
            print -Pn "\033]0;%n@%m: ${PWD/#$HOME/~}\007"
        }
        ;;
    (*)
        # Do nothing for other terminal types
        ;;
esac
