@echo off
rem ************************************************
rem Java DevPack: Start editor
rem ************************************************
set EDITOR_FOUND=
if exist "%DEVPACK_EDITOR%" set EDITOR_FOUND=1
if not defined EDITOR_FOUND (
  where %DEVPACK_EDITOR% >nul 2>nul && set EDITOR_FOUND=1
)

if not defined EDITOR_FOUND (
  echo.
  echo Configured editor %DEVPACK_EDITOR% does not exist as a file and was not found on PATH.
  echo Defaulting to notepad
  start notepad %*
) else (
  start %DEVPACK_EDITOR% %*
)
