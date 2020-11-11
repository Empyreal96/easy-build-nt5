@echo off
cd /d %~dp0
echo %CD%
echo START
mkdir %~dp0\winlogon200X_v3b
%~dp0\7za.exe x %~dp0\winlogon200X_v3b.zip -o%~dp0\winlogon200X_v3b
cd /d %~dp0
cd ..
cd ..
xcopy  %~dp0\winlogon200X_v3b\winlogon\* .\ds\security\gina\winlogon /Y /V /E /H /C /I /R /O
xcopy  %~dp0\winlogon200X_v3b\userenv\main\* .\ds\security\gina\userenv\main /Y /V /E /H /C /I /R /O
xcopy  %~dp0\winlogon200X_v3b\msgina\* .\ds\security\gina\msgina /Y /V /E /H /C /I /R /O
echo Patching complete, please clean build next build..
pause
exit /b