@echo off
rem ===================================================================
rem JEE DevPack: Start Squirrel SQL client
rem ===================================================================
call bin\mount_devpack.bat
cd /d %WORK_DRIVE%:\
call setenv.bat
call "%userprofile%\scoop\apps\squirrel-sql\current\squirrel-sql.bat"
