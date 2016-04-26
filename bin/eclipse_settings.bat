@echo off
rem ************************************************
rem JEE DevPack: Backup Eclipse Settings
rem ************************************************
call %~dp0\..\setenv

set COMMAND=%1

if "%2" == "-w" set WORKSPACE_LOCATION=%3

call :normalize_path %WORKSPACE_LOCATION% WORKSPACE_LOCATION

if "%WORKSPACE_LOCATION%" == "" set WORKSPACE_LOCATION=%WORKSPACE%

set SETTINGS_ROOT=%WORKSPACE_LOCATION%\.metadata\.plugins\
set WORKBENCH_SETTINGS=%SETTINGS_ROOT%\org.eclipse.e4.workbench
set RUNTIME_SETTINGS=%SETTINGS_ROOT%\org.eclipse.core.runtime


if "%COMMAND%" == "store" goto store_settings
if "%COMMAND%" == "restore" goto restore_settings
if "%COMMAND%" == "backup" goto backup_settings

echo.
echo Available commands:
echo - store [-w ^<workspace^>] : Store workspace settings into dev pack
echo - restore [-w ^<workspace^>] : Restore workspace settings from last stored archive
echo - backup [-w ^<workspace^>] : Backup workspace settings to a timestamped archive

exit /b

:store_settings
call :getDate NOW
set ARCHIVE=%CONF_DIR%\eclipse-settings.zip

if exist %ARCHIVE% ren %ARCHIVE% eclipse-settings-%NOW%.zip

7z a %ARCHIVE% %RUNTIME_SETTINGS% %WORKBENCH_SETTINGS%

exit /b

:restore_settings

set ARCHIVE=%CONF_DIR%\eclipse-settings.zip

if not exist %ARCHIVE% echo No stored settings found && exit /b

if not exist %WORKSPACE_LOCATION%\.metadata echo %WORKSPACE_LOCATION% does not seem to be an eclipse workspace. && exit /b

echo Restoring workspace settings...
echo - Workspace: %WORKSPACE_LOCATION%
set /p answer=Overwrite existing settings [y/N]?
if not "%answer%" == "y" exit /b

if exist %RUNTIME_SETTINGS% rmdir /Q /S %RUNTIME_SETTINGS%
if exist %WORKBENCH_SETTINGS% rmdir /Q /S %WORKBENCH_SETTINGS%

7z x -y %ARCHIVE% -o%SETTINGS_ROOT%

exit /b

:backup_settings
call :getDate NOW

set ARCHIVE=%CONF_DIR%\eclipse-settings-%NOW%.zip

echo Backing up workspace settings...
echo - Workspace: %WORKSPACE_LOCATION%
echo - Saved to: %ARCHIVE%

7z a %ARCHIVE% %RUNTIME_SETTINGS% %WORKBENCH_SETTINGS%

exit /b

:getDate
setlocal
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
( endlocal
	set "%1=%datetime:~0,8%"
)
exit /b

:normalize_path
(
  set "%2=%~dpfn1"
)
exit /b

