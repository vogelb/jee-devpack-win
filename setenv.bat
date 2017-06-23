@echo off
rem ================================================
rem DevPack: Setup Environment
rem ================================================

call %~dp0conf\devpack.bat

set WORKING_DIR=%WORK_DRIVE%:\
set CONF_DIR=%WORKING_DIR%conf
set TEMPLATE_DIR=%WORKING_DIR%templates
set BIN_DIR=%WORKING_DIR%bin
set SOURCE_DIR=%WORKING_DIR%source

set M2_HOME=%TOOLS_DIR%\mvn
set JAVA_HOME=%TOOLS_DIR%\jdk_8

if "%DEVPACK_OPATH%" == "" goto save_path

goto main

:include_config <configPath>
if exist %CONF_DIR%\%1.bat call %CONF_DIR%\%1.bat
exit /B

:save_path 
set DEVPACK_OPATH=%PATH%
goto main 

rem -------------------------------------------------
:main
rem -------------------------------------------------

set PATH=%DEVPACK_OPATH%

rem -----------------------------------------------------------------
rem load optional package configuration
call :include_config postgres
call :include_config jboss
call :include_config tomcat
call :include_config forge
call :include_config scala
call :include_config git
call :include_config meld
call :include_config node
call :include_config vagrant
call :include_config dotnet

rem -----------------------------------------------------------------
rem Add workspace parameters as required
set PATH=%BIN_DIR%;%JAVA_HOME%\bin;%WORKING_DIR%;%PATH%

rem -----------------------------------------------------------------
rem Define command aliases
doskey mci=mvn clean install
doskey mcp=mvn clean package
doskey st=sourcetree.bat

rem Add more aliases for your convenience...
doskey ..=cd ..
doskey ...=cd ..\..

exit /B
