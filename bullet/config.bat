@echo off

set "Package_RootDir=%~dp0"
if %Package_RootDir:~-1%==\ set "Package_RootDir=%Package_RootDir:~0,-1%"

rem ==========
rem import global config
rem ==========

call "%Package_RootDir%\..\common\config.bat" %*

set "Package_Name=bullet"
set "Package_Version=2.83.5"
set "Package_PathPrefix=%Package_RootDir%\%Package_Name%-%Package_Version%"
set "Package_PlatformToolsetName=%Package_Platform%.%Package_Toolset%"
set "Package_SrcDir=%Package_PathPrefix%-src"
set "Package_OutDir=%Package_PathPrefix%"
set "Package_BuildDir=%Package_PathPrefix%-build\%Package_PlatformToolsetName%"
set "Package_BuildLibDir=%Package_BuildDir%\lib"
set "Package_BuildBinDir=%Package_BuildDir%\bin"
set "Package_BuildLogDir=%Package_PathPrefix%-build-logs\%Package_PlatformToolsetName%"
set "Package_BuildProject=%Package_BuildDir%\BULLET_PHYSICS.sln"