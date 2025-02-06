readonly red='\[\e[31m\]'
readonly reset='\[\e[0m\]'
readonly bold='\[\e[1m\]'

__setPs1() {
    local exit_code=$?
    local exit_code_prompt=''

    if [ $exit_code != 0 ]; then
        exit_code_prompt=" ${bold}${red}[$exit_code]${reset}"
    fi

    case "$TERM" in
    xterm-color|xterm-256color|screen-color|screen-256color|xterm-ghostty)
        # Default prompt. Light blue and light green
        PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$exit_code_prompt\$ "
        # Alternate light red and yellow prompt. Uncomment if you want to use.
        #PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
        ;;
    *)
        PS1='\u@\h:\w\$ '
        ;;
    esac
}

__setTitle() {
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
}

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='__setPs1; __setTitle'
    ;;
*)
    # Do nothing
    ;;
esac
