@echo off
cd %_NTROOT%
cls
echo I take no credit for finding the build commands and methods used, like many I followed
echo the development threads on 4chan/g/wxp, so all credit goes to the /wxp Anons!
echo Any build issues I'm sure /wxp will help
echo.
timeout /T 8
goto :mainmenu

:mainmenu
cd %_NTROOT%
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
echo.
set /p NTMMENU=Select:
if "%NTMMENU%"=="1" goto CleanBuild
if "%NTMMENU%"=="2" build -bZP
if "%NTMMENU%"=="b" call :BuildError
if "%NTMMENU%"=="3" postbuild.cmd
if "%NTMMENU%"=="p" call :PostError
if "%NTMMENU%"=="4" call :MakeISO
if "%NTMMENU%"=="5" exit /b
if "%NTMMENU%"=="pre" cmd /c prebuild.cmd&& timeout /t 3 && goto mainmenu
if "%NTMMENU%"=="var" set
goto mainmenu

:PreEnv


:CleanBuild
cd /d %~d0\srv03rtm
timeout /t 3
cmd /k build -bcZP&& pause && goto mainmenu

:DirtyBuild
cd /d %~d0\srv03rtm
timeout /t 3
cmd /k build -bZP&& pause && goto mainmenu
:BuildError
:PostError
:MakeISO


