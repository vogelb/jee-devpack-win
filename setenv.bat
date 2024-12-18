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

for /f %%i in ('%BIN_DIR%\default_jdk.bat') do set JAVA_HOME=%%i
if not exist %JAVA_HOME%\bin\java.exe call :default_jdk

for /f %%i in ('%BIN_DIR%\default_maven.bat') do set M2_HOME=%%i
if not exist %M2_HOME%\bin\mvn.cmd call :default_maven

goto main

:default_jdk
echo WARNING: Configured JDK %JAVA_HOME% is not installed.
set JAVA_HOME=%TOOLS_DIR%\jdk_8
exit /B

:default_maven
echo WARNING: Configured Maven %M2_HOME% is not installed.
set M2_HOME=%TOOLS_DIR%\mvn
exit /B

:include_config <configPath>
if exist %CONF_DIR%\%1.bat call %CONF_DIR%\%1.bat
exit /B

rem -------------------------------------------------
:main
rem -------------------------------------------------

title Dev Console [%DEVPACK_NAME%]

echo Using Java %JAVA_HOME% / Maven %M2_HOME%

if "%DEVPACK_OPATH%" == "" set DEVPACK_OPATH=%PATH%
set PATH=%DEVPACK_OPATH%

rem -----------------------------------------------------------------
rem load optional package configuration
call :include_config postgres
call :include_config jboss
call :include_config tomcat
call :include_config tomee
call :include_config forge
call :include_config scala
call :include_config git
call :include_config meld
call :include_config node
call :include_config vagrant
call :include_config dotnet
call :include_config gradle
call :include_config vstudio
call :include_config ant

rem -----------------------------------------------------------------
rem Add workspace parameters as required
set PATH=%BIN_DIR%;%DEVPACK_PATH_EXTENSION%;%JAVA_HOME%\bin;%WORKING_DIR%;%PATH%

rem -----------------------------------------------------------------
rem Define command aliases
doskey st=sourcetree.bat

rem Add more aliases for your convenience...
doskey ..=go ..
doskey ...=go ..\..
doskey -=go -

exit /B
