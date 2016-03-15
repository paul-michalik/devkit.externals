@echo off

call build.bat %*

if %errorlevel% neq 0 exit /b %errorlevel%

setlocal

rem ============
rem Copy artifacts of use from Package_BuildDir, Package_SrcDir into Package_OutDir
rem ============

set "Package_SrcOutDir=%Package_OutDir%\src"
set "Package_BinOutDir=%Package_OutDir%\targets"
set "Package_BuildOutDir=%Package_OutDir%\build"

set "Package_SrcItemPattern=*.h *.hpp *.c *.cpp *.inl"
set "Package_LibItemPattern=*.lib *.pdb"
set "Package_BinItemPattern=*.exe *.dll"
set "Package_ExcludeDirsPattern=CMakeFiles"
set "Package_ExcludeFilePattern=cmtrycompileexec*"

if exist "%Package_SrcOutDir%" (
    echo Removing %Package_SrcOutDir%...
    rmdir /s /q "%Package_SrcOutDir%"
)

rem ============
rem Public API headers
rem ============

robocopy "%Package_BuildDir%.debug\botan" "%Package_SrcOutDir%" %Package_SrcItemPattern% /purge /s /xj /xd "%Package_ExcludeDirsPattern%" /xf "%Package_ExcludeFilePattern%"

rem ============
rem Build items
rem ============

robocopy "%Package_RootDir%" "%Package_BuildOutDir%" *.cmake /purge /s /xj /xd /xf

rem ============
rem Binary items
rem ============

if exist "%Package_BinOutDir%" (
    echo Removing %Package_BinOutDir%...
    rmdir /s /q "%Package_BinOutDir%"
)

rem ============
rem Debug
rem ============
robocopy "%Package_BuildDir%.debug\botan" "%Package_BinOutDir%\%Package_PlatformToolsetName%.Debug" %Package_LibItemPattern% %Package_BinItemPattern% /s /xj /xd "%Package_ExcludeDirsPattern%" /xf "%Package_ExcludeFilePattern%"

rem ============
rem Release
rem ============
robocopy "%Package_BuildDir%.release\botan" "%Package_BinOutDir%\%Package_PlatformToolsetName%.Release" %Package_LibItemPattern% %Package_BinItemPattern% /s /xj /xd "%Package_ExcludeDirsPattern%" /xf "%Package_ExcludeFilePattern%"

endlocal