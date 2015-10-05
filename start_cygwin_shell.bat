@echo off
rem ===================================================================
rem Cygwin condole Start Script
rem Please configure the desired eclipse version and workspace location
rem ===================================================================
call bin\w_mount_drive.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
start "JEE Console" c:\cygwin\bin\mintty.exe -i /Cygwin-Terminal.ico C:\cygwin\bin\bash.exe -l -c "cd \"%WORKSPACE%\" ; exec bash --init-file <(echo '. /cygdrive/%WORK_DRIVE%/conf/bash.profile')"
