#!/usr/bin/env bash

if [ -z "${ANDROID_NDK_HOME}" ]; then
    echo "ANDROID_NDK_HOME" is not defined
    return 1
fi

case "$(uname -s)-$(uname -m)" in
  Linux-x86_64)   HOST_TAG=linux-x86_64 ;;
  Darwin-x86_64)  HOST_TAG=darwin-x86_64 ;;
  Darwin-arm64)   HOST_TAG=darwin-x86_64 ;;
  *)              echo "Unsupported host"; return 1 ;;
esac

export TOOLCHAIN="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/${HOST_TAG}"
