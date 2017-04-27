@echo off
rem ===================================================================
rem Eclipse Start Script
rem Please configure the desired eclipse version (ECLIPSE_HOME)
rem Please configure your workspace location in conf/devpack.bat
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
set VS_HOME=%TOOLS_DIR%\vstudio

if not exist %VS_HOME% (
	echo.
	echo Visual Studio Code is not installed.
	echo Please set INSTALL_VS to TRUE in your template and start the installation.
	goto :EOF
)

if not exist %WORKSPACE% mkdir %WORKSPACE%
start %VS_HOME%\code.exe %WORKSPACE%
