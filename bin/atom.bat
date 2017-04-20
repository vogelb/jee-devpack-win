@echo off
rem ************************************************
rem JEE DevPack: Start atom editor
rem ************************************************
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not exist %TOOLS_DIR%\atom (
	echo.
	echo Atom is not installed.
	echo Please set INSTALL_ATOM to TRUE in install.bat and start the installation.
	exit /B
)

start %TOOLS_DIR%\atom\atom %*
