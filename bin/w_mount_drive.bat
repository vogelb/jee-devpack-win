@echo off
rem ===================================================================
rem Mount JEE DevPack working drive
rem The drive letter can be configured in conf/devpack.bat
rem ===================================================================
call :normalize_path %~dp0.. DEVPACK_BASE
echo set DEVPACK_BASE=%DEVPACK_BASE%> %~dp0..\conf\devbase.bat
call %~dp0..\conf\devpack.bat

if exist %WORK_DRIVE%:\ goto EOF

echo Mounting Work Container as drive %WORK_DRIVE%...
subst %WORK_DRIVE%: %~dp0..

goto :EOF

:normalize_path
(
  set "%2=%~dpfn1"
)
exit /b

:EOF
