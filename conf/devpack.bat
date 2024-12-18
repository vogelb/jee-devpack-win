@echo off
rem ===================================================================
rem Java DevPack Configuration
rem ===================================================================

rem Load base config.
if exist %~dp0devbase.bat call %~dp0devbase.bat

if "%DEVPACK_BASE%" == "" (
	set DEVPACK_BASE=c:\dev\devpack
)

rem Set the working drive letter here. The default is W.
set WORK_DRIVE=W
set DEVPACK_NAME=Java Dev Pack

rem Set the default JDK
set DEVPACK_DEFAULT_JDK=OPENJDK17

rem Set the default Maven
set DEVPACK_DEFAULT_MAVEN=MAVEN_3_6

rem Extend command prompt with git branch
set DEVPACK_GIT_PROMPT=TRUE

rem Select the development shell (terminal, console or cmd)
set DEVPACK_CONSOLE=terminal
rem The name of the development shell
set DEVPACK_CONSOLE_NAME=Dev Shell
rem The start folder of the development shell
rem set DEVPACK_CONSOLE_FOLDER=%WORK_DRIVE%:\git

rem Extend command shell with colour
set DEVPACK_COLOUR=TRUE

rem Use virtual harddisk
rem Set to true to install DevPack in a virtual disk
set DEVPACK_VHD=FALSE

rem Tools (java, maven, eclipse, ...) installation dir
rem Set to a global folder in order to reuse installed packages
set TOOLS_DIR=%WORK_DRIVE%:\tools

rem You may customize your eclipse workspace location here
set WORKSPACE=%WORK_DRIVE%:\workspace

rem Public maven settings
set PUBLIC_M2_CONFIG=%WORK_DRIVE%:\conf\mvn-public-settings.xml

rem Private maven settings (e.g. server passwords)
set PRIVATE_M2_CONFIG=%WORK_DRIVE%:\conf\mvn-private-settings.xml

rem Maven Toolchains configuration
set M2_TOOLCHAINS=%WORK_DRIVE%:\conf\toolchains.xml

rem Auto-Generate toolchains (after setup install / uninstall / purge)
set GENERATE_M2_TOOLCHAINS=TRUE

rem Configure your favorite editor here
rem set DEVPACK_EDITOR=%WORK_DRIVE%:\tools\atom\atom.exe
set DEVPACK_EDITOR=%WORK_DRIVE%:\bin\notepad++.bat

rem Configure additional path elements here
rem set DEVPACK_PATH_EXTENSION=d:\dev

rem Configure your favorite file explorer here
set DEVPACK_EXPLORER=explorer

set DEVPACK_GIT_USER=your.git.user

set DEVPACK_GIT_EMAIL=your.email.address

rem Set your Cygwin home to enable cygwin integration
set CYGWIN_HOME=c:\cygwin
