@echo off

set "Package_CMake_Generator="

if "%Package_Toolset%"=="v110" (
    set "Package_CMake_Generator=Visual Studio 11 2012"
)

if "%Package_Toolset%"=="v120" (
    set "Package_CMake_Generator=Visual Studio 12 2013"
)

if "%Package_Toolset%"=="v130" (
    set "Package_CMake_Generator=Visual Studio 14 2015"
)

if "%Package_Platform%"=="x86" (
    set "Package_CMake_Generator=%Package_CMake_Generator%"
)

if "%Package_Platform%"=="x64" (
    set "Package_CMake_Generator=%Package_CMake_Generator% Win64"
)