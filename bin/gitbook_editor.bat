@echo off
rem ===================================================================
rem Start Sourcetree
rem ===================================================================
call %~dp0mount_devpack.bat

if not exist %TOOLS_DIR%\gitbook-editor (
  echo.
  echo GitBook Editor is not installed. Please set INSTALL_GITBOOK_EDITOR to TRUE in your template and start installation.
  exit /B
)

cd /d %WORK_DRIVE%:\
call setenv.bat
call %TOOLS_DIR%\gitbook-editor\Editor.exe %*
