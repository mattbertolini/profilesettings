#!/bin/sh

set -euo

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

./bash/install.sh
./zsh/install.sh
./fish/install.sh
