#!/bin/sh

set -euo

REPO_ROOT="../"

. "${REPO_ROOT}/scripts/core.sh"

NAMESPACE="mrb"
BASH_CONFIG_DIR="${HOME}/.config/${NAMESPACE}/bash"
BASH_CONF_D_DIR="${BASH_CONFIG_DIR}/conf.d"
BASH_FUNCTIONS_DIR="${BASH_CONFIG_DIR}/functions"

# Main profile files
mkdir -p "${BASH_CONFIG_DIR}"
copyFile "${REPO_ROOT}/bash/bash_profile" "${BASH_CONFIG_DIR}/bash_profile"
copyFile "bash/bashrc" "${BASH_CONFIG_DIR}/bashrc"

# functions directory
mkdir -p "${BASH_FUNCTIONS_DIR}"
copyFile "${REPO_ROOT}/bash/functions/ql.bash" "${BASH_FUNCTIONS_DIR}/ql.bash"
copyFile "${REPO_ROOT}/bash/functions/up.bash" "${BASH_FUNCTIONS_DIR}/up.bash"

# conf.d directory
mkdir -p "${BASH_CONF_D_DIR}"
copyFile "${REPO_ROOT}/bash/conf.d/bash-completion.bash" "${BASH_CONF_D_DIR}/bash-completion.bash"
copyFile "${REPO_ROOT}/bash/conf.d/bash-prompt.bash" "${BASH_CONF_D_DIR}/bash-prompt.bash"
if test "$(which brew)"; then
    copyFile "bash/conf.d/homebrew.bash" "${BASH_CONF_D_DIR}/homebrew.bash"
fi
copyFile "${REPO_ROOT}/bash/conf.d/lesspipe.bash" "${BASH_CONF_D_DIR}/lesspipe.bash"
copyFile "${REPO_ROOT}/bash/conf.d/lscolors.bash" "${BASH_CONF_D_DIR}/lscolors.bash"
copyFile "${REPO_ROOT}/bash/conf.d/marks.bash" "${BASH_CONF_D_DIR}/marks.bash"
copyFile "${REPO_ROOT}/bash/conf.d/prompt-command.bash" "${BASH_CONF_D_DIR}/prompt-command.bash"
# TODO: Only install if SDKMAN is installed
#copyFile "${REPO_ROOT}/bash/conf.d/sdkman.bash" "${BASH_CONF_D_DIR}/sdkman.bash"

createSymlink "${HOME}/.config/mrb/bash/bash_profile.bash" "${HOME}/.bash_profile"
createSymlink "${HOME}/.config/mrb/bash/bashrc.bash" "${HOME}/.bashrc"
