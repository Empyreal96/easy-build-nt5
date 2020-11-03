@echo off
color 09
REM I found this method to elevate the script to admin here: https://stackoverflow.com/a/12264592
REM I chose it because it is what my Windows 10 Toolbox uses, and works well!

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO.
  ECHO Invoking UAC for Privilege Escalation
  ECHO.

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"

  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
REM End UAC elevation


REM This piece tells the script what Build Number to show depending on the name of NT source dir
REM It also checks to see if NTROOT has been set as to tell if it needs to start Razzle or not.
if "%_NTROOT%" == "\srv03rtm" set _Build_No=3790
if "%_NTROOT%" == "\XPSP1" set _Build_No=2600
if "%_NTROOT%" == "" (goto RazzleFirst) else (goto mainmenu)
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
REM cd %_NTROOT%
REM cls
REM echo loading
REM timeout /t 2 /nobreak
REM echo.
REM =====================
REM This section simply detects if the users PC is 32 bit or 64 bit;
REM All it does is look in C:\Windows\ for the SysWOW64 folder.
REM If the folder exists, it will load the razzle64.cmd (See :Razzle64)
REM otherwise it will load standard razzle.cmd (See :Razzle32)
:RazzleFirst
echo.
echo This script needs to run in Razzle.
echo Starting Razzle32/64 Environment..
timeout /t 3 /nobreak
if exist %WinDir%\SysWOW64 (goto Razzle64) else (goto Razzle32)

REM These are simply 'loaders' for 32 bit and 64 bit razzle;
REM It uses cmd to (1) execute Razzle, (2) change to the root Build folder and (3) run this file again inside razzle.
:Razzle32
cls
echo Loading Razzle for 32bit Windows
cmd.exe /k "%~dp0\razzle.cmd free offline && cd /d %~dp0 && cd .. && easy-build.cmd"
pause
:Razzle64
cd /d %~dp0
cd ..
echo Loading Razzle for 64bit Windows
cmd.exe /k ".\tools\razzle64.cmd free offline && cd /d %_NTROOT% && easy-build.cmd"
pause


REM Menu, pretty self explanitory on the purpose, echo loads of shit with handy info.
REM I have left the 'var' command in because I use it to see what variables are set
:mainmenu
cd %_NTROOT%
cls
echo --------------------------------------------------------------------------------------------
echo  Empyreal's Easy-Build-Env  (Open this file in notepad for credits)
echo --------------------------------------------------------------------------------------------
echo  Build User: %_NTUSER% 		Build Machine: %COMPUTERNAME%
echo  Build Root: %~d0%_NTROOT%		Razzle Tool Path: %RazzleToolPath%
echo  Postbuild Dir: %_NTPOSTBLD%	Binplace Exclude File: %BINPLACE_EXCLUDE_FILE%
echo --------------------------------------------------------------------------------------------
echo  Build Arch: %_BuildArch% - Release Type: %_BuildType% - Version: %_Build_No%
echo --------------------------------------------------------------------------------------------
echo  Here you will be able to run basic prebuild, build and postbuild scripts.
echo  If this is your FIRST time building the currently extracted src, run Prebuild
REM echo ------------------------------------------------------------------------------
echo.
echo  pre) Run Prebuild script
echo --------------------------------------------------------------------------------------------
echo  1) Clean Build (Full err path, delete object files, no checks)
echo  2) 'Dirty' Build (Full err path, no checks)
echo  b) Open build.err in Notepad
echo --------------------------------------------------------------------------------------------
echo  3) Start Postbuild
echo  p) Open postbuild.cmd's build.err
echo --------------------------------------------------------------------------------------------
echo - DON'T FORGET TO COPY MISSING.7Z CONTENTS
echo --------------------------------------------------------------------------------------------
echo  4) Create ISO image
echo  5) Exit
echo.
echo ____________________________________________________________________________________________
set /p NTMMENU=Select:
if "%NTMMENU%"=="1" goto CleanBuild
if "%NTMMENU%"=="2" goto DirtyBuild
REM Opens the most recent builds error logs in Notepad
if "%NTMMENU%"=="b" notepad %~d0%_NTROOT%\build.err & goto mainmenu
REM This starts the postbuild process, see postbuild.cmd for info
if "%NTMMENU%"=="3" cmd /c postbuild.cmd&& timeout /t 5 && goto mainmenu
REM Opens the most recent postbuild error logs in Notepad
if "%NTMMENU%"=="p" notepad %_NTPOSTBLD%\build_logs\postbuild.err & goto mainmenu
if "%NTMMENU%"=="4" goto MakeISO
if "%NTMMENU%"=="5" exit /b
REM This runs the prebuild.cmd to set up the build environment
REM If user gets error of file missing, they obviously haven't patched the source with the 4chan/OpenXP files.
if "%NTMMENU%"=="pre" cmd /c prebuild.cmd&& timeout /t 5 && goto mainmenu
if "%NTMMENU%"=="var" set 
REM TODO: Info page on what is set e.g DDK, NT build version and other bits
REM if "%NTMMENU%"=="info" goto BuildInfo
goto mainmenu
REM :BuildInfo

REM This I have found tempermental, most likely me missing something simple..
REM This is where we init the Clean Building process;
REM (1) cd to current NT root, usually /srv03rtm or /XPSP1, just to be safe
REM (2) A little pause incase the user fucked up
REM (3) Use cmd to call the build command, which does:
REM		-b: Display full error message text
REM		-c: Deletes all object files
REM		-Z: No Dependancy checking of source files
REM		-P: Print time after each directory
REM
:CleanBuild
cd /d %~d0%_NTROOT%
timeout /t 3 /nobreak
cmd /c build -bcZP
pause
goto mainmenu

REM Same as before I found troublesome..
REM This is where we init the 'Dirty' Building process, only difference is no deleting objects
REM (1) cd to current NT root, usually /srv03rtm or /XPSP1, just to be safe
REM (2) A little pause incase the user fucked up
REM (3) Use cmd to call the build command, which does:
REM		-b: Display full error message text
REM		-Z: No Dependancy checking of source files
REM		-P: Print time after each directory

:DirtyBuild
cd /d %~d0\srv03rtm
timeout /t 3 /nobreak
cmd /c build -bZP
pause
goto mainmenu

REM This section calls 'oscdimg.cmd' and asks for users input on desired SKU
REM Not much to say here, it just requires the switch for running oscdimg from razzle
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
cmd /c oscdimg.cmd %oscd%&& timeout /t 5
goto mainmenu

:EOF
