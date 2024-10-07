#!/bin/sh

# Adds support for Apple Silicon brew directory
export PATH="$PATH:/opt/homebrew/bin"

mint run swiftgen config run --config "${PROJECT_DIR}/Configurations/SwiftGen/swiftgen.yml"
