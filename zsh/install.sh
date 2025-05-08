#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

OVERWRITE="${overwrite:-false}"
NAMESPACE="${namespace:-mrb}"
ZSH_CONFIG_DIR="${HOME}/.config/${NAMESPACE}/zsh"
ZSH_CONF_D_DIR="${ZSH_CONFIG_DIR}/conf.d"
ZSH_FUNCTIONS_DIR="${ZSH_CONFIG_DIR}/functions"

ZSH_LOCAL_SHARE_DIR="${HOME}/.local/share/${NAMESPACE}/zsh"

echo "Installing Zsh shell config"

# Main profile files
mkdir -p "${ZSH_CONFIG_DIR}"
copyFile "${REPO_ROOT}/zsh/zshrc.zsh" "${ZSH_CONFIG_DIR}/zshrc.zsh" "${OVERWRITE}"

# functions directory
mkdir -p "${ZSH_FUNCTIONS_DIR}"
copyFile "${REPO_ROOT}/zsh/functions/__shrink_path.zsh" "${ZSH_FUNCTIONS_DIR}/__shrink_path.zsh" "${OVERWRITE}"
copyFile "${REPO_ROOT}/zsh/functions/ll.zsh" "${ZSH_FUNCTIONS_DIR}/ll.zsh" "${OVERWRITE}"
copyFile "${REPO_ROOT}/zsh/functions/ql.zsh" "${ZSH_FUNCTIONS_DIR}/ql.zsh" "${OVERWRITE}"
copyFile "${REPO_ROOT}/zsh/functions/up.zsh" "${ZSH_FUNCTIONS_DIR}/up.zsh" "${OVERWRITE}"

# conf.d directory
mkdir -p "${ZSH_CONF_D_DIR}"
if test "$(which brew)"; then
    echo "Found Homebrew. Installing config"
    copyFile "${REPO_ROOT}/zsh/conf.d/homebrew.zsh" "${ZSH_CONF_D_DIR}/homebrew.zsh" "${OVERWRITE}"
fi
copyFile "${REPO_ROOT}/zsh/conf.d/lesspipe.zsh" "${ZSH_CONF_D_DIR}/lesspipe.zsh" "${OVERWRITE}"
copyFile "${REPO_ROOT}/zsh/conf.d/lscolors.zsh" "${ZSH_CONF_D_DIR}/lscolors.zsh" "${OVERWRITE}"
copyFile "${REPO_ROOT}/zsh/conf.d/marks.zsh" "${ZSH_CONF_D_DIR}/marks.zsh" "${OVERWRITE}"
copyFile "${REPO_ROOT}/zsh/conf.d/prompt.zsh" "${ZSH_CONF_D_DIR}/prompt.zsh" "${OVERWRITE}"
copyFile "${REPO_ROOT}/zsh/conf.d/zsh-autosuggestions.zsh" "${ZSH_CONF_D_DIR}/zsh-autosuggestions.zsh" "${OVERWRITE}"
# TODO: Only install if SDKMAN is installed
#copyFile "${REPO_ROOT}/zsh/conf.d/sdkman.zsh" "${ZSH_CONF_D_DIR}/sdkman.zsh" "${OVERWRITE}"

# .local/share (zsh_history, etc)
mkdir -p "${ZSH_LOCAL_SHARE_DIR}"

createSymlink "${ZSH_CONFIG_DIR}/zshrc.zsh" "${HOME}/.zshrc"
createSymlink "${ZSH_LOCAL_SHARE_DIR}/zsh_history" "${HOME}/.zsh_history"

