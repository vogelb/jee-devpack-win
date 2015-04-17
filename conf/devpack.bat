@echo off
rem ===================================================================
rem JEE DevPack Configuration
rem ===================================================================

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
