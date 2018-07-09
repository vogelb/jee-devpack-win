@echo off
rem ===================================================================
rem Devpack Start Script
rem ===================================================================
call c:\dev\devpack\bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

echo Starting %1 ...
start /B %1 cmd /c %2
