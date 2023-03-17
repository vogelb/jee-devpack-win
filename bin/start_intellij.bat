@echo off
rem ===================================================================
rem IntelliJ Start Script
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
if "%INTELLIJ_HOME%" == "" (
  set INTELLIJ_HOME=%TOOLS_DIR%\intellij
)

if not exist %INTELLIJ_HOME% (
	echo.
	echo Intellij is not installed.
	echo Please set INSTALL_INTELLIJ to true in your template and start the installation.
	goto :EOF
)

start %INTELLIJ_HOME%\bin\idea.bat
