#!/usr/bin/env sh

# Universal profile initialization script
# Written by Matt Bertolini

# Check to see if the tools required for this script to run exist
type -P curl &>/dev/null
HAS_CURL=$?
type -P wget &>/dev/null
HAS_WGET=$?

if [[ $HAS_CURL -ne 0 && $HAS_WGET -ne 0 ]]; then
	echo "Cannot proceed. No curl or wget executable found."
	exit 1
fi

type -P uname &>/dev/null
if [ $? -ne 0 ]; then
	echo "Cannot proceed. No uname executable found."
	exit 1
fi

function downloadWithCurl() {
	curl --insecure $1 -o $2
}

function downloadWithWget() {
	wget --no-check-certificate $1 -O $2
}

function download() {
	if [ $HAS_CURL -eq 0 ]; then
		downloadWithCurl $1 $2
	elif [ $HAS_WGET -eq 0 ]; then
		downloadWithWget $1 $2
	else
		echo "Cannot proceed. No curl or wget executable found."
		exit 1
	fi
}

# Make sure we are in the user's home directory
cd ~

# Backup the existing profile files
echo "Backing up existing profile files..."
[ -f ~/.profile ] && mv ~/.profile ~/.profile.bak
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
[ -f ~/.bash_aliases ] && mv ~/.bash_aliases ~/.bash_aliases.bak
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
[ -f ~/.minttyrc ] && mv ~/.minttyrc ~/.minttyrc.bak

# Get the operating system. Possible values:
#  * GNU/Linux = Linux
#  * Cygwin = Windows Cygwin prompts
#  * Darwin = MacOS
OPSYS=$(uname -o 2>/dev/null || uname -s)

# Download files common to all platforms. Please note that I am not checking 
# the SSL certificate because of the way Github and wget handle wildcard certificates.
echo "Downloading universal profile files..."
download https://github.com/MaliciousMonkey/profilesettings/raw/master/profile .profile
download https://github.com/MaliciousMonkey/profilesettings/raw/master/bashrc .bashrc
download https://github.com/MaliciousMonkey/profilesettings/raw/master/bash_aliases .bash_aliases
download https://github.com/MaliciousMonkey/profilesettings/raw/master/vimrc .vimrc

#Download platform specific files

if [ $OPSYS == "Cygwin" ]; then
	echo "Downloading Cygwin specific profile files..."
	download https://github.com/MaliciousMonkey/profilesettings/raw/master/minttyrc .minttyrc
fi

# Finally, source the profile files
echo "Sourcing profile..."
source ~/.profile
echo "Universal profile loaded successfully."
exit 0
