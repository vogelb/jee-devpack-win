@echo off
rem ================================================
rem DevPack: Setup Environment
rem ================================================
call %~dp0conf\devpack.bat
set CONF_DIR=%WORK_DRIVE%:\conf
set WORKING_DIR=%WORK_DRIVE%:\
set BIN_DIR=%WORKING_DIR%bin

set M2_HOME=%TOOLS_DIR%\mvn
set FORGE_HOME=%TOOLS_DIR%\forge
set JAVA_HOME=%TOOLS_DIR%\jdk_8
set JBOSS_HOME=%TOOLS_DIR%\wildfly
set CATALINA_HOME=%TOOLS_DIR%\tomee

rem -----------------------------------------------------------------
rem Add workspace parameters as required

set PATH=%BIN_DIR%;%JAVA_HOME%\bin;%FORGE_HOME%\bin;%TOOLS_DIR%\scala\bin;%TOOLS_DIR%\tomee\bin;%PATH%

rem -----------------------------------------------------------------
rem Define command aliases
doskey mci=mvn clean install
doskey mcp=mvn clean package
doskey st=sourcetree

rem Add more aliases for your convenience...
rem doskey ..=cd ..
rem doskey ...=cd ..\..
