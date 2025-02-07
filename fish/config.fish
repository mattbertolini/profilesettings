# Fish Shell Profile

set fish_greeting

# Set up environment variables
set -x EDITOR "vim"
set -x LESS "-M -I -R"
# Highlight grep matches
set -x GREP_OPTIONS "--color=auto"

alias finder="open -a finder"

# Set PATH so it includes user's private bin if it exists
if test -d ~/bin
    fish_add_path -m -p ~/bin
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
