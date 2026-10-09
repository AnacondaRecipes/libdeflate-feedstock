#!/bin/bash
set -eoux pipefail

cmake -B build -S . -GNinja ${CMAKE_ARGS} \
  -DLIBDEFLATE_BUILD_TESTS=ON \
  -DLIBDEFLATE_BUILD_STATIC_LIB=OFF \
  -DCMAKE_INSTALL_PREFIX=${PREFIX}

cmake --build build --config Release
ctest --test-dir build --output-on-failure
cmake --build build --target install --config Release
