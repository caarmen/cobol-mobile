#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
source "${script_dir}/build_env.sh"

min_ios="15.0"

targets=(
  "arm64:iphoneos:apple-ios${min_ios}"
  "arm64:iphonesimulator:apple-ios${min_ios}-simulator"
  "x86_64:iphonesimulator:apple-ios${min_ios}-simulator"
)

for entry in "${targets[@]}"; do
    echo "Building for ${entry}"
    IFS=":" read -r arch sdk suffix <<< "$entry"
    export SDK="${sdk}"
    export ARCH="${arch}"
    export HOST="${arch}-apple-ios"
    export TARGET="${arch}-${suffix}"
    "${script_dir}/build-gmp.sh"
    "${script_dir}/build-libdb.sh"
    "${script_dir}/build-gnucobol.sh"
done

"${script_dir}/package.sh"
