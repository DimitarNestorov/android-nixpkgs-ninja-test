#!/bin/bash

set -euxo pipefail

if [ -z "${IN_PROJECT_DEV_SHELL:-}" ]; then
    echo "⚠️ Not in a Nix environment. Re-executing inside 'nix develop'..."
    exec nix develop --command bash "$0" "$@"
fi

NINJA=$ANDROID_HOME/cmake/3.22.1/bin/ninja

file "$NINJA"
"$NINJA" --version

CMAKE=$ANDROID_HOME/cmake/3.22.1/bin/cmake

file "$CMAKE"
"$CMAKE" --version

CPACK=$ANDROID_HOME/cmake/3.22.1/bin/cpack

file "$CPACK"
"$CPACK" --version

CTEST=$ANDROID_HOME/cmake/3.22.1/bin/ctest

file "$CTEST"
"$CTEST" --version
