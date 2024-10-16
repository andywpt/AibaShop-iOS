#!/bin/sh

bundle exec pod install
pods=($(grep "^\s*\bpod\b '\S\+'" Podfile | sed "s/.*'\(.*\)'.*/\1/"))
values=()
for pod in "${pods[@]}"; do
    regex="${pod}\s([0-9.]*)"
    version=$(grep $regex Podfile.lock | sed 's/.*(\([0-9.]*\)).*/\1/')
    values+=("$pod"$'\t'"$version")
done
title="Pod Dependencies Summary"
headers=("Name" "Installed Version")
. Configurations/Make/print_table.sh
{ print_table "$title" headers[@] values[@]; } >> debug.log