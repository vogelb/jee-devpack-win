@echo off & setlocal
rem ************************************************
rem Java DevPack: Remove file from git index 
rem and add it to .gitignore
rem ************************************************
set IGNORE_SPEC=%1

if not exist %IGNORE_SPEC% (
  echo File not found: %IGNORE_SPEC%
  exit 2
)
git rm --cached %IGNORE_SPEC% 2>NUL

echo %IGNORE_SPEC:\=/%>>.gitignore
