@echo off
rem ===================================================================
rem Eclipse Start Script
rem Please configure the desired eclipse version (ECLIPSE_HOME)
rem Please configure your workspace location in conf/devpack.bat
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
call bin\sourcetree.bat
