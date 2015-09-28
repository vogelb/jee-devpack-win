@echo off
rem ===================================================================
rem Console Start Script
rem Please configure the desired eclipse version and workspace location
rem ===================================================================
call bin\w_mount_drive.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
start console -w "JEE Console" -d "%WORKSPACE%"
