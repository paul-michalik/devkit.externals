@echo off

call config.bat

setlocal

set "Package_CMake_DCMAKE_CXXFLAGS=-DCMAKE_CXX_FLAGS:STRING="/Fd"%Package_OutDir%/lib/$(ProjectName).pdb"""

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

set "Package_CMake_CmdLine=-DLIBRARY_OUTPUT_PATH:PATH="%Package_OutDir%/lib" -DBUILD_UNIT_TESTS:BOOL="0" -DBUILD_BULLET2_DEMOS:BOOL="0" -DBUILD_EXTRAS:BOOL="0" -DBUILD_BULLET3:BOOL="0" -DCMAKE_CONFIGURATION_TYPES:STRING="Debug;Release;MinSizeRel;RelWithDebInfo" -DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL="1" -DUSE_DOUBLE_PRECISION:BOOL="1" -DBUILD_CPU_DEMOS:BOOL="0" -DCMAKE_BACKWARDS_COMPATIBILITY:STRING="3.2" -DBUILD_OPENGL3_DEMOS:BOOL="0""

set "Package_CMake_CmdLine=%Package_CMake_CmdLine% %Package_CMake_DCMAKE_CXXFLAGS% -G "%Package_CMake_Generator%""

rem =========================
rem Create build dir, apparently you can't pass to cmake via command line. Change into it and call that fucking cmake...
rem =========================

if not exist "%Package_OutDir%" md "%Package_OutDir%"

cd "%Package_OutDir%"

"%Package_CMakeExe%" %Package_CMake_CmdLine% "%Package_SrcDir%"

set "Package_MSBuildExe=C:\Program Files (x86)\MSBuild\12.0\Bin\MSBuild.exe"
set "Package_MSBuildLogFile=%Package_RootDir%\%Package_Name%-%Package_Version%.%Package_Platform%.%Package_Toolset%.log.txt"

"%Package_MSBuildExe%" /m /noconsolelogger /v:diagnostic /t:Build /l:FileLogger,Microsoft.Build.Engine;logfile="%Package_MSBuildLogFile%" "%Package_Project%"

endlocal