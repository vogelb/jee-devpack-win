@echo off
rem ===================================================================
rem Console Start Script, e.g. for eclipse terminal
rem ===================================================================
if exist %WORKSPACE% (
	set START_DIR="%WORKSPACE%"
) else (
	set START_DIR="%WORK_DRIVE%:"\
)
cmd /d %START_DIR% /k "%WORK_DRIVE%:\setenv.bat && echo Welcome to Windows DevPack"
