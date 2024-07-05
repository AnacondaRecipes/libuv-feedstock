echo ON

cmake -LAH -G Ninja -S . -B build ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%
cmake --build build --target install --parallel %CPU_COUNT%
