#!/usr/bin/env bash

set -e

if (( "$#" != 1 )); then
  echo "Usage: $0 <gpgkey>"
  exit 1
else
  gpgkey=$1
fi

# To sign the package, use the following command to find the name of your gpg key:
# gpg --list-signatures --keyid-format 0xshort
# The name of the key is the first token after "sig 3".
# See https://central.sonatype.org/publish/requirements/gpg/#listing-keys for more info.
# Set the environment variable GPGKEY to the name of the key to use.
for file in $(find ~/.m2/repository/ca/rmen/gnucobol-kmp* -type f -not -name maven-metadata-local.xml); do
  gpg --local-user "${gpgkey}" -ab "${file}"
  md5 -q "${file}" > "${file}".md5
  for algo in 1 256 512; do
    shasum -a "${algo}" "${file}" | awk '{ print $1 }' > "${file}.sha${algo}"
  done
done