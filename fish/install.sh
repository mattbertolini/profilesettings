#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

OVERWRITE="${overwrite:-false}"
FISH_CONFIG_DIR="${HOME}/.config/fish"
FISH_CONF_D_DIR="${FISH_CONFIG_DIR}/conf.d"
FISH_FUNCTIONS_DIR="${FISH_CONFIG_DIR}/functions"

echo "Installing Fish shell config"

# Main profile files
mkdir -p "${FISH_CONFIG_DIR}"
copyFile "${REPO_ROOT}/fish/config.fish" "${FISH_CONFIG_DIR}/config.fish" "${OVERWRITE}"

# functions directory
mkdir -p "${FISH_FUNCTIONS_DIR}"
copyFile "${REPO_ROOT}/fish/functions/ql.fish" "${FISH_FUNCTIONS_DIR}/ql.fish" "${OVERWRITE}"
copyFile "${REPO_ROOT}/fish/functions/up.fish" "${FISH_FUNCTIONS_DIR}/up.fish" "${OVERWRITE}"

# conf.d directory
mkdir -p "${FISH_CONF_D_DIR}"
copyFile "${REPO_ROOT}/fish/conf.d/colors.fish" "${FISH_CONF_D_DIR}/colors.fish" "${OVERWRITE}"
if test "$(which brew)"; then
    echo "Found Homebrew. Installing config"
    copyFile "${REPO_ROOT}/fish/conf.d/homebrew.fish" "${FISH_CONF_D_DIR}/homebrew.fish" "${OVERWRITE}"
fi
copyFile "${REPO_ROOT}/fish/conf.d/lesspipe.fish" "${FISH_CONF_D_DIR}/lesspipe.fish" "${OVERWRITE}"
copyFile "${REPO_ROOT}/fish/conf.d/lscolors.fish" "${FISH_CONF_D_DIR}/lscolors.fish" "${OVERWRITE}"
copyFile "${REPO_ROOT}/fish/conf.d/marks.fish" "${FISH_CONF_D_DIR}/marks.fish" "${OVERWRITE}"
