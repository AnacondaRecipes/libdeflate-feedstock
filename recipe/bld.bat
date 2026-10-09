@echo on

cmake -LAH -B build -S . -G "Ninja"       ^
  %CMAKE_ARGS%                            ^
  -DLIBDEFLATE_BUILD_TESTS=ON             ^
  -DLIBDEFLATE_BUILD_STATIC_LIB=OFF       ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%
if errorlevel 1 exit 1

cmake --build build --config Release
if errorlevel 1 exit 1

REM needed for .dll resolution during testing
set "PATH=%SRC_DIR%\build;%PATH%"
ctest --test-dir build --output-on-failure
if errorlevel 1 exit 1

cmake --build build --target install --config Release
if errorlevel 1 exit 1
