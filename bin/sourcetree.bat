@echo off
rem ************************************************
rem Java DevPack: Start sourcetree
rem ************************************************
if not exist %TOOLS_DIR%\sourcetree (
  echo.
  echo SourceTree is not installed. Please set INSTALL_SOURCETREE to TRUE in your template and start installation.
  exit /B
)
echo Starting SourceTree...
start %TOOLS_DIR%\sourcetree\sourcetree %*
