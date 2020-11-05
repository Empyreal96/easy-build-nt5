@echo off
color 03
Title Easy-Build Environment For Razzle and OpenXP Patches
REM
REM UAC elevation
REM I found this method to elevate the script to admin here: https://stackoverflow.com/a/12264592
REM I chose it because it is what my Windows 10 Toolbox uses, and works well!
REM
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
goto RazCheck
 REM END UAC ELEVATION
:RazCheck
if exist %~dp0\razzle.cmd (goto easyfirstcheck) else (goto WhereisRaz)

:WhereisRaz
REM
REM This screen shows when 'razzle.cmd' cannot be found.
REM we decide this by the above sectiin :RazChech which simply
REM sees if the file is present in the working directory of this file.
REM If not found we redirect to this section which throws up a 'Bluescreen'
REM With host OS Version and bogus error number.. for shits and giggles lol
REM
cls
color 17
ver
echo.
echo Easy-Build has encountered an error and needs to close.
echo Application failed to start - 0x001a
echo.
echo RAZZLE_ENVIRONMENT_NOT_FOUND
echo.
echo If this is the first time seeing this, close this Window, copy Easy-Build
echo to the same directory as 'razzle.cmd' and try again.
echo.
pause
exit
REM goto easyinit
:easyfirstcheck
REM
REM This is a check to see if 'first run' has been completed, the .txt file 
REM is created after the first run dialogue
REM
if exist %~dp0\easy-build-check.txt (goto easyinit) else (goto easyfirstrun)
REM
REM This is the 'first run' dialogue, self explanitory. Creates the 'first run' complete
REM txt after this windows, It also checks for said .txt upon loading the dialogue and skips
REM this section if it is found.
RRM
:easyfirstrun
if exist %~dp0\easy-build-check.txt (goto easyinit)
cls
echo --------------------------------------------------------------------------------------------
echo Welcome to Easy-Build! (This will only show once)
echo.
echo This tool is designed for those messing with the NT5 source, but would like a quick tool to 
echo build through to ISO creation. It also shows info on current build env!
echo.
echo This tool will automatically load Razzle32/64 environment and ask for UAC access. 
echo Just create a Desktop Shortcut, and Double Click.
echo Over time I will add more capabilities to what this tool can do.
echo --------------------------------------------------------------------------------------------
echo REQUIREMENTS
echo.
echo - 4chan's prepatched source files and missing RTM ISO files.
echo - Loads of free Disk Space.
echo - Ideally to have already followed the guide to prep the source.
echo.
timeout /t 10 
REM this echo to file is used to tell if Easy-Build has done it's 'first run'
echo EASY_BUILD_FIRST_RUN=1 > %~dp0\easy-build-check.txt
goto easyinit
:easyinit
REM
REM This piece tells the script what Build Number to show depending on the name of NT source dir
REM It also checks to see if NTROOT has been set as to tell if it needs to start Razzle or not.
REM
if "%_NTROOT%" == "\srv03rtm" set _Build_No=3790
if "%_NTROOT%" == "\XPSP1" set _Build_No=2600
if "%_NTROOT%" == "" (goto RazzleFirst) else (goto mainmenu)
REM
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
REM
:RazzleFirst
echo.
echo This script needs to run in Razzle.
echo Starting Razzle32/64 Environment..
echo.
if exist %WinDir%\SysWOW64 (goto Razzle64) else (goto Razzle32)
REM
REM These are simply 'loaders' for 32 bit and 64 bit razzle;
REM It uses cmd to (1) execute Razzle, (2) change to the root Build folder and (3) run this file again inside razzle.
REM
:Razzle32
echo Loading Razzle for 32bit Windows
cmd.exe /k "%~dp0\razzle.cmd free offline && cd /d %~dp0 && cd .. && easy-build.cmd"
pause
:Razzle64
cd /d %~dp0
cd ..
echo Loading Razzle for 64bit Windows
cmd.exe /k ".\tools\razzle64.cmd free offline && easy-build.cmd"
pause
REM
REM Menu, pretty self explanitory on the purpose, echo loads of shit with handy info.
REM I have left the 'var' command in because I use it to see what variables are set
REM
:mainmenu
mode con:cols=95 lines=32
REM set "prerel_read="
REM for /F "skip=13 delims=" %%i in (%~d0%_NTROOT%\base\prerelease.inc) do if not defined prerel_read set "prerel_read=%%i"
REM if "%prerel_read%" == "PRERELEASE=0" (set prerel_info=Retail) else (set prerel_info=Prerelease)
REM
REM Here we will be setting some of the aliases used by razzle
REM
cd %_NTROOT%
cls
echo --------------------------------------------------------------------------------------------
echo  Empyreal's Easy-Build Wrapper for Razzle  (Open this file in notepad for credits)
echo --------------------------------------------------------------------------------------------
echo  Build User: %_NTUSER% 		Build Machine: %COMPUTERNAME%
echo  Build Root: %_NTDRIVE%%_NTROOT%		Razzle Tool Path: %RazzleToolPath%
echo  Postbuild Dir: %_NTPOSTBLD%	Binplace Exclude File: %BINPLACE_EXCLUDE_FILE%
echo --------------------------------------------------------------------------------------------
echo  Target Arch: %_BuildArch% - Release Type: %_BuildType% - Version: %_Build_No%
echo  Latest 4chan Patch available: Version 9c (28/10/2020)
echo --------------------------------------------------------------------------------------------
echo  Here you will be able to run basic prebuild, build and postbuild scripts.
echo  If this is your FIRST time building the currently extracted src, run Prebuild.
echo.
REM echo ------------------------------------------------------------------------------
echo  info) Build Info.   
echo  options) Modify Build Options.
echo  pre) Run Prebuild script
echo --------------------------------------------------------------------------------------------
echo  1) Clean Build (Full err path, delete object files, no checks)
echo  2) 'Dirty' Build (Full err path, no checks)
echo  3) Build Specific Directory Only
echo  b) Open build.err in Notepad
echo --------------------------------------------------------------------------------------------
echo - DON'T FORGET TO COPY MISSING.7Z CONTENTS
echo --------------------------------------------------------------------------------------------
echo  4) Start Postbuild
echo  p) Open postbuild.cmd's build.err
echo --------------------------------------------------------------------------------------------
echo  5) Create ISO image
echo  6) Drop to Razzle Prompt
echo.
echo ____________________________________________________________________________________________
set /p NTMMENU=Select:
echo ____________________________________________________________________________________________
if /i "%NTMMENU%"=="1" goto CleanBuild
if /i "%NTMMENU%"=="2" goto DirtyBuild
REM Opens the most recent builds error logs in Notepad
if /i "%NTMMENU%"=="b" notepad %~d0%_NTROOT%\build.err & goto mainmenu
if /i "%NTMMENU%"=="3" goto SpecificBLD
REM This starts the postbuild process, see postbuild.cmd for info
if /i "%NTMMENU%"=="4" if exist %_NTPOSTBLD%\PIDGEN.DLL (cmd /c postbuild.cmd&& timeout /t 5 && goto mainmenu) else (cls && echo Missing RTM ISO files not present in %~d0\binaries.x86fre && timeout /t 10 && goto mainmenu)
REM Opens the most recent postbuild error logs in Notepad
if /i "%NTMMENU%"=="p" notepad %_NTPOSTBLD%\build_logs\postbuild.err & goto mainmenu
if /i "%NTMMENU%"=="5" goto MakeISOCheck
if /i "%NTMMENU%"=="6" exit /b
REM This runs the prebuild.cmd to set up the build environment
REM If user gets error of file missing, they obviously haven't patched the source with the 4chan/OpenXP files.
if /i "%NTMMENU%"=="pre" cmd /c prebuild.cmd&& pause && goto mainmenu
if /i "%NTMMENU%"=="var" set && pause
REM Info page on what is set e.g DDK, NT build version and other bits
if /i "%NTMMENU%"=="info" goto BuildInfo
if /i "%NTMMENU%"=="options" goto BuildOptions
REM if /i "%NTMMENU%"=="xptan" goto XPtan
goto mainmenu
REM 
REM Seems to work for me now this bit..
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
REM 
REM This is where we init the 'Dirty' Building process, only difference is no deleting objects
REM (1) cd to current NT root, usually /srv03rtm or /XPSP1, just to be safe
REM (2) A little pause incase the user fucked up
REM (3) Use cmd to call the build command, which does:
REM		-b: Display full error message text
REM		-Z: No Dependancy checking of source files
REM		-P: Print time after each directory
REM
:DirtyBuild
cd /d %~d0%_NTROOT%
timeout /t 3 /nobreak
cmd /c build -bZP
pause
goto mainmenu
REM
REM This checks the Postbuild directory for PIDGEN.DLL from the missing files found at the Anons rentry guide
REM If the file doesn't exist, we presume the user has NOT copied the required missing files and returns them back
REM

:SpecificBLD
REM
REM In this section we take the users input, set it as a variable, then run against the clean build command
REM
REM
REM We will be setting some of the aliases used by razzle as a quick go-to for most directories
REM 
cd %~dp0
cd ..
echo.
cls
echo.
echo This section we can clean build certain components of the source
echo So if you want to rebuild Notepad you would type:
echo.
echo shell\osshell\accesory\notepad
echo.
echo.
echo Type full path to folder or type back to return:
set /p userinput=:
if "%userinput%"=="back" goto mainmenu
cd %userinput%
echo BUILD: %CD% STARTED
echo.
build -bcZP
pause
goto mainmenu
:MakeISOCheck
if exist %_NTPOSTBLD%\PIDGEN.DLL (goto MakeISO) else (cls && echo Missing RTM ISO files not present in %~d0\binaries.x86fre && timeout /t 10 && goto mainmenu)
REM
REM This section calls 'oscdimg.cmd' and asks for users input on desired SKU
REM Not much to say here, it just requires the switch for running oscdimg from razzle
REM
:MakeISO
cls
echo Please enter one of the SKUs from below to build your ISO (e.g pro)
echo Type: Key  to view needed Product Key
echo --------------------------------------------------------------------
echo.
echo  srv) Windows Server 2003 Standard Edition
echo  sbs) Windows Server 2003 Small Business Edition
echo  ads) Windows Server 2003 Enterprise Edition
echo  dtc) Windows Server 2003 Datacenter Edition
echo  bla) Windows Server 2003 Web Edition
echo  per) Windows XP Home Edition
echo  pro) Windows XP Professional
echo  back)
echo.
set /p oscd=Select:
if "%oscd%"=="key" goto ProdKeys
if "%oscd%"=="back" goto mainmenu
cmd /c oscdimg.cmd %oscd%&& pause
goto mainmenu

:ProdKeys
REM
REM These are they keys shown in the 4chan Rentry guide
REM Put them here for ease
REM
REM
cls
echo  Here are the Keys used during Installaion for each SKU
echo.
echo           - SRV, SBS, DTC, BLA, PER, PRO: -
ECHO           - M6RJ9-TBJH3-9DDXM-4VX9Q-K8M8M -
ECHO.
echo           -            ADS Only:          -
echo           - QW32K-48T2T-3D2PJ-DXBWY-C6WRJ -
echo.
pause
goto MakeISO

:BuildInfo
REM
REM This info page pulls the variables set by Razzle and some source files and
REM creates readable outputs to the user
REM 
REM I'm not going to explain each var as they should be rather obvious reading them
REM But I will add more here at a later date
REM
cls
if "%_NO_DDK%" == "1" (set ddk_info=DDK Building Off) else (set ddk_info=DDK Building Off)
if "%_BuildOpt%" == "full opt" (set bldopt_info=Full Optimization) else (set bldopt_info=No Optimization)
if "%BUILD_OFFLINE%" == "1" (set bldoffline=Offline Build) else (set bldoffline=Online Build)
if "%BUILD_PRODUCT_VER%" == "500" (set ntbld_ver=Targeted NT5) else (set ntbld_ver=N/A)
if "%BUILD_MULTIPROCESSOR%" == "1" (set buildthreads_info=Multithreaded Building) else (set buildthreads_info=Singlethreaded Building)
set "prerel_read="
for /F "skip=13 delims=" %%i in (%~d0%_NTROOT%\base\prerelease.inc) do if not defined prerel_read set "prerel_read=%%i"
if "%prerel_read%" == "PRERELEASE=0" set prerel_info=Retail
if "%prerel_read%" == "PRERELEASE=0 " set prerel_info=Retail
if "%prerel_read%" == "PRERELEASE=1" set prerel_info=Prerelease
if "%prerel_read%" == "PRERELEASE=1 " set prerel_info=Prerelease
echo ----------------------------------------------------------------
echo Various information about current build environment
echo ----------------------------------------------------------------
echo Build Options and Info:
echo %ntbld_ver%
echo %prerel_info%
echo %bldoffline%          	
echo %bldopt_info%         	
echo %ddk_info%
echo %buildthreads_info%
echo.
echo Other Info:
echo URT Version: %URT_VERSION%
echo Build Profile: %init%
echo AMD64 Building: Not Supported Yet
echo ----------------------------------------------------------------
echo For the 4chan guide visit: (Massive Credit to Anons over there)
echo https://rentry.co/build-win2k3
echo.
echo For usage on specific Razzle Build Env commands goto:
echo https://empyreal96.github.io/build-env-info
echo.
echo For other help and info, visit 4chan/g /wxp/
echo Do it for XP-tan
pause
goto mainmenu

:BuildOptions
cls
echo.
echo This section we can use to modify various parts of the build process
echo for example changing Release type, Build type etc
echo To switch, type the option after the Value:
echo.
echo Release: prerelease - retail
echo Build Type: fre - chk
REM echo To Change Build Dir: build-out
REM echo To Change Postbuild Dir: post-out
echo.
echo I will slowly add more here over time
echo.
echo back) Return
set /p bldopt=:
if /i "%bldopt%"=="prerelease" goto PreBuildset
if /i "%bldopt%"=="retail" goto RTMBuildset
if /i "%bldopt%"=="fre" goto buildfre
if /i "%bldopt%"=="chk" goto buildchk
if /i "%bldopt%"=="back" goto mainmenu
goto BuildOptions

REM

:PreBuildSet
echo Backing up original prerelease.inc file...
if exist "%~d0%_NTROOT%\base\prerelease.orig" del %~d0%_NTROOT%\base\prerelease.orig
if exist "%~d0%_NTROOT%\base\prerelease.inc" move %~d0%_NTROOT%\base\prerelease.inc %~d0%_NTROOT%\base\prerelease.orig
echo # > %~d0%_NTROOT%\base\prerelease.inc
echo # This file is used to control build options that should only appear in  >> %~d0%_NTROOT%\base\prerelease.inc
echo # internal releases, and NOT the beta or RTM releases.  This controls  >> %~d0%_NTROOT%\base\prerelease.inc
echo # features such as the GUI mode command prompt and the Win9x upgrade  >> %~d0%_NTROOT%\base\prerelease.inc
echo # autostress option.  >> %~d0%_NTROOT%\base\prerelease.inc
echo #  >> %~d0%_NTROOT%\base\prerelease.inc
echo # To change, simply set PRERELEASE to 1 for private builds, or 0 for beta  >> %~d0%_NTROOT%\base\prerelease.inc
echo # or RTM builds.  >> %~d0%_NTROOT%\base\prerelease.inc
echo #  >> %~d0%_NTROOT%\base\prerelease.inc
echo # **CHANGES HERE WILL REQUIRE A CLEAN BUILD OF THE SETUP, pnp and ntdll components **  >> %~d0%_NTROOT%\base\prerelease.inc
echo #  >> %~d0%_NTROOT%\base\prerelease.inc
echo.  >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!ifndef PRERELEASE  >> %~d0%_NTROOT%\base\prerelease.inc
echo PRERELEASE=1 >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!endif  >> %~d0%_NTROOT%\base\prerelease.inc
echo.  >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!if $(PRERELEASE)  >> %~d0%_NTROOT%\base\prerelease.inc
echo C_DEFINES=$(C_DEFINES) -DPRERELEASE  >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!endif  >> %~d0%_NTROOT%\base\prerelease.inc
echo   >> %~d0%_NTROOT%\base\prerelease.inc
set prerel_info=Prerelease
echo %prerel_info%
echo Build has been set to Prerelease
timeout /t 5
goto BuildOptions

:RTMBuildset
echo Backing up original prerelease.inc file...
if exist "%~d0%_NTROOT%\base\prerelease.orig" del %~d0%_NTROOT%\base\prerelease.orig
if exist "%~d0%_NTROOT%\base\prerelease.inc" move %~d0%_NTROOT%\base\prerelease.inc %~d0%_NTROOT%\base\prerelease.orig
echo # > %~d0%_NTROOT%\base\prerelease.inc
echo # This file is used to control build options that should only appear in  >> %~d0%_NTROOT%\base\prerelease.inc
echo # internal releases, and NOT the beta or RTM releases.  This controls  >> %~d0%_NTROOT%\base\prerelease.inc
echo # features such as the GUI mode command prompt and the Win9x upgrade  >> %~d0%_NTROOT%\base\prerelease.inc
echo # autostress option.  >> %~d0%_NTROOT%\base\prerelease.inc
echo #  >> %~d0%_NTROOT%\base\prerelease.inc
echo # To change, simply set PRERELEASE to 1 for private builds, or 0 for beta  >> %~d0%_NTROOT%\base\prerelease.inc
echo # or RTM builds.  >> %~d0%_NTROOT%\base\prerelease.inc
echo #  >> %~d0%_NTROOT%\base\prerelease.inc
echo # **CHANGES HERE WILL REQUIRE A CLEAN BUILD OF THE SETUP, pnp and ntdll components **  >> %~d0%_NTROOT%\base\prerelease.inc
echo #  >> %~d0%_NTROOT%\base\prerelease.inc
echo.  >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!ifndef PRERELEASE  >> %~d0%_NTROOT%\base\prerelease.inc
echo PRERELEASE=0 >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!endif  >> %~d0%_NTROOT%\base\prerelease.inc
echo.  >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!if $(PRERELEASE)  >> %~d0%_NTROOT%\base\prerelease.inc
echo C_DEFINES=$(C_DEFINES) -DPRERELEASE  >> %~d0%_NTROOT%\base\prerelease.inc
echo ^^!endif  >> %~d0%_NTROOT%\base\prerelease.inc
echo   >> %~d0%_NTROOT%\base\prerelease.inc
set prerel_info=Retail
rem echo %prerel_info%
echo Build has been set to Retail
timeout /t 5
goto BuildOptions



:buildfre
echo.
echo Setting Razzle variables to Free
timeout /t 3
set _BuildType=fre
set NTDEBUG=ntsdnodbg
set _BuildBins=binaries in: %_NTDRIVE%\binaries.x86%_BuildType%
set _BuildWTitle=Build Window: x86/%_BuildType%/full opt/%_BuildBins%
set _NTPOSTBLD=%_NTDRIVE%\binaries.x86%_BuildType%
set _NTTREE=%_NTDRIVE%\binaries.x86%_BuildType%
set _NTx86TREE=%_NTDRIVE%\binaries.x86%_BuildType%
set BINPLACE_LOG=%_NTDRIVE%\binaries.x86%_BuildType%\build_logs\binplace.log
goto BuildOptions

:buildchk
echo.
echo Setting Razzle variables to Checked
timeout /t 3
set _BuildType=chk
set NTDEBUG=ntsd
set _BuildBins=binaries in: %_NTDRIVE%\binaries.x86%_BuildType%
set _BuildWTitle=Build Window: x86/%_BuildType%/full opt/%_BuildBins%
set _NTPOSTBLD=%_NTDRIVE%\binaries.x86%_BuildType%
set _NTTREE=%_NTDRIVE%\binaries.x86%_BuildType%
set _NTx86TREE=%_NTDRIVE%\binaries.x86%_BuildType%
set BINPLACE_LOG=%_NTDRIVE%\binaries.x86%_BuildType%\build_logs\binplace.log
goto BuildOptions
REM :buildoutputdir
REM :postbuildoutdir

:EOF
