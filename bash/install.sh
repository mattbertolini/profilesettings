#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

OVERWRITE="${overwrite:-false}"
NAMESPACE="${namespace:-mrb}"
BASH_CONFIG_DIR="${HOME}/.config/${NAMESPACE}/bash"
BASH_CONF_D_DIR="${BASH_CONFIG_DIR}/conf.d"
BASH_FUNCTIONS_DIR="${BASH_CONFIG_DIR}/functions"

echo "Installing Bash shell config"

# Main profile files
mkdir -p "${BASH_CONFIG_DIR}"
copyFile "${REPO_ROOT}/bash/bash_profile.bash" "${BASH_CONFIG_DIR}/bash_profile.bash" "${OVERWRITE}"
copyFile "${REPO_ROOT}/bash/bashrc.bash" "${BASH_CONFIG_DIR}/bashrc.bash" "${OVERWRITE}"

# functions directory
mkdir -p "${BASH_FUNCTIONS_DIR}"
copyFile "${REPO_ROOT}/bash/functions/ll.bash" "${BASH_FUNCTIONS_DIR}/ll.bash" "${OVERWRITE}"
copyFile "${REPO_ROOT}/bash/functions/ql.bash" "${BASH_FUNCTIONS_DIR}/ql.bash" "${OVERWRITE}"
copyFile "${REPO_ROOT}/bash/functions/up.bash" "${BASH_FUNCTIONS_DIR}/up.bash" "${OVERWRITE}"

# conf.d directory
mkdir -p "${BASH_CONF_D_DIR}"
copyFile "${REPO_ROOT}/bash/conf.d/bash-completion.bash" "${BASH_CONF_D_DIR}/bash-completion.bash" "${OVERWRITE}"
if test "$(which brew)"; then
    echo "Found Homebrew. Installing config"
    copyFile "${REPO_ROOT}/bash/conf.d/homebrew.bash" "${BASH_CONF_D_DIR}/homebrew.bash" "${OVERWRITE}"
fi
copyFile "${REPO_ROOT}/bash/conf.d/lesspipe.bash" "${BASH_CONF_D_DIR}/lesspipe.bash" "${OVERWRITE}"
copyFile "${REPO_ROOT}/bash/conf.d/lscolors.bash" "${BASH_CONF_D_DIR}/lscolors.bash" "${OVERWRITE}"
copyFile "${REPO_ROOT}/bash/conf.d/marks.bash" "${BASH_CONF_D_DIR}/marks.bash" "${OVERWRITE}"
copyFile "${REPO_ROOT}/bash/conf.d/prompt.bash" "${BASH_CONF_D_DIR}/prompt.bash" "${OVERWRITE}"
# TODO: Only install if SDKMAN is installed
#copyFile "${REPO_ROOT}/bash/conf.d/sdkman.bash" "${BASH_CONF_D_DIR}/sdkman.bash" "${OVERWRITE}"

createSymlink "${BASH_CONFIG_DIR}/bash_profile.bash" "${HOME}/.bash_profile"
createSymlink "${BASH_CONFIG_DIR}/bashrc.bash" "${HOME}/.bashrc"
