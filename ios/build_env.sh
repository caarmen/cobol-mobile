#!/usr/bin/env bash

export HOST="${HOST:-arm64-apple-ios}"
sysroot="$(xcrun --sdk "${SDK:-iphoneos}" --show-sdk-path)"
CLANG="$(xcrun --find clang)"
export CFLAGS="-arch ${ARCH:-arm64} -target ${TARGET:-arm64-apple-ios} --sysroot=${sysroot} -fPIC"
export PREFIX_ROOT="${HOME}/.local/cobol-ios-${TARGET}"

export CLANG
