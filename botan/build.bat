@echo off

call config.bat %*

if %errorlevel% neq 0 exit /b %errorlevel%

setlocal

set "PATH=%Package_PythonDir%;%PATH%"

rem =========================
rem Botan specific options based on configure.py --help
rem =========================

set "Package_Configure_CmdLine=configure.py --verbose"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --cc=msvc"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --cc-bin="
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --with-tr1-implementation=none"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --with-build-dir="%Package_BuildDir%""
rem set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --makefile-style=nmake"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --enable-debug"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --prefix="%Package_BuildDir%""
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --libdir="%Package_BuildDir%\lib""
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --includedir="%Package_BuildDir%\include""

rem =========================
rem Clean up:
rem =========================

if exist "%Package_BuildLogDir%" (
    if /i "%Package_CleanBuild%"=="Yes" (
        echo Performing clean build, removing %Package_BuildLogDir%
        del /s /q "%Package_BuildLogDir%"
        rd /s /q "%Package_BuildLogDir%"
        if %errorlevel% neq 0 exit /b %errorlevel%
    )
)

rem =========================
rem Configure:
rem =========================

if exist "%Package_SrcDir%" (
    cd "%Package_SrcDir%"
    echo calling... & echo %Package_Configure_CmdLine%
    %Package_Configure_CmdLine%
)

exit /b %errorlevel%

endlocal