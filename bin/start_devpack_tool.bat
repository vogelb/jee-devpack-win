@echo off
rem ===================================================================
rem Devpack Start Script
rem ===================================================================
call %~dp0mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

echo Starting %1 ...
start /B %1 cmd /c %2
