#!/bin/sh

set -eu

# xcode-select --install
# xcode-select -p

usage() {
cat << EOF
Usage: $(basename "$0") [OPTIONS]

OPTIONS:
  -h    Prints this help screen.
  -n    Set the config namespace in .config dir
  -o    Overwrite the existing config files

All option flags must come before the required arguments.
EOF
}

# Defaults
namespace="mrb"
overwrite="false"

while getopts "hn:o" OPTION; do
    case $OPTION in
    h)
        usage
        exit 1
        ;;
    n)
        # Namespace
        namespace="$OPTARG"
        ;;
    o)
        # Overwrite
        overwrite="true"
        ;;
    ?)
        usage
        exit 1
        ;;
    esac
done

export namespace
export overwrite

OS=$(uname -o 2>/dev/null || uname -s)
if [ "$OS" = "Darwin" ]; then
    echo "Detected MacOS"

#    if [ ! "$(which brew)" ]; then
#        echo "Installing homebrew"
#        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#        brew bundle install
#    fi
fi

./bin/install.sh
./bash/install.sh
./zsh/install.sh
./fish/install.sh
./ghostty/install.sh
./vim/install.sh
./git/install.sh
