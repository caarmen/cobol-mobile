#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
source "${script_dir}/ndk_env.sh"

gmp_version="6.3.0"
deps_dir="deps"

prefix="${PREFIX_ROOT:-$HOME/.local/cobol-android}"
mkdir -p "${prefix}"
prefix="$(realpath "${prefix}")"

mkdir -p "${deps_dir}"
pushd "${deps_dir}" || exit

# Get gmp sources
if [ ! -d gmp ]; then
    curl "https://ftp.gnu.org/gnu/gmp/gmp-${gmp_version}.tar.gz" --output gmp.tar.gz
    tar xzf "gmp.tar.gz"
    rm "gmp.tar.gz"
    mv "gmp-${gmp_version}" gmp
fi

pushd gmp || exit

./configure \
  --prefix="${prefix}" \
  --host=aarch64-linux-android \
  --disable-shared \
  --disable-assembly \
  CC="${CLANG}" \
  CFLAGS="-fPIC"

make
make install
make clean


popd || exit
rm -rf gmp
popd || exit
