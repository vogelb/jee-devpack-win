@echo off
rem *******************************************************
rem Open the JEE DevPack Workspace
rem Mount it if not already mounted
rem *******************************************************
call bin\mount_devpack.bat
explorer %WORKSPACE%
