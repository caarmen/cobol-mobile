#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

output_dir="$(mktemp -d)"

# Combine the simulator builds with lipo.
lipo -create \
  "${HOME}"/.local/cobol-ios-arm64-apple-ios15.0-simulator/lib/libcob-all.a \
  "${HOME}"/.local/cobol-ios-x86_64-apple-ios15.0-simulator/lib/libcob-all.a \
  -o "${output_dir}"/libcob-all.a

# Package a framework containing the simulator and phone builds.
target_framework="${output_dir}/GnuCOBOL.xcframework"

xcodebuild -create-xcframework \
  -library "${HOME}"/.local/cobol-ios-arm64-apple-ios15.0/lib/libcob-all.a \
  -headers "${HOME}"/.local/cobol-ios-arm64-apple-ios15.0/include \
  -library "${output_dir}/libcob-all.a" \
  -headers "${HOME}"/.local/cobol-ios-arm64-apple-ios15.0-simulator/include \
  -output "${target_framework}"

cp "${script_dir}/package/Headers/"* "${target_framework}"/ios-arm64/Headers
cp "${script_dir}/package/Headers/"* "${target_framework}"/ios-arm64_x86_64-simulator/Headers
rm "${output_dir}/libcob-all.a"

pushd "${output_dir}" || exit
find . | \
  LC_ALL=C sort | \
  TZ=UTC zip -X -@ "${target_framework}.zip"

# For repeatable builds:
# If possible, use strip-nondeterminism to make the
# zip file the same for the same inputs.
if command -v strip-nondeterminism &> /dev/null; then
  strip-nondeterminism "${target_framework}.zip"
fi
popd || exit

# Prepare the Package.swift file.
echo "Computing SHA256 checksum..."
checksum="$(shasum -a 256 "${target_framework}.zip" | awk '{print $1}')"

version="0.0.5"

sed -e "s/__VERSION__/${version}/g;s/__SHA256_CHECKSUM__/${checksum}/g" \
  "${script_dir}/package/Package.swift.template" > "${script_dir}/../Package.swift"

mkdir -p "${script_dir}/deps"
cp "${target_framework}.zip" "${script_dir}/deps/".
