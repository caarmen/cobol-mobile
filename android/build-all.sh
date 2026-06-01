#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
source "${script_dir}/ndk_env.sh"

for target in aarch64-linux-android x86_64-linux-android; do
    echo "Building for target ${target}"
    export HOST="${target}"
    export CLANG="${TOOLCHAIN}/bin/${target}36-clang"
    export PREFIX_ROOT="${HOME}/.local/cobol-android-${target}"
    "${script_dir}/build-gmp.sh"
    "${script_dir}/build-libdb.sh"
    "${script_dir}/build-gnucobol.sh"
done

"${script_dir}/package.sh"
