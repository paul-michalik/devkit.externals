@echo off

call config.bat %*

if %errorlevel% neq 0 exit /b %errorlevel%

setlocal

set "PATH=%Package_PythonDir%;%PATH%"

rem =========================
rem Botan specific options
rem =========================

set "Package_CMake_CmdLine=-DBUILD_UNIT_TESTS:BOOL="0" -DBUILD_BULLET2_DEMOS:BOOL="0" -DCMAKE_DEBUG_POSTFIX:STRING="" -DBUILD_BULLET3:BOOL="1" -DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL="1" -DUSE_DOUBLE_PRECISION:BOOL="1" -DCMAKE_BACKWARDS_COMPATIBILITY:STRING="3.2" -DBUILD_OPENGL3_DEMOS:BOOL="0""

rem =========================
rem CXX and C compiler flags
rem Changes: 
rem 1. PDBs deployed along with libs
rem 2. Create debug info for Release configuration 
rem 3. Switch off profiling
REM 4. Activate BULLET_TRIANGLE_COLLISION. Uses "gjk" instead "sat" which doesn't work...
rem =========================

set "Package_CMake_CmdLine=%Package_CMake_CmdLine% -DCMAKE_CXX_FLAGS:STRING="/DWIN32 /D_WINDOWS /W3 /GR /EHsc /DBT_NO_PROFILE /DBULLET_TRIANGLE_COLLISION /Fd"%Package_BuildLibDir%\$(Configuration)\$(TargetName).pdb"""
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
        echo Performing clean build, removing %Package_BuildDir%
        del /s /q "%Package_BuildDir%"
        rd /s /q "%Package_BuildDir%"
        if %errorlevel% neq 0 exit /b %errorlevel%
    )
)

if not exist "%Package_BuildPrjDir%" (
    echo Creating "%Package_BuildPrjDir%"...
    md "%Package_BuildPrjDir%"
)

cd "%Package_BuildPrjDir%"

rem ===========
rem Run CMake
rem ===========

"%Package_CMakeExe%" %Package_CMake_CmdLine% "%Package_SrcDir%"

rem =========================
rem Create build-log dir
rem =========================

if exist "%Package_BuildLogDir%" (
    if /i "%Package_CleanBuild%"=="Yes" (
        echo Performing clean build, removing %Package_BuildLogDir%
        del /s /q "%Package_BuildLogDir%"
        rd /s /q "%Package_BuildLogDir%"
        if %errorlevel% neq 0 exit /b %errorlevel%
    )
)

if not exist "%Package_BuildLogDir%" (
    echo Creating "%Package_BuildLogDir%"...
    md "%Package_BuildLogDir%"
)

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