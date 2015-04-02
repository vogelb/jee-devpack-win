@echo off
rem ================================================
rem DevPack: Setup Environment
rem ================================================
call %~dp0conf\devpack.bat
set CONF_DIR=%WORK_DRIVE%:\conf
set WORKING_DIR=%WORK_DRIVE%:\
set TOOLS_DIR=%WORKING_DIR%tools
set BIN_DIR=%WORKING_DIR%bin
set M2_HOME=%WORKING_DIR%tools\mvn

set M2_HOME=%TOOLS_DIR%\mvn
set FORGE_HOME=%TOOLS_DIR%\forge-distribution-1.0.0.Final
set JAVA_HOME=%TOOLS_DIR%\jdk_8
set JBOSS_HOME=%TOOLS_DIR%\wildfly

rem -----------------------------------------------------------------
rem Add workspace parameters as required
rem set PUBLIC_M2_CONFIG=%WORKING_DIR%\conf\public-mvn-settings.xml
rem set PRIVATE_M2_CONFIG=%WORKING_DIR%\conf\private-mvn-settings.xml

set PATH=%JAVA_HOME%\bin;%M2_HOME%\bin;%FORGE_HOME%\bin;%PATH%
