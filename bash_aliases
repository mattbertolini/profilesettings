# Universal Bash Aliases File
# Written by Matt Bertolini

# Get the operating system. Possible values:
#  * GNU/Linux = Linux
#  * Cygwin = Windows Cygwin prompts
#  * Darwin = MacOS
OPSYS=$(uname -o 2>/dev/null || uname -s)

# Aliases for Linux only
if [ $OPSYS == "GNU/Linux" ]; then
    alias ls='ls --color=auto'
fi

#Aliases for Cygwin terminals only
if [ $OPSYS == "Cygwin" ]; then
    alias ls='ls --color=auto'
    alias finder='explorer'
fi

# Aliases for MacOS only
if [ $OPSYS == "Darwin" ]; then
    alias ls='ls -G'
    alias finder='open -a finder'
    alias explorer='finder'
fi

# Aliases that all operating systems can use
