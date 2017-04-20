@echo off
rem =================================
rem Java DevPack: Load ANSICON driver
rem =================================
set ANSICON_HOME=%TOOLS_DIR%\ansic0n
setlocal
if exist %ANSICON_HOME% (
  if exist "%PROGRAMFILES(X86)%" (
    %ANSICON_HOME%\x64\ansicon -p
  ) else (
    %ANSICON_HOME%\x86\ansicon -p
  )
)
