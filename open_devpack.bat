@echo off
rem *******************************************************
rem Open the JEE DevPack Folder
rem Mount it if not already mounted
rem *******************************************************
call %~dp0bin\mount_devpack.bat
explorer %WORK_DRIVE%:\
