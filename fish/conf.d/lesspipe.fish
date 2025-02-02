# Make less more friendly for non-text input files, see lesspipe(1)
if test -x "$HOMEBREW_PREFIX/bin/lesspipe.sh"
    set -x LESSOPEN "|$HOMEBREW_PREFIX/bin/lesspipe.sh %s"
end
