@echo off
rem ===================================================================
rem JEE DevPack: Start Glassfish server
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not "%JBOSS_HOME%" == "" if exist %JBOSS_HOME% goto start
echo.
echo Wildfly is not installed.
echo Please set INSTALL_WILDFLY to TRUE in your template and start the installation.
exit /B

:start
call %JBOSS_HOME%\bin\standalone.bat
