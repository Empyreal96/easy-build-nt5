@echo off
if "%_BuildType%" == "fre" goto x86fre
if "%_BuildType%" == "chk" goto x86chk

:x86fre
cd /d %~dp0
echo %CD%
mkdir %~dp0\win2003_x86-missing-binaries_v2
%~dp0\7za.exe x %~dp0\win2003_x86-missing-binaries_v2.7z -o%~dp0\win2003_x86-missing-binaries_v2
cd /d %~d0
if exist %~dp0\srv03rtm\ds\security\gina\winlogon del %~dp0\win2003_x86-missing-binaries_v2\binaries.x86fre\winlogon.*
if exist %~d0\binaries.x86fre\duser.dll del %~dp0\win2003_x86-missing-binaries_v2\binaries.x86fre\duser.*
xcopy  %~dp0\win2003_x86-missing-binaries_v2\binaries.x86fre\* %~d0\binaries.x86fre\ /Y /V /E /H /C /I /R /O
echo Patching complete, please restart Easy-Build and Razzle..
pause
exit /b

:x86chk
cd /d %~dp0
echo %CD%
mkdir %~dp0\win2003_x86-missing-binaries_v2
%~dp0\7za.exe x %~dp0\win2003_x86-missing-binaries_v2.7z -o%~dp0\win2003_x86-missing-binaries_v2
cd /d %~d0
if exist %~dp0\srv03rtm\ds\security\gina\winlogon del %~dp0\win2003_x86-missing-binaries_v2\binaries.x86chk\winlogon.*
if exist %~d0\binaries.x86chk\duser.dll del %~dp0\win2003_x86-missing-binaries_v2\binaries.x86chk\duser.*
xcopy  %~dp0\win2003_x86-missing-binaries_v2\binaries.x86chk\* %~d0\binaries.x86chk\ /Y /V /E /H /C /I /R /O
echo Patching complete, please restart Easy-Build and Razzle..
pause
exit /b
