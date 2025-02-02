# Set up the prompt. Terminals that support color will have color prompts.
case "$TERM" in
xterm-color|xterm-256color|screen-color|screen-256color|xterm-ghostty)
    export PS1="%{$(tput setaf 10)%}%n%{$(tput setaf 214)%}@%{$(tput setaf 214)%}%m %{$(tput setaf 33)%}%1~ %{$(tput sgr0)%}%# "
    ;;
*)
    # Do nothing right now
    #export PS1="%n@%m %1~ %# "
    ;;
esac
