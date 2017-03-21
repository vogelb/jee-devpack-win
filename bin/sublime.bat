@echo off
rem ************************************************
rem JEE DevPack: Start sublime editor
rem ************************************************
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not exist %TOOLS_DIR%\sublime (
	echo.
	echo Sublime text is not installed.
	echo Please set INSTALL_SUBLIME to TRUE in install.bat and start the installation.
	exit /B
)

start %TOOLS_DIR%\sublime\sublime_text %*
