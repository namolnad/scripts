#!/usr/bin/env bash

base_dir=$(git rev-parse --show-toplevel)
ide_path="$base_dir/build"
project=Instacart.xcodeproj
scheme=Instacart
configuration=Debug
simulator='iPhone 12 mini'
os=14.1

command="test"

for arg in "$@"; do
    command="$command -only-testing:$arg"
done

echo """*Note* To limit executed tests, pass space-separated list \
using one of the following patterns:
    (target | target/class | target/class/test_name)"""

echo """
xcrun xcodebuild
  -project $project
  -scheme "$scheme"
  -configuration $configuration
  -destination "\'platform=iOS Simulator,name=$simulator,OS=$os\'"
  $command
"""

xcrun xcodebuild \
  -project $project \
  -scheme "$scheme" \
  -configuration $configuration \
  -destination "platform=iOS Simulator,name=$simulator,OS=$os" \
  $command
