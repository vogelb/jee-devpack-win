@echo off
rem ===================================================================
rem Eclipse Start Script
rem Please configure the desired eclipse version (ECLIPSE_HOME)
rem Please configure your workspace location in conf/devpack.bat
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
set ECLIPSE_EE_HOME=%TOOLS_DIR%\eclipse_ee

if not exist %ECLIPSE_EE_HOME% (
	echo.
	echo Eclipse EE is not installed.
	echo Please set INSTALL_ECLIPSE to EE in your template and start the installation.
	goto :EOF
)

start %ECLIPSE_EE_HOME%\eclipse.exe -vm %JAVA_HOME%\bin -data %WORKSPACE% -vmargs -Xms515m -Xmx1024m
