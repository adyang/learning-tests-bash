#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  tmpdir="$(realpath "$(mktemp -d)")"
  cat "${BATS_TEST_DIRNAME}/../script-dir" <(echo 'echo "${SCRIPT_DIR_DIRNAME_PWD}"') >"${tmpdir}/script"
  chmod u+x "${tmpdir}/script"

  tmpdir_symlink="${tmpdir}/symlink"
  ln -s "${tmpdir}" "${tmpdir_symlink}"

  mkdir "${tmpdir}/other"
  ln -s "${tmpdir}/script" "${tmpdir}/other/script.symlink"
}

teardown() {
  rm -rf "${tmpdir}"
}

@test "[script-dir] via dirname pwd: full path execution" {
  run "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir] via dirname pwd: cd script-dir and ./script execution" {
  cd "${tmpdir}"
  run "./script"

  assert_output "${tmpdir}"
}

@test "[script-dir] via dirname pwd: source script" {
  run source "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir] via dirname pwd: cd script-dir and bash script execution" {
  cd "${tmpdir}"
  run bash 'script'

  assert_output "${tmpdir}"
}

@test "[script-dir] via dirname pwd: execution from directory symlink" {
  run "${tmpdir_symlink}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir] via dirname pwd: [UNSUPPORTED] script symlink execution" {
  run "${tmpdir}/other/script.symlink"

  refute_output "${tmpdir}"
  assert_output "${tmpdir}/other"
}

@test "[script-dir] via dirname pwd: dirname fails" {
  dirname() {
    return 1
  }
  export -f dirname

  run "${tmpdir}/script"

  assert_failure 1
  refute_output
}

