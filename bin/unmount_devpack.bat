@echo off
rem ===================================================================
rem Unmount JEE DevPack Working Drive
rem ===================================================================
call %~dp0..\conf\devpack.bat

if not exist %WORK_DRIVE%:\ exit /B

echo Unmounting Working Drive %WORK_DRIVE%...
subst /D %WORK_DRIVE%:

