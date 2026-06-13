#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
source "${script_dir}/build_env.sh"
patch_dir="${script_dir}/patches/gnucobol"

project_path="$(pwd)"
gnucobol_version="3.2"
deps_dir="$(realpath "${project_path}/deps")"
mkdir -p "${deps_dir}"
pushd "${deps_dir}" || exit
prefix_root="${PREFIX_ROOT:-$HOME/.local/cobol-ios}"
mkdir -p "${prefix_root}"
prefix_root="$(realpath "${prefix_root}")"

if [ ! -d gnucobol-ios ]; then
    curl "https://ftp.gnu.org/gnu/gnucobol/gnucobol-${gnucobol_version}.tar.gz" --output gnucobol.tar.gz
    tar xzf "gnucobol.tar.gz"
    rm "gnucobol.tar.gz"
    mv "gnucobol-${gnucobol_version}" gnucobol-ios
fi

# Build libcob

pushd gnucobol-ios || exit

./configure \
    --host="${HOST:-arm64-apple-ios}" \
    --prefix="${prefix_root}" \
    --disable-shared \
    LDFLAGS="-L${prefix_root}/lib" \
    CPPFLAGS="-I${prefix_root}/include/" \
    CC="${CLANG}" \
    CFLAGS="${CFLAGS} -include ${patch_dir}/ios_compat.h"

# Make the libcob.a file.
make SUBDIRS="libcob"

make install SUBDIRS="libcob"

# Make the libcob-all.a file which contains all
# the symbols from libcob.a and dependencies
# gmp and db:
xcrun libtool -static \
  "${prefix_root}/lib/libcob.a" \
  "${prefix_root}/lib/libgmp.a" \
  "${prefix_root}/lib/libdb.a" \
  -o libcob/.libs/libcob-all.a

# Copy the libcob-all.a file
cp libcob/.libs/libcob-all.a "${prefix_root}/lib/libcob-all.a"

make clean SUBDIRS="libcob"

popd || exit
rm -rf gnucobol-ios
popd || exit