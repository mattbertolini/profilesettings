#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

GHOSTTY_CONFIG_DIR="${HOME}/.config/ghostty"

echo "Installing Ghostty config"

# Main config
mkdir -p "${GHOSTTY_CONFIG_DIR}"
copyFile "${REPO_ROOT}/ghostty/config" "${GHOSTTY_CONFIG_DIR}/config"
