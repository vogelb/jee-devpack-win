@echo off
rem ===================================================================
rem Console Start Script
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\

if exist %WORKSPACE% (
	set START_DIR=%WORKSPACE%
) else (
	set START_DIR=%WORK_DRIVE%:\
)

if "%1" == "-embed" (
     %WORK_DRIVE%:\bin\shell.bat %2 %3 %4 %5 %6
)

if "%DEVPACK_CONSOLE%" == "console" if exist %TOOLS_DIR%\console (
	start %TOOLS_DIR%\console\conemu.exe -reuse -dir "%START_DIR%" -run cmd ""/K call %WORK_DRIVE%:\setenv.bat""
	goto :EOF
)
start "Dev Shell" cmd /K call %WORK_DRIVE%:\setenv.bat

:EOF
