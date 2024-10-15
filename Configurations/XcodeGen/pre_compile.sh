#!/bin/sh

run_script() {
    local file="$1"
    chmod +x "$file" && "$file"
}

DIR="$PROJECT_DIR/Configurations"

run_script "$DIR/Sourcery/sourcery.sh"
run_script "$DIR/SwiftGen/swiftgen.sh"
run_script "$DIR/Firebase/firebase.sh"