@echo off

setlocal

set "PackageRootDir=%~dp0"
if %PackageRootDir:~-1%==\ SET PackageRootDir=%PackageRootDir:~0,-1%

set "PackageName=bullet"
set "PackageVersion=2.38.5"
set "PackageSrcDir=%PackageRootDir%\%PackageName%-%PackageVersion%-src"
set "PackagePlatform=x86"
set "PackageToolset=v120"
set "PackageInsDir=%PackageRootDir%\%PackageName%-%PackageVersion%.%PackagePlatform%.%PackageToolset%"

endlocal