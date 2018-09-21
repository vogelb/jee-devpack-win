@echo off
rem =====================================
rem Maven Wrapper for JEE Devpack
rem - Use maven from the dev pack
rem - Use maven setting from the dev pack
rem =====================================

:loop_commandline
if "%1" == "-s" goto private_settings_found
if "%1" == "-gs" goto private_settings_found
if "%1" == "--global-toolchains" goto toolchain_settings_found
goto endloop_commandline

:private_settings_found
  shift
  set PRIVATE_M2_CONFIG=%1
  goto loop_commandline

:public_settings_found
  shift
  set PUBLIC_M2_CONFIG=%1
  goto loop_commandline
  
:toolchain_settings_found
  shift
  set M2_TOOLCHAINS=%1
  goto loop_commandline

:endloop_commandline

set M2_SETTINGS=-gs %PUBLIC_M2_CONFIG% -s %PRIVATE_M2_CONFIG% --global-toolchains %M2_TOOLCHAINS%

rem call maven
%M2_HOME%\bin\mvn %M2_SETTINGS% %*
