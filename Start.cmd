@echo off
cd %~dp0
if NOT defined SDXROOT (goto :startRazzle) else (if defined SDXROOT goto :mainmenu)

:startRazzle
cls
echo Starting Razzle/64 depending on your system...
echo You will need to restart this batch once Razzle has loaded

reg query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set _CPU_ARCH=32BIT || set _CPU_ARCH=64BIT

if %_CPU_ARCH%==32BIT call .\razzle.cmd free offline
if %_CPU_ARCH%==64BIT call .\razzle64.cmd free offline

:mainmenu
cls
echo I take no credit for finding the build commands and methods used, like many I followed
echo the development threads on 4chan/g/wxp, so all credit goes to the /wxp Anons!
echo Any build issues I'm sure /wxp will help
echo.
timeout /T 5
cls
echo Here you will be able to run basic prebuild, build and postbuild scripts
echo Current build User: %_NTUSER%
echo Build root: %_NTROOT%
echo Postbuild dir: %_NTPOSTBLD%
echo Arch and Type: %_BuildType%,%_BuildArch%
echo ------------------------------------------
echo pre) Run 'prebuild.cmd' (Credit 4chan/OpenXP anons)
eo
echo.
echo 1) Clean Build (Full err path, delete object files, no checks)
echo 2) 'Dirty' Build (Full err path, delete object files, no checks)
echo e) Open build.err in Notepad
echo ------------------------------------------
echo 3)








