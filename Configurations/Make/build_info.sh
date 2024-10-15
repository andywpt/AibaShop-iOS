#!/bin/bash

system_title="System and Build Info"
system_header=("Name" "Value")
system_rows=()
add_system_row() {
  system_rows+=("$1"$'\t'"$2")
}

add_system_row "$(sw_vers --productName)" "$(sw_vers --productVersion) ($(sw_vers --buildVersion))"
add_system_row "Xcode" "$(xcodebuild -version | sed -n '1s/Xcode //p') ($(xcodebuild -version | sed -n '2s/Build version //p'))"
add_system_row "Branch" "$(git rev-parse --abbrev-ref HEAD)"
add_system_row "Commit" "$(git rev-parse --short HEAD)"

. Configurations/Make/print_table.sh
{ print_table "$system_title" system_header[@] system_rows[@] ; } >> debug.log
