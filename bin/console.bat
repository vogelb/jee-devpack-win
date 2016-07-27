@echo off
rem =====================================
rem Console2 wrapper for JEE Devpack
rem =====================================
if not exist %TOOLS_DIR%\console goto cmd_shell
start /b %TOOLS_DIR%\console\console %*
goto done

:cmd_shell
start cmd

:done
