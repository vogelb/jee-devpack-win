@echo off
rem ===================================================================
rem Console Start Script
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat

if exist %WORKSPACE% (
	set START_DIR="%WORKSPACE%"
) else (
	set START_DIR="%WORK_DRIVE%:"\
)

if exist %TOOLS_DIR%\console (
	console -d %START_DIR%" -r "/K call %WORK_DRIVE%:\setenv.bat" -c conf\console.xml
) else (
	cmd /K call %WORK_DRIVE%:\setenv.bat
)
