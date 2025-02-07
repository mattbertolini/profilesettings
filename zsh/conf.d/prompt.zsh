typeset -r red='%F{red}'
typeset -r reset='%f'
typeset -r bold='%B'
typeset -r bold_stop='%b'

__setPrompt() {
    local exit_code=$?
    local exit_code_prompt=''

    if [ $exit_code != 0 ]; then
        exit_code_prompt="${bold}${red}[${exit_code}]${bold_stop}${reset}"
    fi

    # Set up the prompt. Terminals that support color will have color prompts.
    case "$TERM" in
    xterm-color|xterm-256color|screen-color|screen-256color|xterm-ghostty)
        PROMPT="%{$(tput setaf 10)%}%n%{$(tput setaf 214)%}@%{$(tput setaf 214)%}%m %{$(tput setaf 33)%}%1~ %{$(tput sgr0)%}${exit_code_prompt}%# "
        ;;
    *)
        # Do nothing right now
        #export PS1="%n@%m %1~ %# "
        ;;
    esac
}

__setTitle() {
    print -Pn "\033]0;%n@%m: ${PWD/#$HOME/~}\007"
}

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    (xterm*|rxvt*)
        precmd_functions+=(__setPrompt)
        precmd_functions+=(__setTitle)
        ;;
    (*)
        # Do nothing for other terminal types
        ;;
esac
