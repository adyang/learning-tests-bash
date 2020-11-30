#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  tmpdir="$(realpath "$(mktemp -d)")"
}

teardown() {
  rm -rf "${tmpdir}"
}

@test "[string-quoting] literal single quote via concatenation" {
  str='${user} can'\''t type!'

  run printf '%s' "${str}"

  assert_output - <<'EOF'
${user} can't type!
EOF
}

@test "[string-quoting] literal single quote via double quotes" {
  str="Anon can't type!"

  run printf '%s' "${str}"

  assert_output - <<'EOF'
Anon can't type!
EOF
}

@test "[string-quoting] literal single quote via ANSI-C strings" {
  str=$'${user} can\'t type!'

  run printf '%s' "${str}"

  assert_output - <<'EOF'
${user} can't type!
EOF
}

@test "[string-quoting] literal single quote via heredoc" {
  IFS= read -r str <<'EOF'
${user} can't type!
EOF

  run printf '%s' "${str}"

  assert_output - <<'EOF'
${user} can't type!
EOF
}
