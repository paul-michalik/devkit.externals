@echo off

call config.bat %*

if %errorlevel% neq 0 exit /b %errorlevel%

setlocal

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

endlocal