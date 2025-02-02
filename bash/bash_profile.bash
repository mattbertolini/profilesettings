# Bash Shell Profile

# Set up environment variables
EDITOR=vim; export EDITOR
LESS="-M -I -R"; export LESS
# Highlight grep matches
GREP_OPTIONS='--color=auto'; export GREP_OPTIONS

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# History settings. Don't put duplicate lines and commands that begin with a space (e.g. ignoredupes and ignorespace).
export HISTCONTROL=ignoreboth

# Set PATH so it includes user's private bin if it exists
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

BASH_PROFILE_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# Source files in conf.d directory
for file in "${BASH_PROFILE_DIR}/conf.d/"*.bash; do
    [[ -f "${file}" ]] || continue
    # shellcheck source=conf.d/bash-prompt.bash
    source "${file}"
done

# Source files in functions directory
for file in "${BASH_PROFILE_DIR}/functions/"*.bash; do
    [[ -f "${file}" ]] || continue
    # shellcheck source=functions/up.bash
    source "${file}"
done
