#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  tmpdir="$(realpath "$(mktemp -d)")"
}

teardown() {
  rm -rf "${tmpdir}"
}

@test "[string-multiline] store in variable via read heredoc" {
  IFS= read -r -d '' str <<'EOF' || true
${user} can't type!
nor can he/ she "hype"!
EOF

  run printf '%s' "${str}"

  assert_output - <<'EOF'
${user} can't type!
nor can he/ she "hype"!
EOF
}

@test "[string-multiline] store in variable via double quotes" {
  str="\
Anon can't type!
nor can he/ she \"hype\"!
"

  run printf '%s' "${str}"

  assert_output - <<'EOF'
Anon can't type!
nor can he/ she "hype"!

EOF
}

@test "[string-multiline] write to stdout via cat heredoc" {
  run cat <<'EOF'
${user} can't type!
nor can he/ she "hype"!
EOF

  assert_output - <<'EOF'
${user} can't type!
nor can he/ she "hype"!
EOF
}

@test "[string-multiline] write to stdout via printf double quotes" {
  run printf '%s' "\
Anon can't type!
nor can he/ she \"hype\"!
"

  assert_output - <<'EOF'
Anon can't type!
nor can he/ she "hype"!
EOF
}
