@echo off
rem ===================================================================
rem JEE DevPack: Start Glassfish server
rem ===================================================================
call setenv.bat

if not exist %JBOSS_HOME% (
	echo.
	echo Wildfly is not installed.
	echo Please set INSTALL_WILDFLY to TRUE in your template and start the installation.
	goto :EOF
)

call %JBOSS_HOME%\bin\standalone.bat
