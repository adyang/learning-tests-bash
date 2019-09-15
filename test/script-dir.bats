#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  tmpdir="$(realpath "$(mktemp -d)")"
}

teardown() {
  rm -rf "${tmpdir}"
}

@test "[script-dir-dirname-pwd] full path execution" {
  create_test_script_symlinks 'script-dir-dirname-pwd'

  run "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-dirname-pwd] cd script-dir and ./script execution" {
  create_test_script_symlinks 'script-dir-dirname-pwd'

  cd "${tmpdir}"
  run "./script"

  assert_output "${tmpdir}"
}

@test "[script-dir-dirname-pwd] source script" {
  create_test_script_symlinks 'script-dir-dirname-pwd'

  run source "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-dirname-pwd] cd script-dir and bash script execution" {
  create_test_script_symlinks 'script-dir-dirname-pwd'

  cd "${tmpdir}"
  run bash 'script'

  assert_output "${tmpdir}"
}

@test "[script-dir-dirname-pwd] execution from directory symlink" {
  create_test_script_symlinks 'script-dir-dirname-pwd'

  run "${tmpdir_symlink}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-dirname-pwd] [UNSUPPORTED] script symlink execution" {
  create_test_script_symlinks 'script-dir-dirname-pwd'

  run "${tmpdir}/other/script.symlink"

  refute_output "${tmpdir}"
  assert_output "${tmpdir}/other"
}

@test "[script-dir-dirname-pwd] dirname fails" {
  create_test_script_symlinks 'script-dir-dirname-pwd'
  dirname() {
    return 1
  }
  export -f dirname

  run "${tmpdir}/script"

  assert_failure 1
  refute_output
}

@test "[script-dir-builtins] full path execution" {
  create_test_script_symlinks 'script-dir-builtins'

  run "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-builtins] cd script-dir and ./script execution" {
  create_test_script_symlinks 'script-dir-builtins'

  cd "${tmpdir}"
  run "./script"

  assert_output "${tmpdir}"
}

@test "[script-dir-builtins] source script" {
  create_test_script_symlinks 'script-dir-builtins'

  run source "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-builtins] cd script-dir and bash script execution" {
  create_test_script_symlinks 'script-dir-builtins'

  cd "${tmpdir}"
  run bash 'script'

  assert_output "${tmpdir}"
}

@test "[script-dir-builtins] execution from directory symlink" {
  create_test_script_symlinks 'script-dir-builtins'

  run "${tmpdir_symlink}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-builtins] [UNSUPPORTED] script symlink execution" {
  create_test_script_symlinks 'script-dir-builtins'

  run "${tmpdir}/other/script.symlink"

  refute_output "${tmpdir}"
  assert_output "${tmpdir}/other"
}

@test "[script-dir-builtins] cd fails" {
  create_test_script_symlinks 'script-dir-builtins'
  cd() {
    return 1
  }
  export -f cd

  run "${tmpdir}/script"

  assert_failure 1
  refute_output
}

@test "[script-dir-realpath] full path execution" {
  create_test_script_symlinks 'script-dir-realpath'

  run "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-realpath] cd script-dir and ./script execution" {
  create_test_script_symlinks 'script-dir-realpath'

  cd "${tmpdir}"
  run "./script"

  assert_output "${tmpdir}"
}

@test "[script-dir-realpath] source script" {
  create_test_script_symlinks 'script-dir-realpath'

  run source "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-realpath] cd script-dir and bash script execution" {
  create_test_script_symlinks 'script-dir-realpath'

  cd "${tmpdir}"
  run bash 'script'

  assert_output "${tmpdir}"
}

@test "[script-dir-realpath] execution from directory symlink" {
  create_test_script_symlinks 'script-dir-realpath'

  run "${tmpdir_symlink}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-realpath] script symlink execution" {
  create_test_script_symlinks 'script-dir-realpath'

  run "${tmpdir}/other/script.symlink"

  assert_output "${tmpdir}"
}

@test "[script-dir-realpath] realpath fails" {
  create_test_script_symlinks 'script-dir-realpath'
  realpath() {
    return 1
  }
  export -f realpath

  run "${tmpdir}/script"

  assert_failure 1
  refute_output
}

@test "[script-dir-realpath] dirname fails" {
  create_test_script_symlinks 'script-dir-realpath'
  dirname() {
    return 1
  }
  export -f dirname

  run "${tmpdir}/script"

  assert_failure 1
  refute_output
}

@test "[script-dir-realpath] realpath command not found" {
  create_test_script_symlinks 'script-dir-realpath'
  hash() {
    if [[ "$1" == 'realpath' ]]; then
      return 1
    else
      return 0
    fi
  }
  export -f hash

  run "${tmpdir}/script"

  assert_failure 127
}

@test "[script-dir-readlink] full path execution" {
  create_test_script_symlinks 'script-dir-readlink'

  run "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-readlink] cd script-dir and ./script execution" {
  create_test_script_symlinks 'script-dir-readlink'

  cd "${tmpdir}"
  run "./script"

  assert_output "${tmpdir}"
}

@test "[script-dir-readlink] source script" {
  create_test_script_symlinks 'script-dir-readlink'

  run source "${tmpdir}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-readlink] cd script-dir and bash script execution" {
  create_test_script_symlinks 'script-dir-readlink'

  cd "${tmpdir}"
  run bash 'script'

  assert_output "${tmpdir}"
}

@test "[script-dir-readlink] execution from directory symlink" {
  create_test_script_symlinks 'script-dir-readlink'

  run "${tmpdir_symlink}/script"

  assert_output "${tmpdir}"
}

@test "[script-dir-readlink] script symlink execution" {
  create_test_script_symlinks 'script-dir-readlink'

  run "${tmpdir}/other/script.symlink"

  assert_output "${tmpdir}"
}

@test "[script-dir-readlink] readlink fails" {
  create_test_script_symlinks 'script-dir-readlink'
  hash() {
    if [[ "$1" == 'greadlink' ]]; then
      return 1
    else
      return 0
    fi
  }
  readlink() {
    if [[ "$*" == "--canonicalize ." ]]; then
      return 0
    else
      return 1
    fi
  }
  export -f hash readlink

  run "${tmpdir}/script"

  assert_failure 1
  refute_output
}

@test "[script-dir-readlink] dirname fails" {
  create_test_script_symlinks 'script-dir-readlink'
  dirname() {
    return 1
  }
  export -f dirname

  run "${tmpdir}/script"

  assert_failure 1
  refute_output
}

@test "[script-dir-readlink] GNU readlink command not found" {
  create_test_script_symlinks 'script-dir-readlink'
  hash() {
    if [[ "$1" == 'greadlink' ]]; then
      return 1
    else
      return 0
    fi
  }
  readlink() {
    if [[ "$1" == '--canonicalize' ]]; then
      return 1
    else
      return 0
    fi
  }
  export -f hash readlink

  run "${tmpdir}/script"

  assert_failure 127
  assert_output 'GNU readlink not found'
}

create_test_script_symlinks() {
  local script_name="$1"
  cat "${BATS_TEST_DIRNAME}/../${script_name}" <(echo 'echo "${SCRIPT_DIR}"') >"${tmpdir}/script"
  chmod u+x "${tmpdir}/script"

  tmpdir_symlink="${tmpdir}/symlink"
  ln -s "${tmpdir}" "${tmpdir_symlink}"

  tmpdir_other="${tmpdir}/other"
  mkdir "${tmpdir_other}"
  ln -s "${tmpdir}/script" "${tmpdir_other}/script.symlink"
}

