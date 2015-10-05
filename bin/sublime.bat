@echo off
rem ************************************************
rem JEE DevPack: Start sublime editor
rem ************************************************
call %~dp0\..\setenv
if not exist %TOOLS_DIR%\sublime (
	echo.
	echo Sublime text is not installed.
	echo Please set INSTALL_SUBLIME to TRUE in install.bat and start the installation.
	goto :EOF
)

start %TOOLS_DIR%\sublime\sublime_text %*
