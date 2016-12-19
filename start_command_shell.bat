@echo off
rem ===================================================================
rem Console Start Script
rem Please configure the desired eclipse version and workspace location
rem ===================================================================
call bin\w_mount_drive.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
console -w "Dev Console" -d "%WORKSPACE%" -r "/K call %WORK_DRIVE%:\setenv.bat" -c conf\console.xml

git.exe %*
set GITBRANCH=
for /f %%I in ('git.exe rev-parse --abbrev-ref HEAD 2^> NUL') do set GITBRANCH=%%I

if "%GITBRANCH%" == "" (
    prompt $P$G 
) else (
    prompt $P $C%GITBRANCH%$F $G 
)

console -w "JEE Console" -d "%WORKSPACE%"
