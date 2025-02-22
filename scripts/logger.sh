#!/bin/sh

set -eu

# Colors
red="\e[31m"
reset="\e[0m"
yellow="\e[33m"
bold_yellow="\e[1;33m"

log_error() {
    __log_error_input="$1"
    if __supports_color_output; then
        printf "${red}ERROR:${reset} %s\n" "${__log_error_input}"
    else
        printf "ERROR: %s\n" "${__log_error_input}"
    fi
}

log_info() {
    __log_info_input="$1"
    if __supports_color_output; then
        printf "${red}INFO:${reset} %s\n" "${__log_info_input}"
    else
        printf "INFO: %s\n" "${__log_info_input}"
    fi
}

log_warning() {
    __log_warning_input="$1"
    if __supports_color_output; then
        printf "${yellow}WARN:${reset} %s\n" "${__log_warning_input}"
    else
        printf "WARN: %s\n" "${__log_warning_input}"
    fi
}

__supports_color_output() {
    [ "$(tput colors 2>/dev/null)" -ge 8 ]
}
