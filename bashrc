# Universal profile bashrc file
# Written by Matt Bertolini

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Get the operating system. Possible values:
#  * GNU/Linux = Linux
#  * Cygwin = Windows Cygwin prompts
#  * Darwin = MacOS
OPSYS=$(uname -o 2>/dev/null || uname -s)

# History settings. Don't put duplicate lines and ignore successive entries in history list.
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Set up environment variables
EDITOR=vim
SVN_EDITOR=vim
LESS=-M

# Set up the prompt. Terminals that support color will have color prompts.
case "$TERM" in
xterm-color|xterm-256color|screen-color|screen-256color)
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='\u@\h:\w\$ '
    ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    # Do nothing
    ;;
esac

# Custom functions
function up() { 
	COUNT=1
	if [ -n "$1" ]; then
		COUNT=$1
	fi
	for ((i = 1; i <= $COUNT; i++)); do 
		cd ..
	done
}

# MacOS specific settings
if [ $OPSYS == "Darwin" ]; then
    export LSCOLORS='Exfxcxdxbxegedabagacad'
    
    # Fink init script. Check to see if it exists and source it if it does.
    [ -r /sw/bin/init.sh ] && . /sw/bin/init.sh
fi

if [ $OPSYS == "Cygwin" ]; then
    # In Windows, these variables are already defined so I we should unset them in Cygwin.
    unset TMP
    unset TEMP
fi

# Source the aliases file if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
