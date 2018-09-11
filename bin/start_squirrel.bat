@echo off
rem ===================================================================
rem JEE DevPack: Start Squirrel SQL client
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if not exist %TOOLS_DIR%\squirrel (
  echo.
  echo Squirrel SQL is not installed.
  echo Please set INSTALL_SQUIRREL to TRUE in your template and start the installation.
  exit /B
)

:start
call %TOOLS_DIR%\squirrel\squirrel-sql.bat
