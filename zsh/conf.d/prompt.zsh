typeset -r blue='%F{blue}'
typeset -r green='%F{10}'
typeset -r red='%F{red}'
typeset -r reset='%f'
typeset -r bold='%B'
typeset -r bold_stop='%b'

# Load vcs_info for git branch info
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats "(%b)"
precmd() {
    vcs_info
}

__setPrompt() {
    local exit_codes=("${pipestatus[@]}")
    local exit_code="$(IFS='|'; echo "${exit_codes[*]}")"
    local exit_code_prompt=''

    if [ "${exit_codes[-1]}" -ne 0 ]; then
        exit_code_prompt="${bold}${red}[${exit_code}]${bold_stop}${reset}"
    fi

    # Populate the git branch info
    local git_prompt="${vcs_info_msg_0_}"


    # Set up the prompt. Terminals that support color will have color prompts.
    case "$TERM" in
    xterm-color|xterm-256color|screen-color|screen-256color|xterm-ghostty)
        PROMPT="${green}%n@%m %F{blue}%1~ %{%f%}${git_prompt}${exit_code_prompt}%# "
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
