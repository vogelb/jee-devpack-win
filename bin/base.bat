@echo off
rem ===================================================================
rem Open the current path on the "physical" drive.
rem ===================================================================
setlocal
for /f %%I in ('echo %CD% ^| cut -d: -f2') do set path_remainder=%%I
( endlocal
	go %DEVPACK_BASE%%path_remainder%
)