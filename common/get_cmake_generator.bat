@echo off

rem ================================================
rem === Map input parameters to cmake generator
rem ================================================

rem [in] Parameters:
rem %1: Package_Generator: [msbuild, nmake, jom]
rem %2: Package_Platform: [x86, x64]
rem %3: Package_Toolset: [v100, v110, v120, v140]

rem [out] Parameters:
rem %1: Package_CMake_Generator: [Visual Studio 10 2010, ..., NMake Makefiles, NMake Makefiles JOM, ...] 

setlocal
set "Loc_Package_Generator=%~1"
set "Loc_CMake_Generator=The ID string "%Loc_Package_Generator%.%Loc_Platform%.%Loc_Toolset%" does not yield a supported CMake generator."
set "Loc_CMake_GeneratorArgs="

if "%Loc_Package_Generator%"=="msbuild" (
    rem
    rem Generator:
    rem
    if "%Loc_Toolset%"=="v100" (
        set "Loc_CMake_Generator=Visual Studio 10 2010"
    )

    if "%Loc_Toolset%"=="v110" (
        set "Loc_CMake_Generator=Visual Studio 11 2012"
    )

    if "%Loc_Toolset%"=="v120" (
        set "Loc_CMake_Generator=Visual Studio 12 2013"
    )

    if "%Loc_Toolset%"=="v140" (
        set "Loc_CMake_Generator=Visual Studio 14 2015"
    )

    if "%Loc_Platform%"=="x86" (
        set "Loc_CMake_GeneratorArgs="
    )

    if "%Loc_Platform%"=="x64" (
        set "Loc_CMake_GeneratorArgs=Win64"
    )
)

rem Compose (=> DelayedExpansion)
set "Loc_CMake_Generator=%Loc_CMake_Generator% %Loc_CMake_GeneratorArgs%"

if "%Loc_Package_Generator%"=="nmake" (
    set "Loc_CMake_Generator=NMake Makefiles"
)

if "%Loc_Package_Generator%"=="jom" (
    set "Loc_CMake_Generator=NMake Makefiles JOM"
)

endlocal & set "Package_CMake_Generator=%Loc_CMake_Generator%"