@echo off
rem ===================================================================
rem Console Start Script
rem Please configure the desired eclipse version and workspace location
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
console -w "Dev Console" -d "%WORKSPACE%" -r "/K call %WORK_DRIVE%:\setenv.bat" -c conf\console.xml

