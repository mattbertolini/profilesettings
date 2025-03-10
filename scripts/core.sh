#!/bin/sh

set -eu

copyFile() {
    _copyFile_source="$1"
    _copyFile_target="$2"
    _copyFile_overwrite="${3:-false}"
    if [ ! -f "${_copyFile_target}" ] || [ "${_copyFile_overwrite}" = "true" ]; then
        cp "${_copyFile_source}" "${_copyFile_target}"
    fi
}

createSymlink() {
    _createSymlink_source="$1"
    _createSymlink_target="$2"
    ln -sfn "${_createSymlink_source}" "${_createSymlink_target}"
}

moveFileIfExists() {
	_moveFileIfExists_source="$1"
	_moveFileIfExists_target="$2"

	if [ -f "${_moveFileIfExists_source}" -a ! -L "${_moveFileIfExists_source}" ]; then
		mv "${_moveFileIfExists_source}" "${_moveFileIfExists_target}"
	fi
}

