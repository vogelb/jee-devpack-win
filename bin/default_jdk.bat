@echo off
rem ================================================
rem DevPack: Get the configured default JDK
rem ================================================
call %~dp0..\conf\devpack.bat
call %~dp0..\conf\packages.bat
setlocal enabledelayedexpansion
echo %TOOLS_DIR%\!%DEVPACK_DEFAULT_JDK%_FOLDER!



