@echo off
rem ===================================================================
rem Start Postgres database server
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not "%PG_HOME%" == "" if exist %PG_HOME% goto start

echo.
echo PostgreSQL is not installed.
echo Please set INSTALL_POSTGRES to TRUE in your template and start the installation.
exit /B

:start
if not exist %PGDATA% (
	echo Initializing data directory %PGDATA%...
	initdb --encoding UTF8
	if errorvelel 1 exit /B
	echo.
	echo done.
	echo The default user is %USERNAME%. You can create a database using "createdb".
)

%PG_HOME%\bin\pg_ctl -D "%PGDATA%" -l postgres.log start