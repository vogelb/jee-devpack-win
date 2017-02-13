@echo off
rem ===================================================================
rem JEE DevPack: Start Glassfish server
rem ===================================================================
call %~dp0conf\devpack.bat

if not exist %TOOLS_DIR%\glassfish (
	echo.
	echo Glassfish is not installed.
	echo Please set INSTALL_GLASSFISH to TRUE in your template and start the installation.
	goto :EOF
)

call %TOOLS_DIR%\glassfish\bin\asadmin.bat start-domain
