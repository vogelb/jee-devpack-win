@echo off
rem ===================================================================
rem Console Start Script
rem ===================================================================
call %~dp0bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\

if "%DEVPACK_CONSOLE_FOLDER%" == "" (
	set START_DIR=%WORK_DRIVE%:\\
) else (
	set START_DIR=%DEVPACK_CONSOLE_FOLDER%
)

if "%1" == "-embed" (
     %WORK_DRIVE%:\bin\shell.bat %2 %3 %4 %5 %6
)

if "%DEVPACK_CONSOLE%" == "console" if exist %TOOLS_DIR%\console (
	start %TOOLS_DIR%\console\conemu.exe -reuse -dir "%START_DIR%" -run cmd ""/K call %WORK_DRIVE%:\setenv.bat""
	goto :EOF
)

if "%DEVPACK_CONSOLE%" == "terminal" (
	start wt nt --title "%DEVPACK_CONSOLE_NAME%" --startingDirectory "%START_DIR%" cmd ""/K call %WORK_DRIVE%:\setenv.bat"
	goto :EOF
)

start "%DEVPACK_CONSOLE_NAME%" cmd /K call %WORK_DRIVE%:\setenv.bat

:EOF
