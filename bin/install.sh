#!/bin/sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")" && pwd -P)/.."

. "${REPO_ROOT}/scripts/core.sh"

NAMESPACE="mrb"
HOME_BIN_DIR="${HOME}/bin"

echo "Installing local bin"

# Custom scripts
mkdir -p "${HOME_BIN_DIR}"
copyFile "${REPO_ROOT}/bin/findclass" "${HOME_BIN_DIR}/findclass"
