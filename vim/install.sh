#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

OVERWRITE="${overwrite:-false}"
NAMESPACE="${namespace:-mrb}"
VIM_CONFIG_DIR="${HOME}/.config/${NAMESPACE}/vim"
VIM_CONF_D_DIR="${VIM_CONFIG_DIR}/conf.d"

echo "Installing Vim config"

# Main config
mkdir -p "${VIM_CONFIG_DIR}"
copyFile "${REPO_ROOT}/vim/vimrc.vim" "${VIM_CONFIG_DIR}/vimrc.vim" "${OVERWRITE}"

# conf.d directory
mkdir -p "${VIM_CONF_D_DIR}"
copyFile "${REPO_ROOT}/vim/conf.d/editorconfig.vim" "${VIM_CONF_D_DIR}/editorconfig.vim" "${OVERWRITE}"

createSymlink "${VIM_CONFIG_DIR}/vimrc.vim" "${HOME}/.vimrc"
