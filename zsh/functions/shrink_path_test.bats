# Testing __shrink_path function for zsh

# Define the path to the zsh function file
ZSH_FUNCTION_PATH="${BATS_TEST_DIRNAME}/__shrink_path.zsh"

# Helper function to run the zsh function
run_zsh_function() {
    #echo "[DEBUG] Running: __shrink_path '$1' ${2:-}" >&3
    local result=$(zsh -c "source \"$ZSH_FUNCTION_PATH\"; __shrink_path '$1' ${2:-}")
    #echo "[DEBUG] Result: $result" >&3
    echo "$result"
}

@test "Root directory (/) is unchanged" {
    run run_zsh_function "/"
    [ "$status" -eq 0 ]
    [ "$output" = "/" ]
}

@test "Home directory (~) is unchanged" {
    run run_zsh_function "~"
    [ "$status" -eq 0 ]
    [ "$output" = "~" ]
}

@test "Shortening path with home directory (~/test/dir/subdir/another/testing)" {
    run run_zsh_function "~/test/dir/subdir/another/testing"
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/d/s/a/testing" ]
}

@test "Shortening path from root (/opt/test/dir/subdir/testing)" {
    run run_zsh_function "/opt/test/dir/subdir/testing"
    [ "$status" -eq 0 ]
    [ "$output" = "/o/t/d/s/testing" ]
}

@test "Path with trailing slash doesn't add trailing slash in shortened form" {
    run run_zsh_function "~/test/dir/subdir/"
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/d/subdir" ]
}

@test "Don't shorten single directory from home directory (~/test)" {
    run run_zsh_function "~/test"
    [ "$status" -eq 0 ]
    [ "$output" = "~/test" ]
}

@test "Don't shorten single directory from root (/opt)" {
    run run_zsh_function "/opt"
    [ "$status" -eq 0 ]
    [ "$output" = "/opt" ]
}

@test "Preserves case sensitivity properly" {
    run run_zsh_function "~/test/Dir/subdir/Testing"
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/D/s/Testing" ]
}

@test "Shortening path with home directory and keeping more than one directory full" {
    run run_zsh_function "~/test/dir/subdir/another/testing" 2
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/d/s/another/testing" ]
}

@test "Shortening path from root and keeping more than one directory full" {
    run run_zsh_function "/opt/test/dir/subdir/testing" 2
    [ "$status" -eq 0 ]
    [ "$output" = "/o/t/d/subdir/testing" ]
}

@test "Large retain number keeps the full path (with home directory)" {
    run run_zsh_function "~/test/dir/subdir/another/testing" 999
    [ "$status" -eq 0 ]
    [ "$output" = "~/test/dir/subdir/another/testing" ]
}

@test "Large retain number keeps the full path (with root directory)" {
    run run_zsh_function "/opt/test/dir/subdir/testing" 999
    [ "$status" -eq 0 ]
    [ "$output" = "/opt/test/dir/subdir/testing" ]
}

@test "Shrinks a directory that begins with a dot" {
    run run_zsh_function "~/.config/dir/subdir/another/testing"
    [ "$status" -eq 0 ]
    [ "$output" = "~/.c/d/s/a/testing" ]
}

@test "Shrinks a directory that begins with a dot (case sensitivity respected)" {
    run run_zsh_function "~/.Something/dir/subdir/another/testing"
    [ "$status" -eq 0 ]
    [ "$output" = "~/.S/d/s/a/testing" ]
}

@test "Large retain number keeps the full path (with a dot directory)" {
    run run_zsh_function "/opt/.test/dir/subdir/testing" 999
    [ "$status" -eq 0 ]
    [ "$output" = "/opt/.test/dir/subdir/testing" ]
}

@test "Preserve dot directory like regular directories" {
    run run_zsh_function "/opt/test/.dir/subdir/testing" 3
    [ "$status" -eq 0 ]
    [ "$output" = "/o/t/.dir/subdir/testing" ]
}
