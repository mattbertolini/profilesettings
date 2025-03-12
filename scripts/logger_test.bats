load ./logger.sh

setup() {
  # Stubs or mock variables can go here if needed
  export TERM="xterm-256color" # Simulate a color-capable terminal by default
}

teardown() {
  unset TERM
}

@test "log_error prints color output when terminal supports color" {
    expected=$'\E[31mERROR:\E[0m This is a test of error output'
    run log_error "This is a test of error output"
    [[ "${output}" = "${expected}" ]]
}

@test "log_error prints plain output when terminal doesn't support color" {
    export TERM=dumb
    expected=$'ERROR: This is a test of error output'
    run log_error "This is a test of error output"
    [[ "${output}" = "${expected}" ]]
}

@test "log_info prints color output when terminal supports color" {
    expected=$'\E[31mINFO:\E[0m This is a test of info output'
    run log_info "This is a test of info output"
    [[ "${output}" = "${expected}" ]]
}

@test "log_info prints plain output when terminal doesn't support color" {
    export TERM=dumb
    expected=$'INFO: This is a test of info output'
    run log_info "This is a test of info output"
    [[ "${output}" = "${expected}" ]]
}

@test "log_warning prints color output when terminal supports color" {
    expected=$'\E[33mWARN:\E[0m This is a test of warning output'
    run log_warning "This is a test of warning output"
    [[ "${output}" = "${expected}" ]]
}

@test "log_warning prints plain output when terminal doesn't supports color" {
    export TERM=dumb
    expected=$'WARN: This is a test of warning output'
    run log_warning "This is a test of warning output"
    [[ "${output}" = "${expected}" ]]
}

@test "__supports_color_output returns 0 when terminal supports color" {
    run __supports_color_output
    [ "$status" -eq 0 ]
}

@test "__supports_color_output returns 1 when terminal doesn't support color" {
    export TERM=dumb
    run __supports_color_output
    [ "$status" -eq 1 ]
}
