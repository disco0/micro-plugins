#!/bin/bash

# Go to script path
pushd "${BASH_SOURCE%/*}/" >/dev/null || exit
trap "popd >/dev/null 2>&1" EXIT 

# Set packages path
package_dir="./packages"
mkdir -p $package_dir || echo -e "\e[38;9mError creating packages output path. [ $package_dir ]"

version="v0.1"
list=$(ls src)
for package in $list
do
  version=$(cat src/$package/repo.json | grep "\"Version\":" | sed s/"\"Version\":"/""/ | sed s/","/""/ | tr "\t" "e" | sed s/"eeee"/""/ | sed s/" "/""/ | sed s/"\""/""/ | sed s/"\""/""/)
  zip -qr9 packages/$package-v$version.zip src/$package
done

popd >/dev/null