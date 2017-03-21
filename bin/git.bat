@echo off && setlocal
rem ===================================================================
rem DevPack git wrappper
rem Displays git branch in the command prompt.
rem ===================================================================
git.exe %*
if "%DEVPACK_GIT_PROMPT%" == "TRUE" (
  set GITBRANCH=
  for /f "tokens=2" %%I in ('git.exe branch 2^> NUL ^| findstr /b "* "') do set GITBRANCH=%%I

  if "%GITBRANCH%" == "" (
    prompt $P$G 
  ) else (
    prompt $P $C$E[1;7;32;47m%GITBRANCH%$E[0m$F $G 
  )
) else (
  prompt $P$G 
)
