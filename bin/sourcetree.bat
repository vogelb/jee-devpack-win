@echo off
rem ************************************************
rem Java DevPack: Start sourcetree
rem ************************************************
if not exist %TOOLS_DIR%\sourcetree (
  echo.
  echo SourceTree is not installed. Please set INSTALL_SOURCETREE to TRUE in your template and start installation.
  exit /B
)

setlocal
set FOLDER=%1
if "%FOLDER%"=="" (
  set FOLDER=%CD%
)

echo Starting SourceTree in folder %FOLDER%
start %TOOLS_DIR%\sourcetree\sourcetree %FOLDER%
