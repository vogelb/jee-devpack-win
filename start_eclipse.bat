@echo off
rem ===================================================================
rem Eclipse Start Script
rem Please configure the desired eclipse version and workspace location
rem ===================================================================
call bin\w_mount_drive.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
set ECLIPSE_HOME=%WORK_DRIVE%:\tools\eclipse

start %ECLIPSE_HOME%\eclipse.exe -vm %JAVA_HOME%\bin -data %WORKSPACE% -vmargs -Xms515m -Xmx1024m
