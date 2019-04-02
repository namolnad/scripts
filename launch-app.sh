#!/usr/bin/env bash

os=12.1
configuration=Debug
simulator=
scheme=
app_name=
base_dir=$(git rev-parse --show-toplevel)
project="$base_dir/$PROJECT.xcodeproj"
ide_path="$base_dir/build"

PS3="Choose a simulator: "

select d in $(ios-sim showdevicetypes | awk -F "," '{print $1}' | grep '^iP'); do
    if [ -n "$d" ]; then
        simulator=$(echo $d | sed -e 's/-/ /g')
        echo "Selected: $simulator"
        break
    fi
done

PS3="Choose a scheme: "
# Change the default file splitter to only split on new lines
OIFS="$IFS"
IFS=$'\n'

select t in $(xcodebuild -project "$project" -list | sed -e '1,/Schemes/d' | awk '{$1=$1;print}'); do
    if [ -n "$t" ]; then
        scheme=$t
        echo "Selected: $scheme"
        break
    fi
done

# Revert file splitter change
IFS="$OIFS"

xcrun xcodebuild \
  -project $project \
  -scheme "$scheme" \
  -configuration $configuration \
  -destination "platform=iOS Simulator,name=$simulator,OS=$os" \
  -derivedDataPath \
  $ide_path

app_name=$scheme

if [[ $app_name =~ "Enterprise" ]]; then
    app_name=$(echo "$app_name" | sed -e 's/Enterprise/ Beta/g')
fi

app_path="$ide_path/Build/Products/$configuration-iphonesimulator/"$app_name".app"

echo "$app_name"

ios-sim launch \
    --devicetypeid "$(echo $simulator | sed -e 's/ /-/g'), $os" \
  "$app_path"
