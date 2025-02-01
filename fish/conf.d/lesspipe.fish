# make less more friendly for non-text input files, see lesspipe(1)
if test -x (brew --prefix)/bin/lesspipe.sh
    set -x LESSOPEN "|(brew --prefix)/bin/lesspipe.sh %s"
end
