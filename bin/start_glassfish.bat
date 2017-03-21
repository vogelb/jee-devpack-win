@echo off
rem ===================================================================
rem JEE DevPack: Start Glassfish server
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if exist %TOOLS_DIR%\glassfish goto start
echo.
echo Glassfish is not installed.
echo Please set INSTALL_GLASSFISH to TRUE in your template and start the installation.
exit /B

:start
call %TOOLS_DIR%\glassfish\bin\asadmin.bat start-domain
