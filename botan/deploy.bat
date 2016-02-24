@echo off

call install.bat %*

if %errorlevel% neq 0 exit /b %errorlevel%

setlocal


endlocal