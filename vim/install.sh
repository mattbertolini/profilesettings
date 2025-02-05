#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

OVERWRITE="${overwrite:-false}"
NAMESPACE="${namespace:-mrb}"
VIM_CONFIG_DIR="${HOME}/.config/${NAMESPACE}/vim"

echo "Installing Vim config"

# Main config
mkdir -p "${VIM_CONFIG_DIR}"
copyFile "${REPO_ROOT}/vim/vimrc.vim" "${VIM_CONFIG_DIR}/vimrc.vim" "${OVERWRITE}"

createSymlink "${VIM_CONFIG_DIR}/vimrc.vim" "${HOME}/.vimrc"
