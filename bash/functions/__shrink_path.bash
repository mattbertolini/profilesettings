__shrink_path() {
    local original_path="$1"
    local retain_count="${2:-1}" # Default to 1 if not provided

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

    # Calculate how many directories can be shortened
    local shorten_limit=$((${#parts[@]} - retain_count))

    # Process each part
    for i in "${!parts[@]}"; do
        if [[ "${parts[$i]}" == "" ]]; then
            # Handle leading "/" for absolute paths
            if [[ $i -eq 0 && $is_home_path == false ]]; then
                shortened_path+="/"
            fi
        elif [[ $i -ge $shorten_limit ]]; then
            # Retain the full name for the last `retain_count` directories
            shortened_path+="${parts[$i]}"
            # Add slashes between directories except for the last one
            if [[ $i -lt $((${#parts[@]} - 1)) ]]; then
                shortened_path+="/"
            fi
        else
            # Take the first letter of intermediate directories
            # For directories that begin with a dot, keep the dot and the first character
            if [[ "${parts[$i]:0:1}" == "." ]]; then
                shortened_path+="${parts[$i]:0:2}/"
            else
                shortened_path+="${parts[$i]:0:1}/"
            fi
        fi
    done

    # Remove a trailing slash, if any
    shortened_path="${shortened_path%/}"
    echo "$shortened_path"
}
