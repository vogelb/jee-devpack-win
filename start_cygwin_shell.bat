@echo off
rem ===================================================================
rem Cygwin condole Start Script
rem Please configure the desired eclipse version and workspace location
rem ===================================================================
call %~dp0bin\mount_devpack.bat
if not exist %CYGWIN_HOME% (
	echo.
	echo Cygwin is not installed.	
	goto :EOF
)
call %WORK_DRIVE%:\setenv.bat
cd /d %WORKSPACE%
console -t Cygwin -c %WORK_DRIVE%:\conf\console.xml
