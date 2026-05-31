#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
source "${script_dir}/ndk_env.sh"

project_path="$(pwd)"
gnucobol_version="3.2"
deps_dir="$(realpath "${project_path}/deps")"
mkdir -p "${deps_dir}"
pushd "${deps_dir}" || exit
prefix_root="${PREFIX_ROOT:-$HOME/.local/cobol-android}"
mkdir -p "${prefix_root}"
prefix_root="$(realpath "${prefix_root}")"

if [ ! -d gnucobol-android ]; then
    curl "https://ftp.gnu.org/gnu/gnucobol/gnucobol-${gnucobol_version}.tar.gz" --output gnucobol.tar.gz
    tar xzf "gnucobol.tar.gz"
    rm "gnucobol.tar.gz"
    mv "gnucobol-${gnucobol_version}" gnucobol-android
fi

# Build libcob

pushd gnucobol-android || exit

./configure \
    --host=aarch64-linux-android \
    --prefix="${prefix_root}" \
    --disable-shared \
    LDFLAGS="-L${prefix_root}/lib" \
    CPPFLAGS="-I${prefix_root}/include/" \
    CC="${CLANG}" \
    CFLAGS="-fPIC"

# Make the libcob.a file.
make SUBDIRS="libcob"

# Make the libcob.so file which contains all
# the symbols from libcob.a and dependencies
# gmp and db:
"${CLANG}" -shared -fPIC \
  -Wl,--whole-archive \
  libcob/.libs/libcob.a \
  "${prefix_root}/lib/libgmp.a" \
  "${prefix_root}/lib/libdb.a" \
  -Wl,--no-whole-archive \
  -o libcob/.libs/libcob.so

make install SUBDIRS="libcob"

# Copy the libcob.so file
cp libcob/.libs/libcob.so "${prefix_root}/lib/libcob.so"

make clean SUBDIRS="libcob"

popd || exit
rm -rf gnucobol-android
popd || exit