#!/bin/bash

command -v brew &> /dev/null || { echo "Please install homebrew first."; exit 1; }

bundle install --quiet
# Prevent Homebrew from auto-updating
export HOMEBREW_NO_AUTO_UPDATE=1
packages=(gnupg swiftformat swiftgen sourcery xcodegen)
for package in "${packages[@]}"; do
    brew install "$package" --quiet || true
done

combined_rows=()

brew_output=$(brew info --json "${packages[@]}" |
jq -r '(.[] | [ .name, (.installed[] | .version)]) | @tsv')

IFS=$'\n' read -d '' -r -a brew_rows <<< "$brew_output"

combined_rows+=("${brew_rows[@]}")

gem_names=$(grep "^\s*gem\s\+'\S\+'" Gemfile | sed "s/.*gem '\([^']*\)'.*/\1/")
IFS=$'\n' read -r -d '' -a gems <<< "$gem_names"$'\0'

for gem_name in "${gems[@]}"; do
    installed_version=$(grep "$gem_name ([0-9.]*)" Gemfile.lock | sed "s/.*(\(.*\)).*/\1/")
    printf -v gem_row "%s\t%s\t%s" "$gem_name" "$installed_version"
    combined_rows+=("$gem_row")
done
title="Installed Packages"
headers=("Name" "Installed Version")
source Configurations/Make/print_table.sh
{ print_table "$title" headers[@] combined_rows[@]; } >> debug.log