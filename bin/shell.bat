@echo off
rem ===================================================================
rem Console Start Script, e.g. for eclipse terminal
rem ===================================================================
call %~dp0..\bin\mount_devpack.bat
if not "%1" == "" (
  set START_DIR=%WORK_DRIVE%:\%1
) else (
  if exist "%WORKSPACE%" (
    set START_DIR="%WORKSPACE%"
  ) else (
    set START_DIR="%WORK_DRIVE%:"\
  )
)

cmd /d %START_DIR% /k "%WORK_DRIVE%:\setenv.bat && cd /d %START_DIR% && echo Welcome to %DEVPACK_NAME%"
