@echo off
rem ===================================================================
rem DevPack git wrappper
rem Displays git branch in the command prompt.
rem ===================================================================
git.exe %*
if "%DEVPACK_GIT_PROMPT%" == "TRUE" (
  for /f "tokens=2" %%I in ('git.exe branch 2^> NUL ^| findstr /b "* "') do (
    if "%DEVPACK_COLOUR%" == "TRUE" (
	  call ansicon
	  prompt $P $C$E[32m%%I$E[0m$F $G
	) else (
	  prompt $P $C%%I$F $G
	)
	exit /B
  )
)
prompt $P$G