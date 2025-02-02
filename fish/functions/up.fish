function up --description "Change multiple directories"
    if set -q argv[1]; and not string match -qr "[0-9]+" "$argv[1]"
        echo "Error: argument is not a number"
        return 1
    end

    set count 1
    set cd_str ''

    if set -q argv[1]
        set count $argv[1]
    end

    for i in (seq 1 $count)
        set cd_str "$cd_str../"
    end

    cd $cd_str
end