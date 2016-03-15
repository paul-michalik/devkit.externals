@echo off

rem ================================================
rem === Global settings for all projects. Either set 
rem === here or via command line parameter.
rem ================================================

set "Package_Platform=x86"
set "Package_Toolset=v140"
set "Package_CleanBuild=Yes"
set "Package_CMakeExe=C:\Program Files (x86)\CMake\bin\cmake.exe"
set "Package_MSBuildExe=C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"
set "Package_DeployDir=%USERPROFILE%\Software"
