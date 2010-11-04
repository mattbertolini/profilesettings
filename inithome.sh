#!/usr/bin/sh

# Universal profile initialization script
# Written by Matt Bertolini

# Check to see if the tools required for this script to run exist
if [ ! which wget ]; then
	echo "Cannot proceed. No wget executable found."
	exit 1
fi

if [ ! which uname ]; then
	echo "Cannot proceed. No uname executable found."
	exit 1
fi

# Make sure we are in the user's home directory
cd ~

# Backup the existing profile files
echo "Backing up existing profile files..."
[ -f ~/.profile ] && mv ~/.profile ~/.profile.bak
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
[ -f ~/.bash_aliases ] && mv ~/.bash_aliases ~/.bash_aliases.bak
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak

# Get the operating system. Possible values:
#  * GNU/Linux = Linux
#  * Cygwin = Windows Cygwin prompts
#  * Darwin = MacOPSYS
OPSYS=$(uname -o 2>/dev/null || uname -s)

#Download files common to all platforms
echo "Downloading universal profile files..."
wget http://www.mattbertolini.com/profile/.profile
wget http://www.mattbertolini.com/profile/.bashrc
wget http://www.mattbertolini.com/profile/.bash_aliases
wget http://www.mattbertolini.com/profile/.vimrc

#Download platform specific files

if [ $OPSYS == "Cygwin" ]; then
	echo "Downloading Cygwin specific profile files..."
	wget http://www.mattbertolini.com/profile/.minttyrc
fi

# Finally, source the profile files
echo "Sourcing profile..."
source ~/.profile
echo "Universal profile loaded successfully."
exit 0
