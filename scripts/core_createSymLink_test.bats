load ./core.sh

setup() {
  # Create input directory
  mkdir -p "$BATS_TEST_TMPDIR/input"

  # Create the input file
  echo "test content" > "$BATS_TEST_TMPDIR/input/test.txt"
}

teardown() {
  # Clean up the temporary files and directories
  rm -rf "$BATS_TEST_TMPDIR"
}

@test "createSymlink creates a symlink correctly" {
  local target_file="${BATS_TEST_TMPDIR}/input/test.txt"
  local symlink_path="${BATS_TEST_TMPDIR}/output_symlink"

  run createSymlink "${target_file}" "${symlink_path}"

  # Assert that the symlink exists
  [ -e "${symlink_path}" ]

  # Assert that it is a symlink
  [ -L "${symlink_path}" ]

  # Assert that the symlink points to the correct file
  expected_target=$(readlink "${symlink_path}")
  [[ "${expected_target}" = "${target_file}" ]]
}

@test "createSymlink replaces an existing symlink with a new one" {
  # Create additional input file
  local original_target_file="${BATS_TEST_TMPDIR}/input/test.txt"
  local new_target_file="${BATS_TEST_TMPDIR}/input/new_test.txt"
  echo "new test content" > "${new_target_file}"

  # Create symlink pointing to the original file
  local symlink_path="${BATS_TEST_TMPDIR}/output_symlink"
  run createSymlink "${original_target_file}" "${symlink_path}"

  # Assert that the symlink initially points to the original file
  local initial_target=$(readlink "${symlink_path}")
  [[ "${initial_target}" = "${original_target_file}" ]]

  # Replace the symlink to point to the new file
  run createSymlink "${new_target_file}" "${symlink_path}"

  # Assert that the symlink now points to the new file
  local updated_target=$(readlink "${symlink_path}")
  [[ "${updated_target}" = "${new_target_file}" ]]
}
