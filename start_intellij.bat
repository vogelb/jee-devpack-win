@echo off
rem ===================================================================
rem Intellij Start Script
rem Please configure the desired eclipse version (ECLIPSE_HOME)
rem Please configure your workspace location in conf/devpack.bat
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if "%INTELLIJ_HOME%" == "" (
  set INTELLIJ_HOME=C:\Users\BVogel\AppData\Local\JetBrains\IntelliJ IDEA 2024.1.3
  rem set INTELLIJ_HOME=%TOOLS_DIR%\intellij
)

if not exist "%INTELLIJ_HOME%" (
	echo.
	echo Intellij is not installed.
	echo Please set INSTALL_INTELLIJ to true in your template and start the installation.
	goto :EOF
)

start "IntelliJ" "%INTELLIJ_HOME%\bin\idea.bat"
