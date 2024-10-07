#!/bin/bash
if ! command -v brew &> /dev/null; then
    echo "Homebrew not installed. Please install it first."
    exit 1
fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
# brew update --quiet
packages=(gnupg swiftformat swiftgen sourcery xcodegen)
for package in "${packages[@]}"; do
    brew install --formula "$package" || true
done

title="Summary for Brew Packages"
headers=("Name" "Installed Version" "Latest Version")
output=$(brew info --json "${packages[@]}" |
jq -r '(.[] | [ .name, (.installed[] | .version), .versions.stable ]) | @tsv')

IFS=$'\n' read -d '' -r -a rows <<< "$output"

source Configurations/Make/print_table.sh
print_table "$title" headers[@] rows[@]