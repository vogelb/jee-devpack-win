@echo off
rem *******************************************************
rem Open the JEE DevPack Workspace
rem Mount it if not already mounted
rem *******************************************************
call bin\w_mount_drive.bat
explorer %WORK_DRIVE%:\
