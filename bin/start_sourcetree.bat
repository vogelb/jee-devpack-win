@echo off
rem ===================================================================
rem Start Sourcetree
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
call %BIN_DIR%\sourcetree.bat %*
