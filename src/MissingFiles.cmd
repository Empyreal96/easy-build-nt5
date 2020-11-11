@echo off
cd /d %~dp0
echo %CD%
mkdir %~dp0\2k3-missing-x86fre-v8
%~dp0\7za.exe x %~dp0\2k3-missing-x86fre-v8.7z -o%~dp0\2k3-missing-x86fre-v8
cd /d %~d0
if exist %~dp0\srv03rtm\ds\security\gina\winlogon del %~dp0\2k3-missing-x86fre-v8\winlogon.*
if exist %~d0\binaries.x86fre\duser.dll del %~dp0\2k3-missing-x86fre-v8\duser.dll
if exist %~d0\binaries.x86fre\duser.dll del %~dp0\2k3-missing-x86fre-v8\duser.pdb
xcopy  %~dp0\2k3-missing-x86fre-v8\* %~d0\binaries.x86fre /Y /V /E /H /C /I /R /O
echo Patching complete, please restart Easy-Build and Razzle..
pause
exit /b