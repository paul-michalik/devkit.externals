@echo off

rem ===========
rem Global settings for all projects. Either set here or via command line parameter.
rem ===========

set "Package_Platform=x64"
set "Package_Toolset=v120"
set "Package_CleanBuild=No"
set "Package_CMakeExe=C:\Program Files (x86)\CMake\bin\cmake.exe"
set "Package_MSBuildExe=C:\Program Files (x86)\MSBuild\12.0\Bin\MSBuild.exe"
set "Package_DeployDir=\Software"
