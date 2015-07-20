@echo off

call config.bat

setlocal

set "Package_CMake_DCMAKE_CXXFLAGS=-DCMAKE_CXX_FLAGS:STRING="${CMAKE_CXXFLAGS} /Fd"%Package_OutDir%/lib/$(ProjectName).pdb"""

set "Package_CMake_Generator="

if "%Package_Toolset%"=="v110" (
    set "Package_CMake_Generator=%Package_CMake_Generator% Visual Studio 11 2012"
)

if "%Package_Toolset%"=="v120" (
    set "Package_CMake_Generator=%Package_CMake_Generator% Visual Studio 12 2013"
)

if "%Package_Toolset%"=="v130" (
    set "Package_CMake_Generator=%Package_CMake_Generator% Visual Studio 14 2015"
)

if "%Package_Platform%"=="x86" (
)

if "%Package_Platform%"=="x64" (
    set "Package_CMake_Generator=%Package_CMake_Generator% Win64"
)


set "Package_CMake_CmdLine=-DLIBRARY_OUTPUT_PATH:PATH="%Package_OutDir%/lib" -DBUILD_UNIT_TESTS:BOOL="0" -DBUILD_BULLET2_DEMOS:BOOL="0" -DBUILD_EXTRAS:BOOL="0" -DBUILD_BULLET3:BOOL="0" -DCMAKE_CONFIGURATION_TYPES:STRING="Debug;Release;MinSizeRel;RelWithDebInfo" -DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL="1" -DUSE_DOUBLE_PRECISION:BOOL="1" -DBUILD_CPU_DEMOS:BOOL="0" -DCMAKE_BACKWARDS_COMPATIBILITY:STRING="3.2" -DBUILD_OPENGL3_DEMOS:BOOL="0""

set "Package_CMake_CmdLine=%Package_CMake_CmdLine% %Package_CMake_DCMAKE_CXXFLAGS%"

endlocal