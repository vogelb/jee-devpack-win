@echo off
rem =====================================
rem Maven Wrapper for JEE Devpack
rem - Use maven from the dev pack
rem - Use maven setting from the dev pack
rem =====================================

set M2_SETTINGS=-gs %PUBLIC_M2_CONFIG% -s %PRIVATE_M2_CONFIG%

rem call maven
%M2_HOME%\bin\mvn %M2_SETTINGS% %*
