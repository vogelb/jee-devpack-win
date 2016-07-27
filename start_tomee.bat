@echo off
rem ===================================================================
rem JEE DevPack: Start Glassfish server
rem ===================================================================
call setenv.bat

if not exist %CATALINA_HOME% (
	echo.
	echo TomEE is not installed.
	echo Please set INSTALL_TOMEE to TRUE in install.bat and start the installation.
	goto :EOF
)

call %CATALINA_HOME%\bin\startup.bat
