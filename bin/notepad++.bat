@echo off
rem ************************************************
rem Java DevPack: Start notepad ++
rem ************************************************
set EXECUTABLE=%USERPROFILE%\scoop\shims\notepad++.exe
if NOT "%1" == "" (
  if exist %1\ (
    echo Open as Workspace: %1
    call start "" "%EXECUTABLE%" -openFoldersAsWorkspace "%1"
	exit
  )
)

echo Open as File: call "%EXECUTABLE%" %*
call start "" "%EXECUTABLE%" %*
exit
