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

# Add delta as git diff tool if present
if test "$(which delta)"; then
    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.navigate true
    git config --global merge.conflictStyle zdiff3
fi
