#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
source "${script_dir}/ndk_env.sh"

deps_dir="deps"
mkdir -p "${deps_dir}"
pushd "${deps_dir}" || exit
prefix="${PREFIX_ROOT:-$HOME/.local/cobol-android}"
mkdir -p "${prefix}"
prefix="$(realpath "${prefix}")"

if [ ! -d libdb ]; then
    git clone https://github.com/berkeleydb/libdb.git
fi


pushd libdb/build_unix || exit

curl -o ../dist/config.sub 'https://cgit.git.savannah.gnu.org/cgit/config.git/plain/config.sub'
curl -o ../dist/config.guess 'https://cgit.git.savannah.gnu.org/cgit/config.git/plain/config.guess'
chmod +x ../dist/config.sub ../dist/config.guess

../dist/configure \
  --prefix="${prefix}" \
  --host=aarch64-linux-android \
  --disable-tcl \
  --disable-test \
  --enable-sequences \
  --disable-dbm \
  --disable-java \
  --disable-sql \
  --disable-static \
  --disable-shared \
  --disable-cxx \
  --with-mutex=POSIX/pthreads \
  CC="${CLANG}" \
  CFLAGS="-fPIC"

make
make install
make clean

popd || exit
rm -rf libdb
popd || exit