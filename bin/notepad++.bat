@echo off
rem ************************************************
rem Java DevPack: Start notepad ++
rem ************************************************
echo %1
if exist %1\ (
  echo Open as Workspace: %1
  call start %WORK_DRIVE%:\tools\npp\notepad++.exe -openFoldersAsWorkspace %1
) else (
  echo Open as File: call %WORK_DRIVE%:\tools\npp\notepad++.exe %*
  call %WORK_DRIVE%:\tools\npp\notepad++.exe %*
)
exit