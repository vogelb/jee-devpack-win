@echo off
rem =====================================
rem Maven Wrapper for JEE Devpack
rem - Use maven from the dev pack
rem - Use maven setting from the dev pack
rem =====================================

if "%PRIVATE_M2_CONFIG" == "" (
	set PRIVATE_M2_CONFIG=%HOME%\.m2\settings.xml
	if exist "%CONF_DIR%\mvn-private-settings.xml" (
	  set PRIVATE_M2_CONFIG=%CONF_DIR%\mvn-private-settings.xml 
	)
)

:loop_commandline
if "%1" == "-s" goto private_settings_found
if "%1" == "-gs" goto public_settings_found
if "%1" == "--global-toolchains" goto toolchain_settings_found
goto endloop_commandline

:private_settings_found
  shift
  set PRIVATE_M2_CONFIG=%1
  shift
  goto loop_commandline

:public_settings_found
  shift
  set PUBLIC_M2_CONFIG=%1
  shift
  goto loop_commandline
  
:toolchain_settings_found
  shift
  set M2_TOOLCHAINS=%1
  shift
  goto loop_commandline

:endloop_commandline

set M2_SETTINGS=-gs %PUBLIC_M2_CONFIG% -s %PRIVATE_M2_CONFIG% --global-toolchains %M2_TOOLCHAINS%

rem call maven
echo Using global settings  : %PUBLIC_M2_CONFIG%
echo Using private settings : %PRIVATE_M2_CONFIG%
echo Using Toolchains       : %M2_TOOLCHAINS%
echo Using Java             : %JAVA_HOME%
call %M2_HOME%\bin\mvn %M2_SETTINGS% %*

if "%DEVPACK_GIT_PROMPT%" == "TRUE" (
  for /f "tokens=2" %%I in ('git.exe branch 2^> NUL ^| findstr /b "* "') do (
    if "%DEVPACK_COLOUR%" == "TRUE" (
	  call ansicon
	  prompt $P $C$E[32m%%I$E[0m$F $G
	) else (
	  prompt $P $C%%I$F $G
	)
	exit /B
  )
)
prompt $P$G
