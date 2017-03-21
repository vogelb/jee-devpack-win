@echo off
rem ===================================================================
rem DevPack: Start H2 database
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
java -cp %JBOSS_HOME%\modules\system\layers\base\com\h2database\h2\main\h2-1.3.173.jar org.h2.tools.Server
