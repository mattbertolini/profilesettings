#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

echo "Installing Git config"

# Main
if ! test "$(which git)"; then
    exit
fi

copyFile "${REPO_ROOT}/git/gitconfig" "${HOME}/.gitconfig"

OS=$(uname -o 2>/dev/null || uname -s)
if [ "$OS" = "Darwin" ]; then
    git config --global credential.helper osxkeychain
fi
