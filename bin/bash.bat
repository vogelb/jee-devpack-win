@echo off
rem =====================================
rem Open bash shell
rem =====================================

if not exist %CYGWIN_HOME% (
	echo.
	echo Cygwin is not installed.	
	goto :EOF
)

rem start shell
set CHERE_INVOKING=1
%CYGWIN_HOME%\bin\bash --init-file /cygdrive/%WORK_DRIVE%/conf/bash.profile -l
