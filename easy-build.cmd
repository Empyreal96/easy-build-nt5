@echo off
REM
REM =================================================================================
REM Easy-Build for NT5 by Empyreal96
REM
REM Feel free to modify this script, I just made it to make life lazy for those
REM needing to build frequently. 
REM
REM I take no credit for finding the build commands and methods used, like many I followed
REM the development threads on 4chan/g/wxp and the OpenXP Matrix Group, so all credit goes to the /wxp Anons, Matrix Group and whomever else!
REM
REM This has only been tested against the srv03rtm src with the 4chan prepatched files,
REM but this will most likely work for XPSP1 partially. Tested on Windows 10 only so far
REM
REM Likely to be the 'last' update for a while
REM
REM =================================================================================
color 03
Title Easy-Build Environment For Razzle and OpenXP Patches
echo Loading..
REM
REM if NOT exist %~dp0\prebuild.cmd goto easypatcherinit
REM
REM
REM Below is just current internal build version and 4chan patches
set "EASY_BUILD_RELEASE=v0.3-archived"
set "CHAN_PREPATCHED_LATEST=win2003_prepatched_v10a"
set "CHAN_WINLOGON_VERSION=winlogon200X_v3c"
set "CHAN_MISSING_FILES_VER=win2003_x86-missing-binaries_v2"
set "OPENXP_AMD64_PATCHES="
REM
REM Here is the 'system' to check for requirements. I say system, its just a bunch of if statements 
REM

rem git check will be here
rem 

if exist "%SYSTEMROOT%\SysWOW64" set "_SYSWOW64=%SYSTEMROOT%\SysWOW64"
if NOT exist "%~dp0\razzle.cmd" goto WhereisRaz
if NOT exist "%~dp0\7za.exe" goto AssetError
if NOT exist "%~dp0\prebuild.cmd" goto attribchange
rem if exist "%~dp0\CertGen\Start.bat" (set "_CertGen=%~dp0\CertGen\Start.bat"

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
  :attribcheck
 if NOT exist %~dp0\prebuild.cmd goto attribchange
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
echo %EASY_BUILD_RELEASE%
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
REM
:easyfirstrun
if exist %~dp0\easy-build-check.txt (goto easyinit)
cls
echo --------------------------------------------------------------------------------------------
echo Welcome to Easy-Build %EASY_BUILD_RELEASE% (This will only show once)
echo.
echo This tool is designed for those messing with the NT5 source, but would like a quick tool to 
echo build through to ISO creation. It also shows info on current build env!
echo.
echo This tool will automatically load Razzle32/64 environment and ask for UAC access. 
echo Just create a Desktop Shortcut, and Double Click.
echo This will likely be the last commit for the forseeable future.
echo --------------------------------------------------------------------------------------------
echo REQUIREMENTS
echo.
echo - Loads of free Disk Space.
echo - Ideally to have already followed the guide to prep the source.
echo.
pause 
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
if "%_NTROOT%" == "\OpenXPm" set _Build_No=3790
if "%_NTROOT%" == "" (goto RazzleFirst) else (goto mainmenu)
if EXIST "%~d0\OpenXPm" echo GIT version detected (TEST MESSAGE)&& Timeout /t 3 && goto mainmenu
REM Add ntroot dir check:
rem
rem

REM cd %_NTROOT%
REM cls
REM echo loading
REM timeout /t 2 /nobreak
REM echo.
REM =====================

:RazzleFirst
REM This section simply detects if the users PC is 32 bit or 64 bit;
REM All it does is look in C:\Windows\ for the SysWOW64 folder.
REM If the folder exists, it will load the razzle64.cmd (See :Razzle64)
REM otherwise it will load standard razzle.cmd (See :Razzle32)
REM
echo.
echo Starting Razzle32/64 Environment Hand-over to Easy-Build...
echo Please Wait..
echo.
set _SelectedBuild=
if exist "%_SYSWOW64%\" (goto Razzle64) else (goto Razzle32)
REM
REM These are simply 'loaders' for 32 bit and 64 bit razzle;
REM It uses cmd to (1) execute Razzle, (2) change to the root Build folder and (3) run this file again inside razzle.
:Razzle32
echo.
echo Loading Razzle for 32bit Windows
if /i "%2" == "x64" (set "_SelectedBuild=win64 amd64") else (set "_SelectedBuild= ")
if /i "%1" == "" cmd.exe /k "%~dp0\razzle.cmd free offline %_SelectedBuild% && cd /d %~dp0 && cd .. && easy-build.cmd"
if /i "%1" == "free" cmd.exe /k "%~dp0\razzle.cmd free offline %_SelectedBuild% && cd /d %~dp0 && cd .. && easy-build.cmd"
if /i "%1" == "chk" cmd.exe /k "%~dp0\razzle.cmd offline %_SelectedBuild% && cd /d %~dp0 && cd .. && easy-build.cmd"
pause
goto mainmenu
:Razzle64
echo.
echo Loading Razzle for 64bit Windows
if /i "%2" == "x64" (set "_SelectedBuild=win64 amd64") else (set "_SelectedBuild= ")
if /i "%1" == "" cmd.exe /k "%~dp0\razzle64.cmd free offline %_SelectedBuild% && cd /d %~dp0 && cd .. && easy-build.cmd"
if /i "%1" == "free" cmd.exe /k "%~dp0\razzle64.cmd free offline %_SelectedBuild% && cd /d %~dp0 && cd .. && easy-build.cmd"
if /i "%1" == "chk" cmd.exe /k "%~dp0\razzle64.cmd offline %_SelectedBuild% && cd /d %~dp0 && cd .. && easy-build.cmd"
pause
goto mainmenu
REM
REM Menu, pretty self explanitory on the purpose, echo loads of shit with handy info.
REM I have left the 'var' command in because I use it to see what variables are set
REM
:mainmenu
mode con:cols=95 lines=35
Title Easy-Build Environment For Razzle and OpenXP -- Main Menu  --  %_IsAmd64Set%
if NOT exist %~dp0\easy-prebuild-done.txt goto easyautoprebuild
if /i "%_SelectedBuild%" == "win64 amd64" set "_IsAmd64Set=Building for AMD64"
REM set "prerel_read="
REM for /F "skip=13 delims=" %%i in (%~d0%_NTROOT%\base\prerelease.inc) do if not defined prerel_read set "prerel_read=%%i"
REM if "%prerel_read%" == "PRERELEASE=0" (set prerel_info=Retail) else (set prerel_info=Prerelease)
REM
REM
cd /d %_NTROOT%
cls
echo --------------------------------------------------------------------------------------------
echo  Empyreal's Easy-Build Wrapper for Razzle  (Open this file in notepad for credits and notes)
echo --------------------------------------------------------------------------------------------
echo  Build User: %_NTUSER% 		Build Machine: %COMPUTERNAME%
echo  Build Root: %_NTDRIVE%%_NTROOT%		Razzle Tool Path: %RazzleToolPath%
echo  Postbuild Dir: %_NTPOSTBLD%	Binplace Exclude File: %BINPLACE_EXCLUDE_FILE%
echo --------------------------------------------------------------------------------------------
echo  Target Arch: %_BuildArch% - Release Type: %_BuildType% - Version: %_Build_No%
echo  4chan Patch: %CHAN_PREPATCHED_LATEST%   Easy-Build: %EASY_BUILD_RELEASE%   Winlogon: %CHAN_WINLOGON_VERSION%
echo --------------------------------------------------------------------------------------------
echo  Here you will be able to run basic prebuild, build and postbuild scripts.
echo  If this is your FIRST time building the currently extracted src, run Prebuild.
echo.
REM echo ------------------------------------------------------------------------------
echo  patch)   Info on patches                    ^|   options) Modify Some Build Options.
echo  info)    View Current Build Info.           ^|   
echo  pre)     Run Prebuild script
echo --------------------------------------------------------------------------------------------
echo  build)   Start Automated Build
echo  rebuild) Start Automated 'dirty' Build
echo  1)       Clean Build (Full err path, delete object files, no checks)
echo  2)       'Dirty' Build (Full err path, no checks)
echo  3)       Build Specific Directory Only
echo  b/w)     Open Build Error or Warning Logs
echo --------------------------------------------------------------------------------------------
echo - DON'T FORGET TO COPY MISSING FILES TO: "%_NTPOSTBLD%"
echo --------------------------------------------------------------------------------------------
echo  4)       Start Postbuild
echo  p/q)     Open Postbuild's Error or Warning logs
echo --------------------------------------------------------------------------------------------
echo  5)       Create ISO image
echo  6)       Drop to Razzle Prompt
echo.
echo ____________________________________________________________________________________________
set /p NTMMENU=Select:
echo ____________________________________________________________________________________________
if /i "%NTMMENU%"=="1" goto CleanBuild
if /i "%NTMMENU%"=="2" goto DirtyBuild
REM Opens the most recent builds error logs in Notepad
if /i "%NTMMENU%"=="b" notepad %~d0%_NTROOT%\build.err & goto mainmenu
if /i "%NTMMENU%"=="w" notepad %~d0%_NTROOT%\build.wrn & goto mainmenu
if /i "%NTMMENU%"=="3" goto SpecificBLD
REM This starts the postbuild process, see postbuild.cmd for info
if /i "%NTMMENU%"=="4" Title Easy-Build Environment For Razzle and OpenXP Patches -- Postbuild && cmd /c postbuild.cmd&& pause && goto mainmenu
REM Opens the most recent postbuild error logs in Notepad
if /i "%NTMMENU%"=="p" notepad %_NTPOSTBLD%\build_logs\postbuild.err & goto mainmenu
if /i "%NTMMENU%"=="q" notepad %_NTPOSTBLD%\build_logs\postbuild.wrn & goto mainmenu
if /i "%NTMMENU%"=="5" goto MakeISOCheck
if /i "%NTMMENU%"=="6" exit /b
REM This runs the prebuild.cmd to set up the build environment
REM If user gets error of file missing, they obviously haven't patched the source with the 4chan/OpenXP files.
if /i "%NTMMENU%"=="pre" Title Easy-Build Environment For Razzle and OpenXP Patches -- Prebuild && cmd /c prebuild.cmd&& pause && goto mainmenu
if /i "%NTMMENU%"=="var" set && pause
REM Info page on what is set e.g DDK, NT build version and other bits
if /i "%NTMMENU%"=="info" goto BuildInfo
if /i "%NTMMENU%"=="options" goto BuildOptions
if /i "%NTMMENU%"=="patch" goto easypatcherinit
if /i "%NTMMENU%"=="build" goto easyautobuild
if /i "%NTMMENU%"=="rebuild" goto easyautorebuild
if /i "%NTMMENU%"=="openssl" call %_CertGen%
REM if /i "%NTMMENU%"=="oldpatch" goto easypatcherinitold
goto mainmenu
REM This is the Auto Build section
:easyautobuild
cls 
if not exist "%~dp0\wget.exe" echo Please copy WGET.EXE to %RazzleToolPath% && goto mainmenu
Title Easy-Build Environment For Razzle and OpenXP Patches -- AUTO BUILD: %_NTDRIVE%%_NTROOT%
echo.
echo Easy-Build will run through Build, postbuild and oscdimg.
echo.
echo I386 Available SKUS: ADS/DTC/BLA/SRV/PER/PRO/SBS 
echo AMD64 Available SKUS: ADS/DTC/PER/PRO/
echo.
echo.
echo.
echo Easy-Build will presume Patches have been applied. If not fix this now.
echo.  
echo 1) Main Menu
echo.
echo.
echo ____________________________________________________________________________________________
set /p AUTOMENU=Select:
echo ____________________________________________________________________________________________
if /i "%AUTOMENU%"=="ads" set ebautosku=ads && goto easyautobuildstart
if /i "%AUTOMENU%"=="dtc" set ebautosku=dtc && goto easyautobuildstart
if /i "%AUTOMENU%"=="bla" set ebautosku=bla && goto easyautobuildstart
if /i "%AUTOMENU%"=="srv" set ebautosku=srv && goto easyautobuildstart
if /i "%AUTOMENU%"=="per" set ebautosku=per && goto easyautobuildstart
if /i "%AUTOMENU%"=="pro" set ebautosku=pro && goto easyautobuildstart
if /i "%AUTOMENU%"=="sbs" set ebautosku=sbs && goto easyautobuildstart
if /i "%AUTOMENU%"=="1" goto mainmenu
goto easyautobuild



:easyautobuildstart
if /i "%2" == "x64" if not exist "%_NTDRIVE%\binaries.x86%_BuildType%" goto AMD64Error
echo.
echo.
echo Make sure Patched Files are applied to the source tree before choosing this method.
echo.
echo Press Any Key to start.
pause >nul
echo Building %ebautosku% for %_BuildArch%
echo BUILD: %_NTDRIVE%%_NTROOT% STARTED
echo.
cd /d %~d0%_NTROOT%
echo Starting Prebuild
echo.
if not exist "%_NTDRIVE%%_NTROOT%\tools\prebuild.cmd" cls && echo Prebuild script not found! && pause && goto Main menu
cmd /c prebuild.cmd
echo.
echo Starting BUILD
echo.
cmd /c build -bcZP
echo.
if exist "%_NTDRIVE%%_NTROOT%\build.err" echo Errors were found during BUILD && pause && goto mainmenu
echo.
Title Easy-Build Environment For Razzle and OpenXP Patches -- POSTBUILD
echo Starting Postbuild
echo.
cmd /c postbuild.cmd
echo.
echo Creating ISO
Title Easy-Build Environment For Razzle and OpenXP Patches -- OSCDIMG %ebautosku%
echo.
cmd /c oscdimg.cmd %ebautosku%
echo.
echo Finished! 
echo.
pause
goto mainmenu



:easyautorebuild
cls 
REM if not exist "%~dp0\wget.exe" echo Please copy WGET.EXE to %RazzleToolPath% && goto mainmenu
Title Easy-Build Environment For Razzle and OpenXP Patches -- AUTO BUILD: %_NTDRIVE%%_NTROOT%
echo.
echo Easy-Build will run through Build, postbuild and oscdimg.
echo.
echo I386 Available SKUS: ADS/DTC/BLA/SRV/PER/PRO/SBS 
echo AMD64 Available SKUS: ADS/DTC/PER/PRO/
echo.
echo.
echo.
echo Easy-Build will presume Patches have been applied. If not fix this now.
echo.  
echo TYPE SKU or
echo 1) Main Menu
echo.
echo.
echo ____________________________________________________________________________________________
set /p AUTOMENU=Select:
echo ____________________________________________________________________________________________
if /i "%AUTOMENU%"=="ads" set ebautosku=ads && goto easyautorebuildstart
if /i "%AUTOMENU%"=="dtc" set ebautosku=dtc && goto easyautorebuildstart
if /i "%AUTOMENU%"=="bla" set ebautosku=bla && goto easyautorebuildstart
if /i "%AUTOMENU%"=="srv" set ebautosku=srv && goto easyautorebuildstart
if /i "%AUTOMENU%"=="per" set ebautosku=per && goto easyautorebuildstart
if /i "%AUTOMENU%"=="pro" set ebautosku=pro && goto easyautorebuildstart
if /i "%AUTOMENU%"=="sbs" set ebautosku=sbs && goto easyautorebuildstart
if /i "%AUTOMENU%"=="1" goto mainmenu
goto easyautorebuild

:easyautorebuildstart
echo.
if /i "%2" == "x64" if not exist "%_NTDRIVE%\binaries.x86%_BuildType%" goto AMD64Error
echo.
echo.
echo Make sure Patched Files are applied to the source tree before choosing this method.
echo.
echo Press Any Key to start.
pause >nul
echo Building %ebautosku% for %_BuildArch%
echo BUILD: %_NTDRIVE%%_NTROOT% STARTED
echo.
cd /d %~d0%_NTROOT%
echo Starting Prebuild
echo.
if not exist "%_NTDRIVE%%_NTROOT%\tools\prebuild.cmd" cls && echo Prebuild script not found! && pause && goto Main menu
cmd /c prebuild.cmd
echo.
echo Starting BUILD
echo.
cmd /c build -bZP
echo.
if exist "%_NTDRIVE%%_NTROOT%\build.err" echo Errors found during BUILD && pause && goto mainmenu
echo.
Title Easy-Build Environment For Razzle and OpenXP Patches -- POSTBUILD
echo Starting Postbuild
echo.
cmd /c postbuild.cmd
echo.
echo Creating ISO
Title Easy-Build Environment For Razzle and OpenXP Patches -- OSCDIMG %ebautosku%
echo.
cmd /c oscdimg.cmd %ebautosku%
echo.
echo Finished! 
echo.
pause
goto mainmenu



:CleanBuild
Title Easy-Build Environment For Razzle and OpenXP Patches -- BUILD: %_NTDRIVE%%_NTROOT%
if /i "%2" == "x64" if not exist "%_NTDRIVE%\binaries.x86%_BuildType%" goto AMD64Error
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
if /i "%2" == "x64" if not exist "%_NTDRIVE%\binaries.x86%_BuildType%" goto AMD64Error
cd /d %~d0%_NTROOT%
pause
echo BUILD: %_NTDRIVE%%_NTROOT% STARTED
echo.
cmd /c build -bcZP
echo.
pause
goto mainmenu
:DirtyBuild
Title Easy-Build Environment For Razzle and OpenXP Patches -- BUILD: %_NTDRIVE%%_NTROOT%
REM 
REM This is where we init the 'Dirty' Building process, only difference is no deleting objects
REM (1) cd to current NT root, usually /srv03rtm or /XPSP1, just to be safe
REM (2) A little pause incase the user fucked up
REM (3) Use cmd to call the build command, which does:
REM		-b: Display full error message text
REM		-Z: No Dependancy checking of source files
REM		-P: Print time after each directory
REM
if /i "%2" == "x64" if not exist "%_NTDRIVE%\binaries.x86%_BuildType%" goto AMD64Error
cd /d %~d0%_NTROOT%
pause
echo BUILD: %_NTDRIVE%%_NTROOT% STARTED
echo.
cmd /c build -bZP
echo.
pause
goto mainmenu
REM
REM This checks the Postbuild directory for PIDGEN.DLL from the missing files found at the Anons rentry guide
REM If the file doesn't exist, we presume the user has NOT copied the required missing files and returns them back
REM

:SpecificBLD
Title Easy-Build Environment For Razzle and OpenXP Patches -- BUILD:

REM
REM In this section we take the users input, set it as a variable, then run against the clean build command
REM
REM TODO: Add/import Razzle aliases to use with Easy-Build.
REM 
REM 
cd %~dp0
cd ..
cls
echo ----------------------------------------------------------------------
echo This section we can clean build certain components of the source
echo So if you want to rebuild Notepad you would type:
echo.
echo shell\osshell\accesory\notepad
echo ----------------------------------------------------------------------
echo.
echo Type full path to folder or type back to return:
echo.
set /p userinput=:
if "%userinput%"=="back" goto mainmenu
cd %userinput%
Title Easy-Build Environment For Razzle and OpenXP Patches -- BUILD: %CD%
echo BUILD: %CD% STARTED
echo.
build -bcZP
pause
goto mainmenu

:MakeISOCheck
REM Removed
REM
goto MakeISO
:MakeISO
Title Easy-Build Environment For Razzle and OpenXP Patches -- Make ISO Image
REM
REM Just a basic list of SKUs available, and a simple user set var to define the SKU abbr. 
REM and run that var against 'oscdimg.cmd'
cls
echo --------------------------------------------------------------------
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
REM Put them here for ease. There will be othets, but the injected PIDGEN.DLL
REM used accepts these keys.
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
echo.
echo             NOT NEEDED WITH PATCHED PIDGEN
pause
goto MakeISO

:BuildInfo
Title Easy-Build Environment For Razzle and OpenXP Patches -- Build Env Info
REM
REM This info page pulls the variables set by Razzle and some source files and
REM creates readable outputs to the user
REM 
REM I'm not going to explain each var as they should be rather obvious reading them
REM But I will add more here at a later date
REM
cls
if "%_NO_DDK%" == "1" (set ddk_info=DDK Building Off) else (set ddk_info=DDK Building On)
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
echo %ddk_info% (Not supported yet I think)
echo %buildthreads_info%
echo.
echo Other Info:
echo URT Version: %URT_VERSION%
echo Build Profile: %init%
REM
REM TODO: Add option for user to choose x86 or x64 building on startup.
REM For nkw I am waiting until the process becomes stable or if I decide to make my patcher.
REM
echo ----------------------------------------------------------------
echo For the 4chan guide visit: (Massive Credit to Anons over there)
echo https://rentry.co/build-win2k3   (Outdated)
echo.
echo For usage on specific Razzle Build Env commands goto:
echo https://empyreal96.github.io/build-env-info 
echo For books on Windows Internals:
echo https://empyreal96.github.io/nt-info-depot/
echo.
echo Do it for XP-tan
pause
goto mainmenu

:BuildOptions
Title Easy-Build Environment For Razzle and OpenXP Patches -- Build Options
REM
REM Over time I will add more features, first I need to find what to change and how
REM Suggestions and improvements greatly welcomed here.
REM
REM 
cls
echo ----------------------------------------------------------------------
echo This section we can use to modify various parts of the build process
echo for example changing Release type, Build type etc
echo To switch, type the option after the Value:
echo ----------------------------------------------------------------------
echo.
echo Release: prerelease - retail
echo Build Type: fre - chk
echo Timebomb Fuse: days
REM echo To Change Build Dir: build-out
REM echo To Change Postbuild Dir: post-out
echo.
echo I will slowly add more here over time
echo ----------------------------------------------------------------------
echo back) Return
echo.
set /p bldopt=:
if /i "%bldopt%"=="prerelease" goto PreBuildset
if /i "%bldopt%"=="retail" goto RTMBuildset
if /i "%bldopt%"=="fre" goto buildfre
if /i "%bldopt%"=="chk" goto buildchk
if /i "%bldopt%"=="days" goto Timebomb
if /i "%bldopt%"=="back" goto mainmenu
goto BuildOptions

REM

:PreBuildSet
REM
REM These next two sections are simply used to echo the appropriate 'prerelease.inc'
REM depending on Retail or Prerelease.. Reason why I chose this? It is more reliable than my intended method
REM
REM
REM
REM
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
REM
REM I compaired variables set by Razzle for CHK and FRE, and tried to allow the user to switch
REM variables/ release type depending on their choice.
REM THIS IS NOT TESTED!
REM
echo.
echo Setting Razzle variables to Free
pause
set _BuildType=fre
set NTDEBUG=ntsdnodbg
set _BuildBins=binaries in: %_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set _BuildWTitle=Build Window: %_BuildArch%/%_BuildType%/full opt/%_BuildBins%
set _NTPOSTBLD=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set _NTTREE=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set _NT%_BuildArch%TREE=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set BINPLACE_LOG=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%\build_logs\binplace.log
goto BuildOptions

:buildchk
echo.
echo Setting Razzle variables to Checked
timeout /t 3
set _BuildType=chk
set NTDEBUG=ntsd
set _BuildBins=binaries in: %_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set _BuildWTitle=Build Window: %_BuildArch%/%_BuildType%/full opt/%_BuildBins%
set _NTPOSTBLD=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set _NTTREE=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set _NT%_BuildArch%TREE=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%
set BINPLACE_LOG=%_NTDRIVE%\binaries.%_BuildArch%%_BuildType%\build_logs\binplace.log
goto BuildOptions
REM :buildoutputdir
REM :postbuildoutdir

:Timebomb
REM
REM This section backs up the original timebomb.cmd to timebomb.orig, and leaves it there for user
REM We take the users input, and use the VB Script at :replacetextvbs (%RazzleToolPath%\replace.vbs)
REM to replace the "set DAYS=" line.
echo.
echo Backing up timebomb.cmd
if not exist "%~d0%_NTROOT%\tools\postbuildscripts\timebomb.orig" (copy "%~d0%_NTROOT%\tools\postbuildscripts\timebomb.cmd" "%~d0%_NTROOT%\tools\postbuildscripts\timebomb.orig") else (echo Original timebomb.cmd backup exists)
REM if exist "%~d0%_NTROOT%\tools\postbuildscripts\timebomb.cmd" del tools\postbuildscripts\timebomb.cmd
echo.
echo Enter Days For Timebomb:
echo (0, 5, 15, 30, 60, 90, 120, 150, 180, 240, 360, 444)
set /p tbombfuse=:
echo Setting Timebomb to %tbombfuse% Days
echo.
"%~dp0\replace.vbs" tools\postbuildscripts\timebomb.cmd "set DAYS=*" "set DAYS=%tbombfuse%"
pause
goto BuildOptions
REM 
REM
REM
REM goto BuildOptions
	
	
:AssetError
cls
echo.
echo Error finding on or more assets needed my Easy-Build!
echo.
echo pause
exit




:easypatcherinit
cls
echo.
echo Patches will have to be manually applied for now. This will hopefully change later.
echo This is because the possibility of user and patch edits being overwritten by 'easy-patcher',
echo and due to the patches being hosted on MEGA for now (Links below).
echo.
echo 1) View patch links
echo 2  Main Menu
echo.
set /p _PatcherSelect=

if /i "%_PatcherSelect%" == "1" goto OpenXPPatchLinks
if /i "%_PatcherSelect%" == "2" goto mainmenu
goto easypatcherinit


:OpenXPPatchLinks
echo.
echo All Patches are current (As per my knowledge), and uploaded to
echo a single MEGA Folder for ease.
echo.
echo LINK: 
echo https://mega.nz/folder/zgwkmIzC#7qLVjgdwokMQyoccDEUbBA/folder/zh4gjA7D
echo.
pause
goto mainmenu

:AMD64Error
cls
echo.
echo ERROR: You are building for AMD64, but "%_NTDRIVE%\binaries.x86%_BuildType%" is MISSING.
echo.
pause
exit






REM Good suggestion from an Anon on 4chan, option to auto run the prebuild.cmd
:easyautoprebuild
cls
echo.
echo You are seeing this screen because Easy-Build has detected that:
echo 'prebuild.cmd' has not been ran yet..
echo.
echo To run Prebuild Scripts now, press Y otherwise press N.
echo RECOMMENDED TO RUN NOW IF YOU KNOW YOU HAVEN'T ALREADY.
echo.
set /p easyprebld=Continue with Prebuild?
if /i "%easyprebld%"=="y" goto easyautoprestart
if /i "%easyprebld%"=="n" goto easynoprestart
goto easyautoprebuild

REM Here we run the Prebuild script and notes a file to tell this script that Prebuild has been complete
:easyautoprestart
call %~dp0\prebuild.cmd&& echo Prebuild_done >> %~dp0\easy-prebuild-done.txt
pause
goto mainmenu

REM This is for the prebuild warning, just echos that user skipped prebuild warning, most likely because they want to manually do it
:easynoprestart
echo Prebuild_skipped >> %~dp0\easy-prebuild-done.txt
goto mainmenu



REM This is used when Easy-Build needs to restart, mainly after patching
:easyrestart
echo.
echo Easy-Build needs to restart for changes to take effect.
pause
start "" /I /D %~dp0 %~dp0\easy-build.cmd
goto EOF





:easyassetextract
REM REMOVED
goto init

REM
REM This section changes file permissions of the NT root folder and contents
REM
:attribchange
echo.
echo It seems the latest Source Prepatches are not installed, we will
echo presume that Easy-Build is running UNMODIFIED Source..
echo If this is the case, we NEED to change the NT directory to Read-Write.
echo.
echo Setting File Attributes to Read/Write.
echo This could take a long time. Afterwards Easy-Patcher will load to patch your Source.
echo.
pause
if exist %~d0\srv03rtm (attrib -R -H %~d0\srv03rtm\*.* /S) else (attrib -R -H %~d0\XPSP1\*.* /S)
echo.
echo Done
goto easypatcherinit

:EOF
exit /b