# Testing __shrink_path function

load ./__shrink_path.bash

@test "Root directory (/) is unchanged" {
    run __shrink_path "/"
    [ "$status" -eq 0 ]
    [ "$output" = "/" ]
}

@test "Home directory (~) is unchanged" {
    run __shrink_path "~"
    [ "$status" -eq 0 ]
    [ "$output" = "~" ]
}

@test "Shortening path with home directory (~/test/dir/subdir/another/testing)" {
    run __shrink_path "~/test/dir/subdir/another/testing"
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/d/s/a/testing" ]
}

@test "Shortening path from root (/opt/test/dir/subdir/testing)" {
    run __shrink_path "/opt/test/dir/subdir/testing"
    [ "$status" -eq 0 ]
    [ "$output" = "/o/t/d/s/testing" ]
}

@test "Path with trailing slash doesn't add trailing slash in shortened form" {
    run __shrink_path "~/test/dir/subdir/"
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/d/subdir" ]
}

@test "Don't shorten single directory from home directory (~/test)" {
    run __shrink_path "~/test"
    [ "$status" -eq 0 ]
    [ "$output" = "~/test" ]
}

@test "Don't shorten single directory from root (/opt)" {
    run __shrink_path "/opt"
    [ "$status" -eq 0 ]
    [ "$output" = "/opt" ]
}

@test "Preserves case sensitivity properly" {
    run __shrink_path "~/test/Dir/subdir/Testing"
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/D/s/Testing" ]
}

@test "Shortening path with home directory and keeping more than one directory full" {
    run __shrink_path "~/test/dir/subdir/another/testing" 2
    [ "$status" -eq 0 ]
    [ "$output" = "~/t/d/s/another/testing" ]
}

@test "Shortening path from root and keeping more than one directory full" {
    run __shrink_path "/opt/test/dir/subdir/testing" 2
    [ "$status" -eq 0 ]
    [ "$output" = "/o/t/d/subdir/testing" ]
}

@test "Large retain number keeps the full path (with home directory)" {
    run __shrink_path "~/test/dir/subdir/another/testing" 999
    [ "$status" -eq 0 ]
    [ "$output" = "~/test/dir/subdir/another/testing" ]
}

@test "Large retain number keeps the full path (with root directory)" {
    run __shrink_path "/opt/test/dir/subdir/testing" 999
    [ "$status" -eq 0 ]
    [ "$output" = "/opt/test/dir/subdir/testing" ]
}
