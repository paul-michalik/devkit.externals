@echo off

call config.bat %*

setlocal

call "%Package_RootDir%\..\common\package_cmake_generator.bat" %*

rem =========================
rem Bullet specific options
rem =========================

set "Package_CMake_CmdLine=-DBUILD_UNIT_TESTS:BOOL="0" -DBUILD_BULLET2_DEMOS:BOOL="0" -DCMAKE_DEBUG_POSTFIX:STRING="" -DBUILD_BULLET3:BOOL="1" -DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL="1" -DUSE_DOUBLE_PRECISION:BOOL="1" -DCMAKE_BACKWARDS_COMPATIBILITY:STRING="3.2" -DBUILD_OPENGL3_DEMOS:BOOL="0""

rem =========================
rem CXX and C compiler flags
rem Changes: 
rem 1. pdb deployed along with libs
rem 2. create debug info for Release configuration 
rem =========================

set "Package_CMake_CmdLine=%Package_CMake_CmdLine% -DCMAKE_CXX_FLAGS:STRING="/DWIN32 /D_WINDOWS /W3 /GR /EHsc /Fd"%Package_BuildLibDir%\$(Configuration)\$(ProjectName).pdb"""
set "Package_CMake_CmdLine=%Package_CMake_CmdLine% -DCMAKE_CXX_FLAGS_RELEASE:STRING="/MD /Zi /O2 /Ob2 /D NDEBUG"%"
set "Package_CMake_CmdLine=%Package_CMake_CmdLine% -DCMAKE_C_FLAGS_RELEASE:STRING="/MD /Zi /O2 /Ob2 /D NDEBUG"%"

rem =========================
rem Output folders
rem =========================
set "Package_CMake_CmdLine=%Package_CMake_CmdLine% -DEXECUTABLE_OUTPUT_PATH:PATH="%Package_BuildBinDir%""
set "Package_CMake_CmdLine=%Package_CMake_CmdLine% -DLIBRARY_OUTPUT_PATH:PATH="%Package_BuildLibDir%""
rem =========================
rem Generator
rem =========================
set "Package_CMake_CmdLine=%Package_CMake_CmdLine% -G "%Package_CMake_Generator%""

rem =========================
rem Create build dir, change into it and call that fucking cmake....
rem =========================

if exist "%Package_BuildDir%" (
    if /i "%Package_CleanBuild%"=="Yes" (
        del /s /q "%Package_BuildDir%"
        rd /s /q "%Package_BuildDir%"
    )
)

if not exist "%Package_BuildDir%" md "%Package_BuildDir%"

cd "%Package_BuildDir%"

rem =========================
rem Create build-log dir
rem =========================

if exist "%Package_BuildLogDir%" (
    if /i "%Package_CleanBuild%"=="Yes" (
        del /s /q "%Package_BuildLogDir%"
        rd /s /q "%Package_BuildLogDir%"
    )
)

if not exist "%Package_BuildLogDir%" md "%Package_BuildLogDir%"

rem ===========
rem Run CMake
rem ===========

"%Package_CMakeExe%" %Package_CMake_CmdLine% "%Package_SrcDir%"

rem ===========
rem Create setting dependent path prefix 
rem ===========

rem ===========
rem Run MSBuild for Debug and Release configurations
rem ===========

set "Package_Config=Debug"
"%Package_MSBuildExe%" /m /noconsolelogger /v:diagnostic /t:Build /l:FileLogger,Microsoft.Build.Engine;logfile="%Package_BuildLogDir%\%Package_Config%.log.txt" /p:Configuration="%Package_Config%" "%Package_BuildProject%"

dir /b "%Package_BuildLibDir%\%Package_Config%\*.lib" > "%Package_BuildLogDir%\%Package_Config%.targets.txt"

set "Package_Config=Release"
"%Package_MSBuildExe%" /m /noconsolelogger /v:diagnostic /t:Build /l:FileLogger,Microsoft.Build.Engine;logfile="%Package_BuildLogDir%\%Package_Config%.log.txt" /p:Configuration="%Package_Config%" "%Package_BuildProject%"

dir /b "%Package_BuildLibDir%\%Package_Config%\*.lib" > "%Package_BuildLogDir%\%Package_Config%.targets.txt"

exit /b %errorlevel%

endlocal