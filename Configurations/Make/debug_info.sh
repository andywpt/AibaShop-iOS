#!/bin/bash
#!/bin/bash

# Define titles and headers for the tables
system_title="System"
git_title="Git"
system_header=("Name" "Value")
git_header=("Name" "Value")

# Initialize arrays for combined rows
system_rows=()
git_rows=()

# Function to add rows to the system information table
add_system_row() {
    system_rows+=("$1	$2")  # Use tab as separator
}

# Function to add rows to the Git information table
add_git_row() {
    git_rows+=("$1	$2")  # Use tab as separator
}

# Add system information
add_system_row "$(sw_vers --productName)" "$(sw_vers --productVersion) ($(sw_vers --buildVersion))"
add_system_row "Xcode" "$(xcodebuild -version | sed -n '1s/Xcode //p') ($(xcodebuild -version | sed -n '2s/Build version //p'))"

# Add Git information
add_git_row "Branch" "$(git rev-parse --abbrev-ref HEAD)"
add_git_row "Commit" "$(git rev-parse --short HEAD)"

# Source the script that contains the print_table function
source Configurations/Make/print_table.sh

# Print the system information table
print_table "$system_title" system_header[@] system_rows[@]

# Print the Git information table
print_table "$git_title" git_header[@] git_rows[@]
