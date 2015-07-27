@echo off

set "Package_RootDir=%~dp0"
if %Package_RootDir:~-1%==\ set "Package_RootDir=%Package_RootDir:~0,-1%"

rem ==========
rem import global config
rem ==========

call "%Package_RootDir%\..\common\config.bat" %*

if %errorlevel% neq 0 exit /b %errorlevel%

set "Package_Name=bullet3"
set "Package_Version=2.83.5"
set "Package_PathPrefix=%Package_RootDir%\%Package_Name%-%Package_Version%"
set "Package_PlatformToolsetName=%Package_Platform%.%Package_Toolset%"
set "Package_PlatformToolsetPath=%Package_Platform%\%Package_Toolset%"
set "Package_SrcDir=%Package_PathPrefix%-src"
set "Package_OutDir=%Package_PathPrefix%"
set "Package_BuildDir=%Package_PathPrefix%-build.%Package_PlatformToolsetName%"
set "Package_BuildPrjDir=%Package_BuildDir%\prj"
set "Package_BuildLibDir=%Package_BuildDir%\lib\%Package_PlatformToolsetPath%"
set "Package_BuildBinDir=%Package_BuildDir%\bin\%Package_PlatformToolsetPath%"
set "Package_BuildLogDir=%Package_BuildDir%\logs"
set "Package_BuildProject=%Package_BuildPrjDir%\BULLET_PHYSICS.sln"