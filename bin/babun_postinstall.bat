@echo off
echo calling %TOOLS_DIR%\%BABUN_EXPLODED%\install.bat /t %TOOLS_DIR%

call "%TOOLS_DIR%\%BABUN_EXPLODED%\install.bat" /t "%TOOLS_DIR%"
if errorlevel 1 set BABUN_ERROR=TRUE

echo cleaning up...
rmdir /S /Q "%TOOLS_DIR%\.babun" >NUL

if "%BABUN_ERROR%" == "TRUE" (
echo.
  echo ---
	echo %BABUN_NAME% was not correctly installed. Please see above error log.
	echo DevPack installation aborted!
	exit /B
) else (
	echo %BABUN_NAME% installation done.	
)
