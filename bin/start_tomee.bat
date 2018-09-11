@echo off
rem ===================================================================
rem JEE DevPack: Start TomEE server
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not "%TOMEE_HOME%" == "" if exist %TOMEE_HOME% goto start

echo.
echo TomEE is not installed.
echo Please set INSTALL_TOMEE to TRUE in your template and start the installation.
exit /B

:start
set CATALINA_HOME=%TOMEE_HOME%
call %CATALINA_HOME%\bin\startup.bat
