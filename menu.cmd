@echo off
REM =================================================================================
REM Feel free to modify this script, I just made it to make life lazy for those
REM needing to build frequently. 
REM
REM I take no credit for finding the build commands and methods used, like many I followed
REM the development threads on 4chan/g/wxp, so all credit goes to the /wxp Anons and whomever else!
REM Any build issues I'm sure /wxp will help
REM
REM This has only been tested against the srv03rtm src with the 4chan prepatched files,
REM but this will most likely work for XPSP1 aswell. Tested on Windows 10 only so far
REM
REM Any issues with this script contact me on github @ empyreal96
REM
REM =================================================================================
REM Info on commands used in this script:
REM 	(timeout) 	= Used to create a short pause between commands, /t specifies time in seconds
REM 		/nobreak adds a Ctrl+C option while waiting
REM 	(%_NTxxxx%) = Variables are set by Razzle, to change see Razzle usage and the SET command
REM		(%~d0) 		= This tells the command prompt to look in current files(menu.bat) Drive root
REM 	(set)		= This sets a variable for this script, to be used in this script
REM 	Other %xxx% = These are set by Razzle and Windows and best left as-is
REM
REM
REM
REM I will update over time, I want to ensure a full build is possible using this script first
REM before adding more options
REM
REM
REM
REM =================================================================================
color 0D
cd %_NTROOT%
cls
echo loading
timeout /t 2 /nobreak
echo.
goto :mainmenu

:mainmenu
cd %_NTROOT%
cls
echo ------------------------------------------------------------------------------
echo  Empyreal's Easy-Build-Env  (Open this file in notepad for credits)
echo ------------------------------------------------------------------------------
echo  Build User: %_NTUSER% 		Build Machine: %COMPUTERNAME%
echo  Build Root: %~d0%_NTROOT%		Razzle Tool Path: %RazzleToolPath%
echo  Postbuild Dir: %_NTPOSTBLD%	Binplace Exclude File: %BINPLACE_EXCLUDE_FILE%
echo  Build Arch: %_BuildArch%			Release Type: %_BuildType%
echo ------------------------------------------------------------------------------
echo  Here you will be able to run basic prebuild, build and postbuild scripts.
echo ------------------------------------------------------------------------------
echo.
echo.
echo ------------------------------------------------------------------------------
echo  pre) Run 'prebuild.cmd'
echo ------------------------------------------------------------------------------
echo  1) Clean Build (Full err path, delete object files, no checks)
echo  2) 'Dirty' Build (Full err path, delete object files, no checks)
echo  b) Open build.err in Notepad
echo ------------------------------------------------------------------------------
echo  DON'T FORGET TO COPY MISSING.7Z
echo ------------------------------------------------------------------------------
echo  3) Start Postbuild
echo  p) Open postbuild.cmd's build.err
echo ------------------------------------------------------------------------------
echo  4) Create ISO image
echo  5) Exit
echo.
set /p NTMMENU=Select:
if "%NTMMENU%"=="1" goto CleanBuild
if "%NTMMENU%"=="2" goto DirtyBuild
if "%NTMMENU%"=="b" notepad %~d0%_NTROOT%\build.err & goto mainmenu
if "%NTMMENU%"=="3" cmd /c postbuild.cmd&& timeout /t 5 && goto mainmenu
if "%NTMMENU%"=="p" notepad %_NTPOSTBLD%\build_logs\postbuild.err & goto mainmenu
if "%NTMMENU%"=="4" goto MakeISO
if "%NTMMENU%"=="5" exit /b
if "%NTMMENU%"=="pre" cmd /c prebuild.cmd&& timeout /t 5 && goto mainmenu
if "%NTMMENU%"=="var" set 
goto mainmenu


:CleanBuild
cd /d %~d0\srv03rtm
timeout /t 3
cmd /c build -bcZP&& pause && goto mainmenu

:DirtyBuild
cd /d %~d0\srv03rtm
timeout /t 3
cmd /c build -bZP&& pause && goto mainmenu

:MakeISO
cls
echo Plese enter one of the SKUs from below to build your ISO (e.g pro)
echo.
echo `srv` - Windows Server 2003 Standard Edition
echo `sbs` - Windows Server 2003 Small Business Edition
echo `ads` - Windows Server 2003 Enterprise Edition
echo `dtc` - Windows Server 2003 Datacenter Edition
echo `bla` - Windows Server 2003 Web Edition
echo `per` - Windows XP Home Edition
echo `pro` - Windows XP Professional
echo.
set /p oscd=
cmd /c oscdimg.cmd %oscd%&& timeout /t 5 && goto mainmenu

:EOF
