@echo off
rem ===================================================================
rem Start Postgres database server
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not "%PG_HOME%" == "" if exist %PG_HOME% goto start

echo.
echo PostgreSQL is not installed.
echo Please set INSTALL_POSTGRES to TRUE in your template and start the installation.
exit /B

:start
%PG_HOME%\bin\pg_ctl stop


