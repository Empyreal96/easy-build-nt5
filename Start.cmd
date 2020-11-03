@echo off
setlocal ENABLEDELAYEDEXPANSION
cd /d %~dp0 && cd ..
goto startRazzle

:startRazzle
cls
echo Starting Razzle/64 depending on your system...
echo.
rem
rem This command checks the registry to see what architecture the hosts main CPU is.
rem
if "%PROCESSOR_ARCHITECTURE%"=="x86" cmd /c %~dp0\razzle.cmd free offline&& goto mainmenu
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" cmd /c %~dp0\razzle64.cmd free offline&& goto mainmenu
goto mainmenu

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
echo ------------------------------------------
echo 1) Clean Build (Full err path, delete object files, no checks)
echo 2) 'Dirty' Build (Full err path, delete object files, no checks)
echo b) Open build.err in Notepad
echo ------------------------------------------
echo 3) Start Postbuild
echo p) Open postbuild.cmd's build.err
echo ------------------------------------------
echo 4) Create ISO image
echo 5) Exit
echo var
echo.
set /p NTMMENU=Select:
if "%NTMMENU%"=="pre" call :prebuild
if "%NTMMENU%"=="1" call :CleanBuild
if "%NTMMENU%"=="2" call :DirtyBuild
if "%NTMMENU%"=="b" call :BuildError
if "%NTMMENU%"=="3" call postbuild.cmd
if "%NTMMENU%"=="p" call :PostError
if "%NTMMENU%"=="4" call :MakeISO
if "%NTMMENU%"=="5" exit
if "%NTMMENU%"=="var" set
goto mainmenu

:prebuild
cmd /c %~dp0\prebuild.cmd
goto mainmenu



