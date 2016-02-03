@echo off
rem ===================================================================
rem Mount JEE DevPack working drive
rem The drive letter can be configured in conf/devpack.bat
rem ===================================================================
call %~dp0..\conf\devpack.bat

if exist %WORK_DRIVE%:\ goto EOF

echo Mounting Work Container as drive %WORK_DRIVE%...
rem subst %WORK_DRIVE%: %~dp0..

cd /d %~dp0..

set MOUNT_SCRIPT=%~dp0mount_devpack.dps
if "%DEVPACK_VHD%" == "TRUE" (
	echo select vdisk file=%cd%\devpack.vhd > %MOUNT_SCRIPT%
	echo attach vdisk >> %MOUNT_SCRIPT%
	echo assign letter=%WORK_DRIVE% >> %MOUNT_SCRIPT%
	diskpart /s %MOUNT_SCRIPT%
) else (
	subst %WORK_DRIVE%: %cd%
)
	
rem Store base dir in configuration...
echo|set /p="set DEVPACK_BASE=" > %~dp0..\conf\devbase.bat
cd >> %~dp0..\conf\devbase.bat

:EOF
