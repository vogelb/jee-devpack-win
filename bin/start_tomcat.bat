@echo off
rem ===================================================================
rem JEE DevPack: Start Tomcat server
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not "%TOMCAT_HOME%" == "" if exist %TOMCAT_HOME% goto start

echo.
echo Tomcat is not installed.
echo Please set INSTALL_TOMCAT to TRUE in your template and start the installation.
exit /B

:start
set CATALINA_HOME=%TOMCAT_HOME%
call %CATALINA_HOME%\bin\startup.bat
