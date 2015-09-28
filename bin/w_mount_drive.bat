@echo off
rem ===================================================================
rem Mount JEE DevPack working drive
rem The drive letter can be configured in conf/devpack.bat
rem ===================================================================
call %~dp0..\conf\devpack.bat

if exist %WORK_DRIVE%:\ goto EOF

echo Mounting Work Container as drive %WORK_DRIVE%...
subst %WORK_DRIVE%: .

:EOF
