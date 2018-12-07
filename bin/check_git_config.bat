@echo off
rem ===================================================================
rem Java DevPack: Check Git Config
rem ===================================================================
if "%DEVPACK_GIT_USER%" == "" (
  echo DevPack configuration DEVPACK_GIT_USER not set.
  exit /B 1
)

call git config --global user.name | findstr %DEVPACK_GIT_USER% >nul
if errorlevel 1 (
  call git config --global user.name %DEVPACK_GIT_USER%
  echo Git user name set to %DEVPACK_GIT_USER%
)

if "%DEVPACK_GIT_EMAIL%" == "" (
  echo DevPack configuration DEVPACK_GIT_EMAIL not set.
  exit /B 1
)

call git config --global user.email | findstr %DEVPACK_GIT_EMAIL% >nul
if errorlevel 1 (
  call git config --global user.email %DEVPACK_GIT_EMAIL%
  echo Git email address set to %DEVPACK_GIT_EMAIL%
)