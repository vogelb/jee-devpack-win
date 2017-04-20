@echo off
rem ===================================================================
rem Eclipse Start Script
rem Please configure the desired eclipse version (ECLIPSE_HOME)
rem Please configure your workspace location in conf/devpack.bat
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
set ECLIPSE_HOME=%TOOLS_DIR%\eclipse

if not exist %ECLIPSE_HOME% (
	echo.
	echo Eclipse is not installed.
	echo Please set INSTALL_ECLIPSE to JAVA, EE or CPP in your template and start the installation.
	goto :EOF
)

start %ECLIPSE_HOME%\eclipse.exe -vm %JAVA_HOME%\bin -data %WORKSPACE% -vmargs -Xms515m -Xmx1024m
