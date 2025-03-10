#!/bin/sh

set -eu

if test ! "$(which bats)"; then
    echo "Error: Unable to run tests. No bats command found"
    exit 1
fi

bats -r . 
