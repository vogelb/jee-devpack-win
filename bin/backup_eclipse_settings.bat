@echo off
rem ************************************************
rem JEE DevPack: Backup Eclipse Settings
rem ************************************************
call %~dp0\..\setenv

set COMMAND=%1

if "%2" == "-w" set WORKSPACE_LOCATION=%3

if "%WORKSPACE_LOCATION%" == "" set WORKSPACE_LOCATION=%WORKSPACE%

if "%COMMAND%" == "store" call :store_settings
if "%COMMAND%" == "store" call :restore_settings
if "%COMMAND%" == "backup" call :backup_settings

exit /b

:store_settings
call :getDate NOW
set ARCHIVE=%CONF_DIR%\eclipse-settings.zip

if exist %ARCHIVE% ren %ARCHIVE% %CONF_DIR%\eclipse-settings-%NOW%.zip

7z a %ARCHIVE% %WORKSPACE_LOCATION%\.metadata\.plugins\org.eclipse.core.runtime\.settings

exit /b

:restore_settings

set ARCHIVE=%CONF_DIR%\eclipse-settings.zip

if not exist %ARCHIVE% echo No stored settings found && exit /b

echo Restoring workspace settings...
echo - Workspace: %WORKSPACE_LOCATION%
set /p answer=Overwrite existing settings [y/N]?
if not "%answer" == "y" exit /b

rmdir /Q /S %WORKSPACE_LOCATION%\.metadata\.plugins\org.eclipse.core.runtime\.settings

if not exist %WORKSPACE_LOCATION%\.metadata\.plugins\org.eclipse.core.runtime mkdir %WORKSPACE_LOCATION%\.metadata\.plugins\org.eclipse.core.runtime

z7 x %ARCHIVE% -o%WORKSPACE_LOCATION%\.metadata\.plugins\org.eclipse.core.runtime

exit /b

:backup_settings
call :getDate NOW

set ARCHIVE=%CONF_DIR%\eclipse-settings-%NOW%.zip

echo Backing up workspace settings...
echo - Workspace: %WORKSPACE_LOCATION%
echo - Saved to: %ARCHIVE%

7z a %ARCHIVE% %WORKSPACE_LOCATION%\.metadata\.plugins\org.eclipse.core.runtime\.settings

exit /b

:getDate
setlocal
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
( endlocal
	set "%1=%datetime:~0,8%"
)
exit /b

