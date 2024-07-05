cmake -LAH -G Ninja -S . -B build ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%
cmake --build build --target install --parallel %CPU_COUNT%

:: pushd build
::  ctest -C Debug --output-on-failure
:: popd

pushd build
  ::cmake --build . --config Release --target install
  move %LIBRARY_PREFIX%\lib\Release\uv.lib %LIBRARY_PREFIX%\lib\uv.lib
  move %LIBRARY_PREFIX%\lib\Release\uv_a.lib %LIBRARY_PREFIX%\lib\uv_a.lib
  move %LIBRARY_PREFIX%\lib\Release\uv.dll %LIBRARY_BIN%\uv.dll
  rmdir /s /q %LIBRARY_PREFIX%\lib\Release
popd
