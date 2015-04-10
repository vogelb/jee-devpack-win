@echo off
rem =====================================
rem Maven Wrapper for JEE Devpack
rem - Use maven from the dev pack
rem - Use maven setting from the dev pack
rem =====================================

set M2_SETTINGS=-gs %PUBLIC_M2_CONFIG% -s %PRIVATE_M2_CONFIG%

rem Initialise command line...
set MAVEN_CMD_LINE_ARGS=%M2_SETTINGS%
:startInit
if %1a==a goto endInit
set MAVEN_CMD_LINE_ARGS=%MAVEN_CMD_LINE_ARGS% %1
shift
goto startInit
:endInit

rem call maven
%M2_HOME%\bin\mvn %MAVEN_CMD_LINE_ARGS%