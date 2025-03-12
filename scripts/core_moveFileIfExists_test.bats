load ./core.sh

setup() {
    mkdir -p "${BATS_TEST_TMPDIR}/input"
    mkdir -p "${BATS_TEST_TMPDIR}/output"
}

teardown() {
    rm -rf "${BATS_TEST_TMPDIR}"
}

@test "moves files that exists" {
    local source_file="${BATS_TEST_TMPDIR}/input/test.txt"
    local target_file="${BATS_TEST_TMPDIR}/output/test.txt"

    echo "test content" > "${source_file}"

    [ -f "${source_file}" ]
    [ ! -e "${target_file}" ]

    run moveFileIfExists "${source_file}" "${target_file}"

    [ -f "${target_file}" ]
    [ ! -e "${source_file}" ]
}

@test "does nothing when source file doesn't exist" {
    local source_file="${BATS_TEST_TMPDIR}/input/test.txt"
    local target_file="${BATS_TEST_TMPDIR}/output/test.txt"

    [ ! -e "${source_file}" ]
    [ ! -e "${target_file}" ]

    run moveFileIfExists "${source_file}" "${target_file}"

    [ ! -e "${source_file}" ]
    [ ! -e "${target_file}" ]
}

@test "does nothing when source file is a symlink" {
    local source_file="${BATS_TEST_TMPDIR}/input/test.txt"
    local target_file="${BATS_TEST_TMPDIR}/output/test.txt"
    local source_symlink="${BATS_TEST_TMPDIR}/input/somelink"

    ln -s "${source_file}" "${BATS_TEST_TMPDIR}/input/somelink"

    [ -L "${source_symlink}" ]
    [ ! -e "${target_file}" ]

    run moveFileIfExists "${source_file}" "${target_file}"

    [ -L "${source_symlink}" ]
    [ ! -e "${target_file}" ]
}
