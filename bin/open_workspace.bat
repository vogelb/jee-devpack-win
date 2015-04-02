@echo off
rem *******************************************************
rem Open the JEE DevPack Workspace
rem Mount it if not already mounted
rem *******************************************************
call _mount_w_drive.bat
explorer %WORK_DRIVE%:\
