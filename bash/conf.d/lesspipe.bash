# Make less more friendly for non-text input files, see lesspipe(1)
if [ -x "$HOMEBREW_PREFIX/bin/lesspipe.sh" ]; then
    export LESSOPEN="|$HOMEBREW_PREFIX/bin/lesspipe.sh %s"
fi
