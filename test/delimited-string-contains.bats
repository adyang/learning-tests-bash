#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ./delimited-string-contains.sh

@test "default comma delimiter: first element present" {
  run contains_element 'one,two,three' 'one'
  assert_success
}

@test "default comma delimiter: middle element present" {
  run contains_element 'one,two,three' 'two'
  assert_success
}

@test "default comma delimiter: last element present" {
  run contains_element 'one,two,three' 'three'
  assert_success
}

@test "default comma delimiter: element with space present" {
  run contains_element 'one,two one,three' 'two one'
  assert_success
}

@test "default comma delimiter: element absent" {
  run contains_element 'one,two,three' 'absent'
  assert_failure
}

@test "default comma delimiter: element with space absent" {
  run contains_element 'one,two one,three' 'two'
  assert_failure
}

@test "custom single char delimiter: element present" {
  run contains_element 'one@two@three' 'two' '@'
  assert_success
}

@test "custom single char delimiter: element absent" {
  run contains_element 'one@two@three' 'tw' '@'
  assert_failure
}

@test "custom single special char delimiter: element present" {
  run contains_element 'one$two$three' 'two' '$'
  assert_success
}

@test "custom single special char delimiter: element absent" {
  run contains_element 'one$two$three' 'tw' '$'
  assert_failure
}

@test "custom multi char delimiter: element present" {
  run contains_element 'one, two, three' 'two' ', '
  assert_success
}

@test "custom multi char delimiter: element absent" {
  run contains_element 'one, two, three' 'none' ', '
  assert_failure
}

