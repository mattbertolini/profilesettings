# make less more friendly for non-text input files, see lesspipe(1)
if [ -x "$(brew --prefix)/bin/lesspipe.sh" ]; then
    export LESSOPEN="|$(brew --prefix)/bin/lesspipe.sh %s"
fi
