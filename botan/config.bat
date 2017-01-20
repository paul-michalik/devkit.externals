@echo off

set "Package_RootDir=%~dp0"
if %Package_RootDir:~-1%==\ set "Package_RootDir=%Package_RootDir:~0,-1%"

rem ==========
rem import global config
rem ==========

call "%Package_RootDir%\..\common\config.bat" %*

if %errorlevel% neq 0 exit /b %errorlevel%

set "Package_Name=botan"
set "Package_Version=1.10"
set "Package_PathPrefix=%Package_RootDir%\src\%Package_Name%\%Package_Name%-%Package_Version%"
set "Package_PlatformToolsetName=%Package_Platform%.%Package_Toolset%"
set "Package_PlatformToolsetPath=%Package_Platform%\%Package_Toolset%"
set "Package_SrcDir=%Package_PathPrefix%-src"
set "Package_OutDir=%Package_DeployDir%\%Package_Name%\%Package_Name%-%Package_Version%"
set "Package_BuildDir=%Package_PathPrefix%-build.%Package_PlatformToolsetName%"
set "Package_BuildPrjDir=%Package_BuildDir%\prj"
set "Package_BuildLibDir=%Package_BuildDir%\lib"
set "Package_BuildBinDir=%Package_BuildDir%\bin"
set "Package_BuildLogDir=%Package_BuildDir%\logs"
set "Package_PythonDir=C:\Python35-32"

rem set "Package_BuildProject=%Package_BuildPrjDir%\Botan.sln"