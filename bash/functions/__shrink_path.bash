__shrink_path() {
    local original_path="$1"

    # If the path is "~" or "/", return it as-is
    if [[ "$original_path" == "~" || "$original_path" == "/" ]]; then
        echo "$original_path"
        return
    fi

    # Split the path into its components
    local IFS='/'
    local parts=($original_path)

    local shortened_path=""
    local is_home_path=false

    # Handle cases for "~" at the start
    if [[ "${parts[0]}" == "~" ]]; then
        shortened_path="~/"
        parts=("${parts[@]:1}") # Skip the "~"
        is_home_path=true
    fi

    # Process each part
    for i in "${!parts[@]}"; do
        if [[ "${parts[$i]}" == "" ]]; then
            # Handle leading "/" for absolute paths
            if [[ $i -eq 0 && $is_home_path == false ]]; then
                shortened_path+="/"
            fi
        elif [[ $i -eq $((${#parts[@]} - 1)) ]]; then
            # Current (last) directory stays full
            shortened_path+="${parts[$i]}"
        else
            # Take the first letter of intermediate directories
            shortened_path+="${parts[$i]:0:1}/"
        fi
    done

    # Remove a trailing slash, if any
    shortened_path="${shortened_path%/}"
    echo "$shortened_path"
}
