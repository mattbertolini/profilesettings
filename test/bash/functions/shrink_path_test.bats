# Load the __shrink_path function from the script file
# Make sure to replace '__shrink_path.sh' with the actual file where the function is defined
load ../../../bash/functions/__shrink_path.bash

# Test: Root directory stays unchanged
@test "Root directory is not shortened" {
    run __shrink_path "/"
    [ "$status" -eq 0 ]
    [ "$output" = "/" ]
}

# Test: Home directory (~) stays unchanged
@test "Home directory (~) is not shortened" {
    run __shrink_path "~"
    [ "$status" -eq 0 ]
    [ "$output" = "~" ]
}

# Test: ~/dev/projects/testing -> ~/d/p/testing
@test "Shortening ~/dev/projects/testing" {
    run __shrink_path "~/dev/projects/testing"
    [ "$status" -eq 0 ]
    [ "$output" = "~/d/p/testing" ]
}

# Test: /usr/local/bin -> /u/l/bin
@test "Shortening /usr/local/bin" {
    run __shrink_path "/usr/local/bin"
    [ "$status" -eq 0 ]
    [ "$output" = "/u/l/bin" ]
}

# Test: ~/Sync/dev/tools/ant -> ~/S/d/t/ant
@test "Shortening ~/Sync/dev/tools/ant" {
    run __shrink_path "~/Sync/dev/tools/ant"
    [ "$status" -eq 0 ]
    [ "$output" = "~/S/d/t/ant" ]
}

# Test: No trailing slash in result
@test "Path with trailing slash doesn't add trailing slash in shortened form" {
    run __shrink_path "~/Sync/dev/tools/ant/"
    [ "$status" -eq 0 ]
    [ "$output" = "~/S/d/t/ant" ]
}

# Test: Combination of root and last directory
@test "Shortening /etc/nginx includes root and last directory" {
    run __shrink_path "/etc/nginx"
    [ "$status" -eq 0 ]
    [ "$output" = "/e/nginx" ]
}

# Test: Shorten deeply nested paths
@test "Shortening deeply nested path /var/lib/mysql/database" {
    run __shrink_path "/var/lib/mysql/database"
    [ "$status" -eq 0 ]
    [ "$output" = "/v/l/m/database" ]
}

# Test: Case sensitivity (Sync stays as S)
@test "Preserves case sensitivity properly" {
    run __shrink_path "~/Sync/Dev/Tools/ANT"
    [ "$status" -eq 0 ]
    [ "$output" = "~/S/D/T/ANT" ]
}