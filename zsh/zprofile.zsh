# Zsh Shell Profile

# Set up environment variables
EDITOR=vim; export EDITOR
LESS="-M -I -R"; export LESS
# Highlight grep matches
GREP_OPTIONS='--color=auto'; export GREP_OPTIONS

# History settings. Don't put duplicate lines and commands that begin with a space
setopt HIST_IGNORE_SPACE  # Ignore commands that start with a space
setopt HIST_IGNORE_DUPS   # Ignore duplicate commands in history

# Set PATH so it includes user's private bin if it exists
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

# shellcheck disable=SC2296
ZSH_PROFILE_DIR="$(cd "$(dirname "$(realpath "${(%):-%x}")")" && pwd)"

# Source files in conf.d directory
for file in "${ZSH_PROFILE_DIR}/conf.d/"*.zsh; do
    [[ -f "${file}" ]] || continue
    # shellcheck source=conf.d/bash-prompt.zsh
    source "${file}"
done

# Source files in functions directory
for file in "${ZSH_PROFILE_DIR}/functions/"*.zsh; do
    [[ -f "${file}" ]] || continue
    # shellcheck source=functions/up.zsh
    source "${file}"
done
