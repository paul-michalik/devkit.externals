@echo off

rem ================================================
rem === Calculate the location of visual studio install,
rem === the location of vcvarsall.bat script and the arguments
rem === required to pass to vcvarsall.bat based on required
rem === package platform and tool-set
rem ================================================
rem [in] Parameters:
rem %1: Package_Platform
rem %2: Package_Toolset

rem [out] Parameters:
rem %1: Package_VisualStudioDir
rem %2: Package_VcVarsAllPath
rem %3: Package_VcVarsAllArgs

setlocal
set "Loc_Platform=%~1"
set "Loc_Toolset=%~2"
set "Loc_VisualStudioDir=The ID string "%Loc_Platform%.%Loc_Toolset%" does not yield a supported Visual Studio version"
set "Loc_VcVarsAllPath=The ID string "%Loc_Platform%.%Loc_Toolset%" does not yield a supported Visual Studio version"
set "Loc_VcVarsAllArgs="

rem
rem Visual Studio:
rem
if "%Loc_Toolset%"=="v100" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 10.0"
)

if "%Loc_Toolset%"=="v110" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 11.0"
)

if "%Loc_Toolset%"=="v120" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 12.0"
)

if "%Loc_Toolset%"=="v140" (
    set "Loc_VisualStudioDir=%ProgramFiles(x86)%\Microsoft Visual Studio 14.0"
)

set "Loc_VcVarsAllPath=%Loc_VisualStudioDir%\VC\vcvarsall.bat"

rem
rem Platform:
rem
if "%Loc_Platform%"=="x64" (
    set "Loc_VcVarsAllArgs=amd64"
)

if "%Loc_Platform%"=="x86" (
    set "Loc_VcVarsAllArgs=x86"
)

endlocal & set "Package_VisualStudioDir=%Loc_VisualStudioDir%" & set "Package_VcVarsAllPath=%Loc_VcVarsAllPath%" & set "Package_VcVarsAllArgs=%Loc_VcVarsAllArgs%"