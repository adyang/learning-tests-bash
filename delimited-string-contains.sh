#!/bin/bash

contains_element() {
  local list="$1"
  local elem="$2"
  local delimiter="${3:-,}"
  [[ "${list}" =~ (^|"${delimiter}")"${elem}"("${delimiter}"|$) ]]
}

