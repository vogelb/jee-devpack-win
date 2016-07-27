@echo off
rem ===================================================================
rem JEE DevPack Configuration
rem ===================================================================

rem Load base config.
if exist %~dp0devbase.bat call %~dp0devbase.bat

if "%DEVPACK_BASE%" == "" (
	set DEVPACK_BASE=c:\dev\devpack
)

rem Use virtual harddisk
rem Set to true to install DevPack in a virtual disk
set DEVPACK_VHD=TRUE

rem Set the working drive letter here. The default is W.
set WORK_DRIVE=W

rem Tools (java, maven, eclipse, ...) installation dir
rem Set to a global folder in order to reuse installed packages
set TOOLS_DIR=%WORK_DRIVE%:\tools

rem You may customize your eclipse workspace location here
set WORKSPACE=%WORK_DRIVE%:\workspace

rem Public maven settings
set PUBLIC_M2_CONFIG=%WORK_DRIVE%:\conf\mvn-public-settings.xml

rem Private maven settings (e.g. server passwords)
set PRIVATE_M2_CONFIG=%WORK_DRIVE%:\conf\mvn-private-settings.xml

rem Configure your favourite editor here
rem set EDITOR=%WORK_DRIVE%:\tools\sublime\sublime_text.exe
set EDITOR=%WORK_DRIVE%:\tools\npp\notepad++.exe

rem The default SVN and GIT user name is the system account name.
