#!/bin/bash
if ! command -v brew &> /dev/null; then
    echo "Homebrew not installed. Please install it first."
    exit 1
fi

echo "⚙️  Installing dependencies..."

bundle install --quiet

# Prevent Homebrew from auto-updating
export HOMEBREW_NO_AUTO_UPDATE=1

# Define the Homebrew packages to install
packages=(gnupg swiftformat swiftgen sourcery xcodegen)

# Install Homebrew packages quietly
for package in "${packages[@]}"; do
    brew install "$package" --quiet || true
done

# Prepare headers for the final table
title="Summary for installed dependencies"
headers=("Name" "Installed Version" "Latest Version")

# Initialize an array to hold all rows
combined_rows=()

# Get Homebrew package info
brew_output=$(brew info --json "${packages[@]}" |
jq -r '(.[] | [ .name, (.installed[] | .version), .versions.stable ]) | @tsv')

# Read Homebrew output into rows
IFS=$'\n' read -d '' -r -a brew_rows <<< "$brew_output"

# Add Homebrew rows to combined_rows
combined_rows+=("${brew_rows[@]}")

# Define the gems to check
gems=("cocoapods" "fastlane")

# Get the installed and latest versions of the gems
for gem_name in "${gems[@]}"; do
    installed_version=$(gem list --local | grep "^$gem_name " | awk '{print $2}' | sed 's/[()]//g')
    latest_version=$(gem search "$gem_name" --remote --exact | awk -F '[()]' '{print $2}' | head -n 1)
    
    # Format the output as tab-separated values and add to combined_rows
    printf -v gem_row "%s\t%s\t%s" "$gem_name" "$installed_version" "$latest_version"
    combined_rows+=("$gem_row")
done

source Configurations/Make/print_table.sh
print_table "$title" headers[@] combined_rows[@]