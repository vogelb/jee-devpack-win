@echo off
rem ************************************************
rem JEE DevPack: Start sublime editor
rem ************************************************
call %~dp0w_mount_drive.bat

rem Initialise command line...
set EDIT_CMD_LINE_ARGS=
:startInit
if %1a==a goto endInit
set EDIT_CMD_LINE_ARGS=%EDIT_CMD_LINE_ARGS% %1
shift
goto startInit
:endInit

start %WORKING_DIR%\tools\sublime\sublime_text %EDIT_CMD_LINE_ARGS%
