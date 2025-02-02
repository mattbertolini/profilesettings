#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

NAMESPACE="mrb"
ZSH_CONFIG_DIR="${HOME}/.config/${NAMESPACE}/zsh"
ZSH_CONF_D_DIR="${ZSH_CONFIG_DIR}/conf.d"
ZSH_FUNCTIONS_DIR="${ZSH_CONFIG_DIR}/functions"

# Main profile files
mkdir -p "${ZSH_CONFIG_DIR}"
copyFile "${REPO_ROOT}/zsh/zprofile.zsh" "${ZSH_CONFIG_DIR}/zprofile.zsh"
copyFile "${REPO_ROOT}/zsh/zshrc.zsh" "${ZSH_CONFIG_DIR}/zshrc.zsh"

# functions directory
mkdir -p "${ZSH_FUNCTIONS_DIR}"
copyFile "${REPO_ROOT}/zsh/functions/ql.zsh" "${ZSH_FUNCTIONS_DIR}/ql.zsh"
copyFile "${REPO_ROOT}/zsh/functions/up.zsh" "${ZSH_FUNCTIONS_DIR}/up.zsh"

# conf.d directory
mkdir -p "${ZSH_CONF_D_DIR}"
copyFile "${REPO_ROOT}/zsh/conf.d/zsh-prompt.zsh" "${ZSH_CONF_D_DIR}/zsh-prompt.zsh"
if test "$(which brew)"; then
    copyFile "${REPO_ROOT}/zsh/conf.d/homebrew.zsh" "${ZSH_CONF_D_DIR}/homebrew.zsh"
fi
copyFile "${REPO_ROOT}/zsh/conf.d/lesspipe.zsh" "${ZSH_CONF_D_DIR}/lesspipe.zsh"
copyFile "${REPO_ROOT}/zsh/conf.d/lscolors.zsh" "${ZSH_CONF_D_DIR}/lscolors.zsh"
copyFile "${REPO_ROOT}/zsh/conf.d/marks.zsh" "${ZSH_CONF_D_DIR}/marks.zsh"
# TODO: Only install if SDKMAN is installed
#copyFile "${REPO_ROOT}/zsh/conf.d/sdkman.zsh" "${BASH_CONF_D_DIR}/sdkman.zsh"

createSymlink "${ZSH_CONFIG_DIR}/zprofile.zsh" "${HOME}/.zprofile"
createSymlink "${ZSH_CONFIG_DIR}/zshrc.zsh" "${HOME}/.zshrc"
