#!/bin/bash

latest_ios_version=$(xcrun simctl list devices | grep -oE 'iOS [0-9]+\.[0-9]+' | sort -V | tail -n 1)
selected_version=${latest_ios_version#* }
selected_model=$(xcrun simctl list devices | grep -A 10 --color=never "$latest_ios_version" | grep -oE 'iPhone [0-9]+' | sort -V | tail -n 1)

echo "Running tests on simulator ($selected_model, $selected_version)..."

# Set the cache folder path
cache_folder=$(readlink -f .local_derived_data/Build/Products/Production-Debug-iphonesimulator)

# Check if the cache folder exists
if [ -d "$cache_folder" ]; then
  echo "Cache folder exists. Running xcodebuild with PODS_CONFIGURATION_BUILD_DIR..."

  # Run xcodebuild with the cache folder
  xcodebuild test \
    -project AibaShop.xcodeproj \
    -scheme Production \
    -sdk iphonesimulator \
    -destination "platform=iOS Simulator,name=$selected_model,OS=$selected_version" \
    PODS_CONFIGURATION_BUILD_DIR=$cache_folder \
    FRAMEWORK_SEARCH_PATHS="$cache_folder \$(inherited)" \
    LIBRARY_SEARCH_PATHS="$cache_folder \$(inherited)" \
    SWIFT_INCLUDE_PATHS=$cache_folder \
  | xcpretty

else
  echo "Cache folder does not exist. Running xcodebuild with derivedDataPath..."

  # Run xcodebuild without the cache folder
  xcodebuild test \
    -workspace AibaShop.xcworkspace \
    -scheme Production \
    -sdk iphonesimulator \
    -destination "platform=iOS Simulator,name=$selected_model,OS=$selected_version" \
    -derivedDataPath .local_derived_data \
  | xcpretty
fi
