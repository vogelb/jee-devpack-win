@echo off
rem ===================================================================
rem DevPack git wrappper
rem Displays git branch in the command prompt.
rem ===================================================================
git.exe %*
if "%DEVPACK_GIT_PROMPT%" == "TRUE" (
  for /f "tokens=2" %%I in ('git.exe branch 2^> NUL ^| findstr /b "* "') do (
	prompt $P $C$E[1;7;32;47m%%I$E[0m$F $G
	exit /B
  )
)
prompt $P$G