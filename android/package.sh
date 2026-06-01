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

version="0.0.2"
mvn install:install-file \
 -Dfile="${target_file}" \
 -DgroupId=ca.rmen\
 -DartifactId=gnucobol-android \
 -Dversion="${version}" \
 -Dpackaging=aar \
 -DpomFile="${script_dir}/package/publish.pom"

echo "Deployed to maven local"

if [ "${GPGKEY}" != "" ]
then
  # To sign the package, use the following command to find the name of your gpg key:
  # gpg --list-signatures --keyid-format 0xshort
  # The name of the key is the first token after "sig 3".
  # See https://central.sonatype.org/publish/requirements/gpg/#listing-keys for more info.
  # Set the environment variable GPGKEY to the name of the key to use.
  pushd "${HOME}/.m2/repository" || exit
  publish_content_dir="ca/rmen/gnucobol-android/${version}"
  for file in "${publish_content_dir}"/*.aar "${publish_content_dir}"/*.pom; do
    gpg --local-user "${GPGKEY}" -ab "${file}"
    md5 -q "${file}" > "${file}".md5
    for algo in 1 256 512; do
      shasum -a "${algo}" "${file}" | awk '{ print $1 }' > "${file}.sha${algo}"
    done
  done
  # Create a bundle containing everything (jar, asc, pom files, and all their md5 and sha corresponding files).
  artifact="${output_dir}/gnucobol-${version}.jar"
  jar cfM "${artifact}" "${publish_content_dir}"/gnucobol-android*
  popd || exit
  echo "Publishable artifact: ${artifact}"
fi

