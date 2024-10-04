#!/bin/sh
# This script should run before the Complie Sources step in build phase

# Adds support for Apple Silicon brew directory
export PATH="$PATH:/opt/homebrew/bin"

TEMPLATE_PATH=${PROJECT_DIR}/Configurations/Sourcery/config.stencil
OUTPUT_PATH=${PROJECT_DIR}/AibaShop/Resources/Configs/Config.swift

file=""
if [[ "${CONFIGURATION}" == *"Production"* ]]; then
    file=${PROJECT_DIR}/Configurations/Decrypted/.production.private.env
elif [[ "${CONFIGURATION}" == *"Staging"* ]]; then
    file=${PROJECT_DIR}/Configurations/Decrypted/.stage.private.env
else
    echo "Unknown configuration ${CONFIGURATION}"
    exit 1
fi

if [ ! -f $file ]; then
    echo "Missing env file at ${file}"
    exit 1
fi
# https://github.com/krzysztofzablocki/Sourcery/blob/master/guides/Usage.md
# Arguments should be separated with , without spaces (i.e. arg1=value,arg2=value)
# To pass in string you should use escaped quotes (\")
arguments=$(sed -n 's/=/ /p' $file | awk '{printf "%s=\"%s\",", $1, $2}' | sed 's/,$//')

# Codegen
sourcery \
    --templates $TEMPLATE_PATH \
    --sources $OUTPUT_PATH \
    --output $OUTPUT_PATH \
    --args $arguments
