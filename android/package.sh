#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

output_dir="$(mktemp -d)"
package_source_dir="${script_dir}/package"
target_file="${output_dir}/cob.aar"

cp -pr "${package_source_dir}/AndroidManifest.xml" "${package_source_dir}/prefab" "${output_dir}"
module_dir="${output_dir}/prefab/modules/libcob"

declare -A abis
abis["arm64-v8a"]="aarch64-linux-android"
abis["x86_64"]="x86_64-linux-android"

cp -pr "${HOME}/.local/cobol-android-${abis['x86_64']}/include" "${module_dir}"/.

# Copy lib files
for abi in "${!abis[@]}"; do
    target="${abis[${abi}]}"
    echo "Packaging for target ${target}"
    install_dir="${HOME}/.local/cobol-android-${target}"
    lib_dir="${module_dir}/libs/android.${abi}/"
    mkdir -p "${lib_dir}"
    cp "${install_dir}/lib/libcob.so" "${lib_dir}"/.
done

pushd "${output_dir}" || exit

zip -r "${target_file}" AndroidManifest.xml prefab

popd || exit

echo "Created package in ${target_file}"
