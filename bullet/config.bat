@echo off

set "Package_RootDir=%~dp0"
if %Package_RootDir:~-1%==\ SET Package_RootDir=%Package_RootDir:~0,-1%

set "Package_Name=bullet"
set "Package_Version=2.83.5"
set "Package_SrcDir=%Package_RootDir%\%Package_Name%-%Package_Version%-src"
set "Package_Platform=x86"
set "Package_Toolset=v120"
set "Package_OutDir=%Package_RootDir%\%Package_Name%-%Package_Version%.%Package_Platform%.%Package_Toolset%"
set "Package_Project=%Package_OutDir%\BULLET_PHYSICS.sln"
set "Package_CMakeExe=C:\Program Files (x86)\CMake\bin\cmake.exe"