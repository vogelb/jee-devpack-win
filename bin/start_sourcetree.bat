@echo off
rem ===================================================================
rem Eclipse Start Script
rem Please configure the desired eclipse version (ECLIPSE_HOME)
rem Please configure your workspace location in conf/devpack.bat
rem ===================================================================
call bin\w_mount_drive.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
if not exist %TOOLS_DIR%\sourcetree (
	echo.
	echo SourceTree is not installed.
	echo Please set INSTALL_SOURCETREE to TRUE in your template and start the installation.
	goto :EOF
)

start %TOOLS_DIR%\sourcetree\SourceTree
