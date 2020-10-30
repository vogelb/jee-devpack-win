@echo off
rem ===================================================================
rem Console Start Script
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if exist %WORKSPACE% (
	set START_DIR=%WORKSPACE%
) else (
	set START_DIR=%WORK_DRIVE%:\
)

if exist %TOOLS_DIR%\console (
	start %TOOLS_DIR%\console\conemu.exe -reuse -dir "%START_DIR%" -run cmd ""/K call %WORK_DRIVE%:\setenv.bat""
) else (
	cmd /K call %WORK_DRIVE%:\setenv.bat
)
