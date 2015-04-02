@echo off
rem ===================================================================
rem Init Workspace
rem Create workspace folder and checkout Eclipse Settings.
rem ===================================================================
call %~dp0conf\devpack.bat
call setenv.bat

if not exist %WORKSPACE% goto create_workspace
echo %WORKSPACE% already exists. Please backup / delete / rename.
goto workspace_done

:create_workspace
mkdir %WORKSPACE%

:workspace_done

rem echo.
rem echo Installing toolchains.xml...
rem if not exist %HOMEDRIVE%%HOMEPATH%\.m2\toolchains.xml goto toolchains
rem echo File %HOMEDRIVE%%HOMEPATH%\.m2\toolchains.xml already exists. Left it alone.
rem goto svn_roots

rem :toolchains
rem copy %~dp0\conf\toolchains.xml %HOMEDRIVE%\%HOMEPATH%\.m2
rem echo Copied toolchains.xml to %HOMEDRIVE%\%HOMEPATH%\.m2

rem Initialize SVN repositories for the new workspace.
rem Copy %WORKSPACE%\.metadata\.plugins\org.tigris.subversion.subclipse.core\.svnProviderState to %CONF_DIR%/svn_roots to save your SVN repos.
rem :svn_roots
rem echo.
rem echo Configuring SVN Roots...
rem mkdir %WORKSPACE%\.metadata\.plugins\org.tigris.subversion.subclipse.core
rem copy %CONF_DIR%\svn_roots %WORKSPACE%\.metadata\.plugins\org.tigris.subversion.subclipse.core\.svnProviderState

:done
echo Init Workspace done.
pause