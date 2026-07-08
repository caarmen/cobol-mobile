#!/usr/bin/env bash

set -e

if (( "$#" != 1 )); then
  echo "Usage: $0 <gpgkey>"
  echo "To sign the package, use the following command to find the name of your gpg key:"
  echo "gpg --list-signatures --keyid-format 0xshort"
  echo "The name of the key is the first token after 'sig 3'."
  echo "See https://central.sonatype.org/publish/requirements/gpg/#listing-keys for more info."
  echo "Set the environment variable GPGKEY to the name of the key to use."
  exit 1
else
  gpgkey=$1
fi

pushd GnuCOBOL || exit
./gradlew publishToMavenLocal
popd || exit

version=0.0.5

for file in $(find ~/.m2/repository/ca/rmen/gnucobol-android/${version}/* -type f -not -name maven-metadata-local.xml); do
  gpg --local-user "${gpgkey}" -ab "${file}"
  md5 -q "${file}" > "${file}".md5
  for algo in 1 256 512; do
    shasum -a "${algo}" "${file}" | awk '{ print $1 }' > "${file}.sha${algo}"
  done
done

output_dir="$(mktemp -d)"
pushd "${HOME}/.m2/repository" || exit
publish_content_dir="ca/rmen/gnucobol-android/${version}"

# Create a bundle containing everything (jar, asc, pom files, and all their md5 and sha corresponding files).
artifact="${output_dir}/gnucobol-${version}.jar"
jar cfM "${artifact}" "${publish_content_dir}"/gnucobol-android*
popd || exit
echo "Publishable artifact: ${artifact}"
