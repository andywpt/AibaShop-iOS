#!/bin/sh
echo "⚙️  Installing pods in the project..."
bundle exec pod install

pod_names=$(grep "^\s*\bpod\b '\S\+'" Podfile | sed "s/.*'\(.*\)'.*/\1/")
IFS=$'\n' read -r -d '' -a pod_array <<< "$pod_names"$'\0'

pod_version_array=()
for pod in "${pod_array[@]}"; do
    regex="${pod}\s([0-9.]*)"
    version=$(grep $regex Podfile.lock | sed 's/.*(\([0-9.]*\)).*/\1/')
    pod_version_array+=("$pod"$'\t'"$version")
done
title="Pod Dependencies"
headers=("Name" "Installed Version")
source Configurations/Make/print_table.sh
print_table "$title" headers[@] pod_version_array[@]