cmake %CMAKE_ARGS% -G "NMake Makefiles" ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D BUILD_SHARED_LIBS=ON ^
    -D PCRE_SUPPORT_UTF=ON ^
    -D PCRE_SUPPORT_UNICODE_PROPERTIES=ON ^
    -D CMAKE_DISABLE_FIND_PACKAGE_BZip2=ON ^
    -D CMAKE_DISABLE_FIND_PACKAGE_ZLIB=ON ^
    -D CMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    --trace --debug-output --debug-trycompile ^
    .
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

:: pcre_test_bat fails to run for some reason
:: might need more investigation
if not "%CONDA_BUILD_SKIP_TESTS%"=="1" (
ctest -E pcre_test_bat .
)
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
