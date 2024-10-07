#!/bin/bash

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
    -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.0' \
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
    -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.0' \
    -derivedDataPath .local_derived_data \
  | xcpretty
fi
