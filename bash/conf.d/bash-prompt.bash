# Set up the prompt. Terminals that support color will have color prompts.
case "$TERM" in
xterm-color|xterm-256color|screen-color|screen-256color|xterm-ghostty)
    # Default prompt. Light blue and light green
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # Alternate light red and yellow prompt. Copy to bash_local if you want to use.
    #PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='\u@\h:\w\$ '
    ;;
esac
