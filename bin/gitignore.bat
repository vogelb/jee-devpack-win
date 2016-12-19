@echo off
rem ************************************************
rem Java DevPack: Remove file from git index 
rem and add it to .gitignore
rem ************************************************
if not exist %1 (
  echo File not found: %1
  exit 2
)
git rm --cached %1
echo %1>>.gitignore
