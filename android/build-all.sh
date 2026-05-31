#!/usr/bin/env bash

set -e

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
"${script_dir}/build-gmp.sh"
"${script_dir}/build-libdb.sh"
"${script_dir}/build-gnucobol.sh"