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

rem -----------------------------------------------------------------
rem load optional package configuration
call :include_config %CONF_DIR%\postgres.bat
call :include_config %CONF_DIR%\jboss.bat
call :include_config %CONF_DIR%\tomcat.bat
call :include_config %CONF_DIR%\forge.bat
call :include_config %CONF_DIR%\scala.bat
call :include_config %CONF_DIR%\git.bat
call :include_config %CONF_DIR%\meld.bat
call :include_config %CONF_DIR%\node.bat

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

:include_config <configPath>
if exist %1 call %1
exit /B
