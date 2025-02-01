function up() {
    if [[ -n "$1" && $1 != *[0-9]* ]]; then
        echo "Error: Argument not a number"
        return
    fi

    COUNT=1
    CD_STR=''
    if [ -n "$1" ]; then
        COUNT=$1
    fi

    for ((i = 1; i <= COUNT; i++)); do
        # Making a string so we change the directory all in one shot.
        CD_STR="${CD_STR}../"
    done

    cd "$CD_STR" || exit
}
