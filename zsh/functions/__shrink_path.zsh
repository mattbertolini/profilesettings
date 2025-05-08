__shrink_path() {
    local path="$1"
    local retain_count="${2:-1}" # Default to 1 if not provided

    # Special cases
    if [[ "$path" == "~" || "$path" == "/" ]]; then
        echo "$path"
        return
    fi

    # Handle home directory paths
    local prefix=""
    if [[ "$path" == "~/"* ]]; then
        prefix="~"
        path="${path#\~/}"
    elif [[ "$path" == "/" ]]; then
        prefix="/"
        path=""
    elif [[ "$path" == "/"* ]]; then
        prefix="/"
        path="${path#\/}"
    fi

    # Remove trailing slash if present
    path="${path%/}"

    # Handle single directory case
    if [[ "$path" != */* ]]; then
        if [[ -n "$path" ]]; then
            if [[ "$prefix" == "/" ]]; then
                echo "/${path}"
            else
                echo "${prefix}/${path}"
            fi
        else
            echo "${prefix}"
        fi
        return
    fi

    # Split the path into components
    local -a components
    IFS='/' read -A components <<< "$path"

    # If there's only one component, don't shorten it
    if [[ ${#components[@]} -eq 1 ]]; then
        echo "${prefix}/${components[1]}"
        return
    fi

    # Calculate how many directories to retain in full
    local to_shorten=$((${#components[@]} - retain_count))
    if [[ $to_shorten -lt 0 ]]; then
        to_shorten=0
    fi

    # Build the shortened path
    local result=""
    local i=1
    for component in "${components[@]}"; do
        if [[ $i -le $to_shorten ]]; then
            # Shorten this component
            if [[ "$component" == .* ]]; then
                result="${result}/.${component:1:1}"
            else
                result="${result}/${component:0:1}"
            fi
        else
            # Keep this component in full
            result="${result}/${component}"
        fi
        ((i++))
    done

    # Add the prefix
    if [[ -n "$result" ]]; then
        if [[ "$prefix" == "/" && "${result:0:1}" == "/" ]]; then
            # Avoid double slash for absolute paths
            result="${result}"
        else
            result="${prefix}${result}"
        fi
    else
        result="${prefix}"
    fi

    echo "$result"
}
