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
LESS='-M -i'; export LESS
# Highlight grep matches
GREP_OPTIONS='--color=auto'; export GREP_OPTIONS

# Custom functions
function up() { 
	if [[ -n "$1" && $1 != *[0-9]* ]]; then
        echo "Error: Argument not a number."
        return
    fi
	COUNT=1
	CD_STR=''
	if [ -n "$1" ]; then
		COUNT=$1
	fi
	for ((i = 1; i <= $COUNT; i++)); do
		# Making a string so we change the directory all in one shot.
		CD_STR=$CD_STR"../"
	done
	cd $CD_STR
}

# MacOS specific settings
if [ $OPSYS == "Darwin" ]; then
    # Build custom LS Colors
    DIR=Ex
    SYM_LINK=Gx
    SOCKET=Fx
    PIPE=dx
    EXE=Cx
    BLOCK_SP=Dx
    CHAR_SP=Dx
    EXE_SUID=hb
    EXE_GUID=ad
    DIR_STICKY=Ex
    DIR_WO_STICKY=Ex
    export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"

    # Function for using quicklook via the command line
    function ql {
        qlmanage -p "$@" >& /dev/null; echo
    }

    # If homebrew is installed and the bash completion package is present, source it.
    if [ -r /usr/local/bin/brew ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
    
    # Fink init script. Check to see if it exists and source it if it does.
    [ -r /sw/bin/init.sh ] && . /sw/bin/init.sh
fi

if [ $OPSYS == "Cygwin" ]; then
    # In Windows, these variables are already defined so I we should unset them in Cygwin.
    unset TMP
    unset TEMP
fi

# Set up the prompt. Terminals that support color will have color prompts.
case "$TERM" in
xterm-color|xterm-256color|screen-color|screen-256color)
    # Default prompt. Light blue and light green
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # Alternate light red and yellow prompt. Copy to bash_local if you want to use.
    #PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
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
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

# Source the aliases file if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Source the local file if it exists
if [ -f ~/.bash_local ]; then
	. ~/.bash_local
fi
