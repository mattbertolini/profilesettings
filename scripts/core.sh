#!/bin/sh

set -eu

copyFile() {
    _copyFile_source="$1"
    _copyFile_target="$2"
    if [ ! -f "${_copyFile_target}" ]; then
        cp "${_copyFile_source}" "${_copyFile_target}"
    fi
}

createSymlink() {
    _createSymlink_source="$1"
    _createSymlink_target="$2"
    ln -sfn "${_createSymlink_source}" "${_createSymlink_target}"
}
