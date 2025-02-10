readonly red='\[\e[31m\]'
readonly reset='\[\e[0m\]'
readonly bold='\[\e[1m\]'

__setPs1() {
    local exit_code=$?
    local exit_code_prompt=''

    if [ $exit_code != 0 ]; then
        exit_code_prompt=" ${bold}${red}[$exit_code]${reset}"
    fi

    # Add git branch if present
    local git_prompt=''
    if [ "$(which git)" ]; then
        git_prompt="$(__git_ps1)"
    fi

    # Use a shrunken path format (e.g. ~/o/p/test for ~/opt/projects/test)
    local cur_dir="${PWD/#$HOME/\~}"
    local shrunk_cur_dir="$(__shrink_path "${cur_dir}")"

    case "$TERM" in
    xterm-color|xterm-256color|screen-color|screen-256color|xterm-ghostty)
        # Default prompt. Light blue and light green
        #PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$exit_code_prompt\$ "
        PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$shrunk_cur_dir\[\033[00m\]$git_prompt$exit_code_prompt\$ "
        # Alternate light red and yellow prompt. Uncomment if you want to use.
        #PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
        ;;
    *)
        PS1="\u@\h:$shrunk_cur_dir\$ "
#        PS1='\u@\h:\w\$ '
        ;;
    esac
}

__setTitle() {
    local cur_dir="${PWD/#$HOME/\~}"
    local shrunk_cur_dir="$(__shrink_path "${cur_dir}")"

    local host="$(hostname -s)"

    echo -ne "\033]0;${USER}@${host}: ${shrunk_cur_dir}\007"
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
