# Fish Shell Profile

set fish_greeting

# Set up environment variables
set -x EDITOR "vim"
set -x LESS "-M -I -R"
# Highlight grep matches
set -x GREP_OPTIONS="--color=auto"

alias finder="open -a finder"

if status is-interactive
    # Commands to run in interactive sessions can go here
end