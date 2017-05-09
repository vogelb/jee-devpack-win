@echo off
rem ************************************************
rem Java DevPack: Start editor
rem ************************************************
if not exist %DEVPACK_EDITOR% (
  echo.
  echo Configured editor %DEVPACK_EDITOR% does not exist.
  echo Defaulting to notepad
  start notepad %*
) else (
 start %DEVPACK_EDITOR% %*
)
