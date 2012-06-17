# Universal profile login shell profile
# Written by Matt Bertolini

# If ~/.bash_profile or ~/.bash_login exists, this file is not read.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f ~/.bashrc ]; then
		. ~/.bashrc
    fi
fi
