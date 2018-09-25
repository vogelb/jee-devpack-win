@echo off
rem ================================================
rem DevPack: Get the configured default JDK
rem ================================================
call %CONF_DIR%\devpack.bat
call %CONF_DIR%\packages.bat
setlocal enabledelayedexpansion
echo %TOOLS_DIR%\!%DEVPACK_DEFAULT_JDK%_FOLDER!



