@echo off

call build.bat %*

setlocal

rem ============
rem Copy artifacts of use from Package_BuildDir, Package_SrcDir into Package_OutDir
rem ============

set "Package_SrcOutDir=%Package_OutDir%\src"

if exist "%Package_SrcOutDir%" (
    if /i "%Package_CleanInstall%"=="Yes" (
        echo Performing clean install, removing %Package_SrcOutDir%

        rd /s /q "%Package_SrcOutDir%"
    )
)

set "Package_BinOutDir=%Package_OutDir%\%Package_PlatformToolsetName%"

if exist "%Package_BinOutDir%" (
    if /i "%Package_CleanInstall%"=="Yes" (
        echo Performing clean install, removing %Package_BinOutDir%

        rd /s /q "%Package_BinOutDir%"
    )
)

set "Package_SrcItemPattern=*.h *.hpp *.c *.cpp *.inl"
set "Package_LibItemPattern=*.lib *.pdb"
set "Package_BinItemPattern=*.exe *.dll"
set "Package_ExcludeDirsPattern=CMakeFiles"

rem ============
rem Source items
rem ============

robocopy "%Package_SrcDir%" "%Package_SrcOutDir%" %Package_SrcItemPattern% /s /xj /xd "%Package_ExcludeDirsPattern%"

rem ============
rem Source items
rem ============

robocopy "%Package_BuildDir%" "%Package_BinOutDir%" %Package_LibItemPattern% %Package_BinItemPattern% /s /xj /xd "%Package_ExcludeDirsPattern%"

endlocal