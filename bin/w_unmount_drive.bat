@echo off
rem ===================================================================
rem Unmount JEE DevPack Working Drive
rem ===================================================================
call %~dp0..\conf\devpack.bat

if not exist %WORK_DRIVE%:\ goto done

echo | set /p=Unmounting Working Drive %WORK_DRIVE%... 
cd /d %DEVPACK_BASE%

set UNMOUNT_SCRIPT=%~dp0unmount_devpack.dps
if "%DEVPACK_VHD%" == "TRUE" (
	echo select vdisk file=%cd%\devpack.vhd > %UNMOUNT_SCRIPT%
	echo detach vdisk >> %UNMOUNT_SCRIPT%
	diskpart /s %UNMOUNT_SCRIPT%
) else (
	subst /D %WORK_DRIVE%:
)
set MOUNT_ERROR=%ERRORLEVEL%
if errorlevel 1 goto done

echo ok.

:done
EXIT /B %MOUNT_ERROR%
