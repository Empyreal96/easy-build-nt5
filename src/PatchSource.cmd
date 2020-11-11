@echo off
cd /d %~dp0
echo START
if Exist %~dp0\win2k3_prepatched_v10 rmdir %~dp0\win2k3_prepatched_v10 /Q/S
mkdir %~dp0\win2k3_prepatched_v10
%~dp0\7za.exe x %~dp0\win2k3_prepatched_v10.zip -o%~dp0\win2k3_prepatched_v10
move %~dp0\win2k3_prepatched_v10\_x64  %~dp0\
cd /d %~dp0
cd ..
cd ..
echo %CD%
xcopy  %~dp0\win2k3_prepatched_v10\* .\ /Y /V /E /H /C /I /R /O
if NOT exist %WinDir%\SysWOW64 (echo No need for x64 host patches.) else (xcopy %~dp0\_x64\* .\ /Y /V /E /H /C /I /R /O)
echo Patching complete, please restart Easy-Build and Razzle..
pause
exit /b