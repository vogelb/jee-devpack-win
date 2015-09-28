@echo off
rem =====================================
rem sbt Wrapper for JEE Devpack
rem =====================================

if not exist %TOOLS_DIR%\sbt (
	echo.
	echo Scala / sbt is not installed.
	echo Please set INSTALL_SCALA to TRUE in install.bat and start the installation.
	goto :EOF
)

rem call sbt
%TOOLS_DIR%\sbt\bin\sbt %*