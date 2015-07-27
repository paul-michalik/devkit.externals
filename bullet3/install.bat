@echo off

call build.bat %*

if %errorlevel% neq 0 exit /b %errorlevel%

setlocal

rem ============
rem Copy artifacts of use from Package_BuildDir, Package_SrcDir into Package_OutDir
rem ============

set "Package_SrcOutDir=%Package_OutDir%\src"
set "Package_BinOutDir=%Package_OutDir%\targets"

set "Package_SrcItemPattern=*.h *.hpp *.c *.cpp *.inl"
set "Package_LibItemPattern=*.lib *.pdb"
set "Package_BinItemPattern=*.exe *.dll"
set "Package_ExcludeDirsPattern=CMakeFiles"
set "Package_ExcludeFilePattern=cmtrycompileexec*"

rem ============
rem Source items. The /purge option should purge items from target, so no need to delete manually.
rem ============

robocopy "%Package_SrcDir%" "%Package_SrcOutDir%" %Package_SrcItemPattern% /purge /s /xj /xd "%Package_ExcludeDirsPattern%" /xf "%Package_ExcludeFilePattern%"

rem ============
rem Binary items
rem ============

robocopy "%Package_BuildDir%" "%Package_BinOutDir%" %Package_LibItemPattern% %Package_BinItemPattern% /s /xj /xd "%Package_ExcludeDirsPattern%" /xf "%Package_ExcludeFilePattern%"

endlocal