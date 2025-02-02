#!/bin/sh

set -eu

# xcode-select --install
# xcode-select -p

usage() {
cat << EOF
Usage: $(basename "$0") [OPTIONS]

OPTIONS:
  -h    Prints this help screen.

All option flags must come before the required arguments.
EOF
}

while getopts "h" OPTION; do
    case $OPTION in
    h)
        usage
        exit 1
        ;;
    ?)
        usage
        exit 1
        ;;
    esac
done

OS=$(uname -o 2>/dev/null || uname -s)
if [ "$OS" = "Darwin" ]; then
    echo "Detected MacOS"

    if [ "$(which brew)" ]; then
        echo "Installing homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew bundle install
    fi
fi

./bash/install.sh
./zsh/install.sh
./fish/install.sh
./ghostty/install.sh
./vim/install.sh
