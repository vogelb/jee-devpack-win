@echo off
rem ************************************************
rem Java DevPack: Start explorer
rem ************************************************
where %DEVPACK_EXPLORER% >NUL
if errorlevel 1 (
  echo.
  echo Configured explorer %DEVPACK_EXPLORER% does not exist.
  echo Defaulting to explorer
  start explorer %*
  exit /B
)
start %DEVPACK_EXPLORER% %*

