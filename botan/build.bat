@echo off

call config.bat %*
if errorlevel 1 cmd /k echo Error %errorlevel% occurred in %0 & goto :eof

setlocal

rem =========================
rem === Locate VS and msvc bootstrap script and setup the msvc environment!
rem =========================

set "Package_VisualStudioDir="
set "Package_VcVarsAllPath="
set "Package_VcVarsAllArgs="

call "%Package_RootDir%\..\common\locate_vcvarsall.bat" %Package_Platform% %Package_Toolset% %*
if errorlevel 1 cmd /k echo Error in %0: call "%Package_RootDir%\..\common\locate_vcvarsall.bat" %Package_Platform% %Package_Toolset% %* failed & goto :eof

echo calling "%Package_VcVarsAllPath%" %Package_VcVarsAllArgs%
call "%Package_VcVarsAllPath%" %Package_VcVarsAllArgs%
echo found:
where cl
where link
where lib
if errorlevel 1 cmd /k echo Error in %0: call "%Package_VcVarsAllPath%" %Package_VcVarsAllArgs% failed & goto :eof

rem =========================
rem === Botan specific options based on configure.py --help
rem =========================

set "PATH=%Package_PythonDir%;%PATH%"

set "Package_Configure_CmdLine=configure.py --verbose"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --os=windows
if /i "%Package_Platform%"=="x86" set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --cpu=i386
if /i "%Package_Platform%"=="x64" set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --cpu=x86_64
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --cc=msvc"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --cc-bin=cl.exe"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --with-tr1-implementation=none"
set "Package_Configure_CmdLine=%Package_Configure_CmdLine% --makefile-style=nmake"

rem ===
rem debug and release builds
rem ===

setlocal EnableDelayedExpansion
for %%A in (debug,release) do (
    set "CmdLine=%Package_Configure_CmdLine%"
    set "CmdLine=!CmdLine! --with-build-dir="%Package_BuildDir%.%%A""
    set "CmdLine=!CmdLine! --prefix="%Package_BuildDir%.%%A\botan""
    set "CmdLine=!CmdLine! --libdir=lib"
    set "CmdLine=!CmdLine! --includedir=include"
    if /i "%%A"=="debug" set "CmdLine=!CmdLine! --enable-debug"

    rem =========================
    rem Clean up:
    rem =========================
    echo checking %Package_BuildDir%.%%A...
    if exist "%Package_BuildDir%.%%A" (
        if /i "%Package_CleanBuild%"=="Yes" (
            echo Performing clean build, removing %Package_BuildDir%.%%A...
            rmdir /s /q "%Package_BuildDir%.%%A"
        )
    )
    if errorlevel 1 cmd /k echo Error %errorlevel% occurred in %0 & goto :eof

    rem =========================
    rem Configure:
    rem =========================
    echo checking %Package_SrcDir%...
    if exist "%Package_SrcDir%" (
        cd "%Package_SrcDir%"
        echo executing: & echo !CmdLine!...
        !CmdLine! > configure-botan.%%A.log.txt
    )
    if errorlevel 1 cmd /k echo Error %errorlevel% occurred in %0 & goto :eof

    rem =========================
    rem Build:
    rem =========================
    echo checking %Package_BuildDir%.%%A...
    if exist "%Package_BuildDir%.%%A" (
        cd /d "%Package_BuildDir%.%%A"
        echo executing: nmake install in !cd!...
        nmake install > build.log.txt
    )
    if errorlevel 1 cmd /k echo Error %errorlevel% occurred in %0 & goto :eof

    echo.
)
endlocal

endlocal