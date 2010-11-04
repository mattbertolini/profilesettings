# Universal Bash Aliases File
# Written by Matt Bertolini

# Get the operating system. Possible values:
#  * GNU/Linux = Linux
#  * Cygwin = Windows Cygwin prompts
#  * Darwin = MacOPSYS
OPSYS=$(uname -o 2>/dev/null || uname -s)

# Aliases for Linux only
if [ $OPSYS == "GNU/Linux" ]; then
    alias ls='ls --color=auto'
fi

#Aliases for Cygwin terminals only
if [ $OPSYS == "Cygwin" ]; then
    alias ls='ls --color=auto'
fi

# Aliases for MacOPSYS only
if [ $OPSYS == "Darwin" ]; then
    alias ls='ls -G'
fi

# Aliases that all operating systems can use
