@echo off & setlocal
rem ===================================================================
rem Java EE DevPack Installation Script
rem - Download and install binary packages
rem - To Update a package, remove the exploded folder from the dev pack
rem - Adjust download paths in order to pick up another version
rem
rem Included packages:
rem - Oracle JDK
rem - RedHat Wildfly
rem - Apache Maven
rem - Eclipse JEE package
rem - Notepad++
rem - JBoss Forge
rem ===================================================================
rem
rem Setup configuration

rem Set DOWNLOADS_DIR in order to reuse existing downloads
set DOWNLOADS_DIR=%~dp0downloads

rem KEEP_PACKAGES: If set to true, downloaded packages will not be deleted after installation
set KEEP_PACKAGES=TRUE

rem ===================================================================

set TEMPLATE_DIR=%~dp0templates
set LAST_TEMPLATE=%TEMPLATE_DIR%\template.bat
set SETUP_WORKING_DRIVE=%~d0
set SETUP_WORKING_DIR=%~dp0
set BIN_DIR=%~dp0bin
set CONF_DIR=%~dp0conf

if exist %LAST_TEMPLATE% call %LAST_TEMPLATE%
if not "%SELECTED_TEMPLATE%" == "" (
	set TEMPLATE=%TEMPLATE_DIR%\%SELECTED_TEMPLATE%
) else (
	set TEMPLATE=%TEMPLATE_DIR%\default.bat
)
set DOWNLOADS=%DOWNLOADS_DIR%\download_packages.txt
set DEBUG=FALSE
set TAB=	
set VERSION_FILE=version.txt
set GIT_REPO=--git-repo--

:loop_commandline
if "%1" == "-debug" goto debug_found
goto test_template

:debug_found
  shift
  set DEBUG=TRUE
  echo on
  goto loop_commandline

:test_template
  if "%1" == "-t" goto template_found
  goto endloop_commandline

:template_found
  shift
  set TEMPLATE=%TEMPLATE_DIR%\%1.bat
  shift
  goto loop_commandline

:endloop_commandline
set COMMAND=%1
shift

if not exist %TEMPLATE% echo. && echo Template %TEMPLATE% not found. && echo Exiting... && goto done

echo Using template %TEMPLATE%...

call :get_filename TEMPLATE_NAME %TEMPLATE%
echo set SELECTED_TEMPLATE=%TEMPLATE_NAME%>%LAST_TEMPLATE%

rem Unmount mounted drive. Might be another instance!
set DEVPACK_BASE=
call %SETUP_WORKING_DIR%\conf\devpack.bat

rem If installation is started from running devpack, restart from base dir.
if "%WORK_DRIVE%:" == "%SETUP_WORKING_DRIVE%" (
  echo Restarting installation from base dir %DEVPACK_BASE%...
  cd /d %DEVPACK_BASE%
  %DEVPACK_BASE%\setup.bat %*
  goto done
)

call %SETUP_WORKING_DIR%\bin\unmount_devpack.bat
if exist %WORK_DRIVE%:\ (
  echo.
  echo The configured work drive [%WORK_DRIVE%] is already in use.
  echo Installation cancelled.
  goto done
)

rem ===== Mount work drive and read configuration ====
call %SETUP_WORKING_DIR%\bin\mount_devpack.bat

cd /d %WORK_DRIVE%:\

set WGET=%SETUP_WORKING_DIR%\bin\wget
set WGET_OPTIONS=--no-check-certificate --no-cookies

if "%DEVPACK_COLOUR%" == "TRUE" (
  call %BIN_DIR%\ansicon.bat
  set PROMPT_NOT_INSTALLED=[31mnot installed[0m
  set PROMPT_INSTALLED=[32minstalled[0m
  set PROMPT_OUTDATED=[31mout of date[0m
  set PROMPT_MANUALLY_INSTALLED=[33minstalled[0m
  set PROMPT_UNINSTALLED=[33muninstalled[0m
  set PROMPT_WARN=[31mWarning[0m
  set PROMPT_OK=[32mok[0m
) else (
  set PROMPT_NOT_INSTALLED=not installed
  set PROMPT_INSTALLED=installed
  set PROMPT_OUTDATED=out of date
  set PROMPT_UNINSTALLED=uninstalled
  set PROMPT_WARN=Warning
  set PROMPT_OK=ok
)

rem ===== Read Package Configuration =====
call %SETUP_WORKING_DIR%\conf\packages.bat
call %TEMPLATE%

if "%INSTALL_ECLIPSE%" == "JAVA" (
  set INSTALL_ECLIPSE_JAVA=TRUE
)

if "%INSTALL_ECLIPSE%" == "EE" (
  set INSTALL_ECLIPSE_EE=TRUE
)

if "%INSTALL_ECLIPSE%" == "CPP" (
  set INSTALL_ECLIPSE_CPP=TRUE
)

if "%COMMAND%" == "info" goto info
if "%COMMAND%" == "status" goto info
if "%COMMAND%" == "install" goto install_devpack
if "%COMMAND%" == "update" goto update_devpack
if "%COMMAND%" == "download" goto download
if "%COMMAND%" == "purge" goto purge
if "%COMMAND%" == "uninstall" goto uninstall
if "%COMMAND%" == "clean" goto clean_devpack
if "%COMMAND%" == "packages" goto list_packages
if "%COMMAND%" == "templates" goto list_templates

echo.
echo J2EE Devpack setup
echo.
echo Usage: setup [-t template] command
echo.
echo Available commands:
echo   status                    - Show currently installed packages
echo   install [^<packageName^>]   - Install DevPack / configured / single packages
echo   update [^<packageName^>]    - Update DevPack / configured / single packages
echo   download                  - Only download packages
echo   purge                     - Remove disabled packages
echo   uninstall [^<packageName^>] - Uninstall DevPack / single package
echo   packages                  - List available packages
echo   templates                 - List available templates
:list_templates
echo.
echo Available templates:
dir /B templates | findstr .bat | findstr /V template.bat

goto done

rem ======================================================================
rem List available packages
:list_packages
setlocal enabledelayedexpansion
echo.
echo List of available packages:
echo.
echo Package ID%TAB%%TAB%Package%TAB%%TAB%%TAB%Version
echo =============================================================
for %%p in ( %DEVPACK_PACKAGES% )  do (
  set PACKAGE=%%p
  set SELECTED=!INSTALL_%%p!
  set OPTION=!%%p_NAME!
  set VERSION=!%%p_VERSION!
  
  call :strlen PACKAGE_LEN PACKAGE
  call :strlen OPTION_LEN OPTION
    
  if !PACKAGE_LEN! LEQ 7 (
    echo | set /p=!PACKAGE!%TAB%%TAB%%TAB%
  ) else if !PACKAGE_LEN! LEQ 14 (
    echo | set /p=!PACKAGE!%TAB%%TAB%
  ) else (
    echo | set /p=!PACKAGE!%TAB%
  )
  
  if !OPTION_LEN! LEQ 7 (
    echo | set /p=!OPTION!%TAB%%TAB%%TAB%
  ) else if !OPTION_LEN! LEQ 15 (
    echo | set /p=!OPTION!%TAB%%TAB%
  ) else (
    echo | set /p=!OPTION!%TAB%
  )
  echo !VERSION!
)
endlocal
exit /B

rem ======================================================================
rem Update selected packages
:update_devpack
setlocal enabledelayedexpansion
echo.
echo Start Update of Java EE DevPack
echo ===============================
echo.

if not "%1" == "" (
  call :update_single_package %1
) else (
  for %%p in ( %DEVPACK_PACKAGES% ) do (
    set PACKAGE=%%p
    set SELECTED=!INSTALL_%%p!
    if "!SELECTED!" == "TRUE" (
      call :update_single_package !PACKAGE!
      if !ERRORLEVEL! neq 0 (
        exit /B !ERRORLEVEL!
      )  
    )
  )
  if "%INSTALL_ECLIPSE%" == "EE" (
    call :update_single_package ECLIPSE_EE
  )
  if "%INSTALL_ECLIPSE%" == "JAVA" (
    call :update_single_package ECLIPSE_JAVA
  )
  if "%INSTALL_ECLIPSE%" == "CPP" (
    call :update_single_package ECLIPSE_CPP
  )
  if "%INSTALL_SCALA%" == "TRUE" (
    call :update_single_package SBT
  )
)
echo.
echo All done.

exit /B

rem ======================================================================
rem Install selected packages
:install_devpack

echo.
echo Start Installation of Java EE DevPack
echo =====================================
echo.

if not "%1" == "" (
  call :download_and_install_single_package %1
) else (

  findstr /m "SET SVN_USER" conf\devpack.bat > NUL
  if %errorlevel%==0 goto install_devpack_do
  set SVN_USER=%USERNAME%
  setlocal enabledelayedexpansion
  for %%a in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z" "Ä=ä" "Ö=ö" "Ü=ü") do (
    set "SVN_USER=!SVN_USER:%%~a!"
  )
  echo set SVN_USER=%SVN_USER% >> conf\devpack.bat
  endlocal

:install_devpack_do
  call :download
  call :install
)

echo.
echo All done.

exit /B

rem ======================================================================
rem Download and install a single package
:download_and_install_single_package <packageName>
setlocal enabledelayedexpansion
set PACKAGE_NAME=!%1_NAME!

if "%PACKAGE_NAME%" == "" (
  echo.
  echo Unknown package %1.
  echo Use   setup packages   to display the list of available packages.
  echo.
  exit /B
)

echo.
echo Downloading...
if exist %DOWNLOADS% del %DOWNLOADS%
if not exist %DOWNLOADS_DIR% mkdir %DOWNLOADS_DIR%
call :download_package %1
call :execute_downloads
echo.
echo Installing...
call :install_single_package %1
exit /B

rem ======================================================================
rem Install a single package
:install_single_package <packageName>
setlocal enabledelayedexpansion
set PACKAGE_TYPE=%1_TYPE
call :expand_variable PACKAGE_TYPE

if "!PACKAGE_TYPE!" == "JDK6" (
    call :install_jdk_6 %1
) else if "!PACKAGE_TYPE!" == "JDK7" (
    call :install_jdk %1
) else if "!PACKAGE_TYPE!" == "JDK" (
    call :install_jdk %1
) else if "!PACKAGE_TYPE!" == "MSI" (
    call :install_msi_package %1
) else if "!PACKAGE_TYPE!" == "NUPKG" (
    call :install_nupkg_package %1
) else if "!PACKAGE_TYPE!" == "ZIP" (
    call :install_zip_package %1
) else if "!PACKAGE_TYPE!" == "NPM" (
    call :install_npm_package %1
) else (
    echo Error installing package %1: Unknown package type "!PACKAGE_TYPE!"
)
endlocal
exit /B

rem ======================================================================
rem Get installed version
:get_installed_version <packageName> <outputVar>
set PACKAGE_TARGET=%1_FOLDER
set PACKAGE_URL=%1_URL
set PACKAGE_TYPE=%1_TYPE
call :expand_variable PACKAGE_TARGET
call :expand_variable PACKAGE_TYPE
call :expand_variable PACKAGE_URL

set PACKAGE_VERSION_FILE=%TOOLS_DIR%\!PACKAGE_TARGET!\%VERSION_FILE%
if "!PACKAGE_TYPE!" == "NPM" (
  set PACKAGE_VERSION_FILE=%TOOLS_DIR%\nodejs\node_modules\!PACKAGE_URL!\%VERSION_FILE%
)

if exist "%PACKAGE_VERSION_FILE%" (
  
  @for /F "tokens=*" %%a in ('type "%PACKAGE_VERSION_FILE%"') do (
    set %2=%%a
    exit /b %errorlevel%
  )
)
exit /B

rem ======================================================================
rem Update a single package
:update_single_package <packageName>
setlocal enabledelayedexpansion
set PACKAGE=%1
set PACKAGE_NAME=%1_NAME
set PACKAGE_VERSION=%1_VERSION
set PACKAGE_TARGET=%1_FOLDER

call :expand_variable PACKAGE_NAME
call :expand_variable PACKAGE_VERSION
call :expand_variable PACKAGE_TARGET
call :get_installed_version %PACKAGE% INSTALLED_VERSION

echo | set /p=Package !PACKAGE_NAME!... 

if "!INSTALLED_VERSION!" == "" (
  set INSTALLED_VERSION=-not installed-
)

if not "!INSTALLED_VERSION!" == "!PACKAGE_VERSION!" (
  echo out of date.
  echo Updating from version !INSTALLED_VERSION! to !PACKAGE_VERSION!
  
  call :uninstall_package %PACKAGE%
  if !errorlevel! gtr 0 (
    exit /B !errorlevel!
  )
  call :download_and_install_single_package %PACKAGE%
  
) else (
  echo up to date: !INSTALLED_VERSION!
)

endlocal
exit /B 0

rem ======================================================================
rem Download selected packages
:download
echo.
echo -^> Downloading packages...
setlocal enabledelayedexpansion

if not exist %TOOLS_DIR% mkdir %TOOLS_DIR%
if exist %DOWNLOADS% del %DOWNLOADS%
if not exist %DOWNLOADS_DIR% mkdir %DOWNLOADS_DIR%

for %%p in ( %DEVPACK_PACKAGES% ) do (
  set DOWNLOAD_PACKAGE=INSTALL_%%p
  call :expand_variable DOWNLOAD_PACKAGE
  
  if "!DOWNLOAD_PACKAGE!" == "TRUE" (
    call :download_package %%p
  )
)

if "%INSTALL_ECLIPSE%" == "EE" (
  call :download_package ECLIPSE_EE
)
if "%INSTALL_ECLIPSE%" == "JAVA" (
  call :download_package ECLIPSE_JAVA
)
if "%INSTALL_ECLIPSE%" == "CPP" (
  call :download_package ECLIPSE_CPP
)

call :execute_downloads

exit /B 0


rem ======================================================================
rem Download JDK6
:download_jdk6
if "%INSTALL_JDK6%" == "TRUE" (
  echo | set /p=Package JDK 6... 
  if not exist %TOOLS_DIR%\%JDK6_FOLDER% if not exist "%DOWNLOADS_DIR%\%JDK6_PACKAGE%" (
    echo.
	echo.
	echo #####################################################################################################
    echo JDK 6 cannot be automatically downloaded because it requires an Oracle web account.
    echo Please Download it manually and place into the configured download folder %DOWNLOADS_DIR%.
	echo Installation cancelled.
	echo #####################################################################################################
    echo.
    exit /B 
  )
  echo already available.
)

exit /B 0

rem ======================================================================
rem Download JDK8 32bit
:download_single_package <packageSpec>
setlocal enabledelayedexpansion
set PACKAGE=%1
set PACKAGE_NAME=%1_NAME
set PACKAGE_OPTIONS=%1_OPTIONS
set PACKAGE_FOLDER=%1_FOLDER
set PACKAGE_PACKAGE=%1_PACKAGE

call :expand_variable PACKAGE_NAME
call :expand_variable PACKAGE_FOLDER
call :expand_variable PACKAGE_PACKAGE

echo URL=!%PACKAGE%_URL!
echo | set /p=Package !PACKAGE_NAME!... 
if not exist %TOOLS_DIR%\!PACKAGE_FOLDER! if not exist "%DOWNLOADS_DIR%\%PACKAGE_PACKAGE%" (
  echo %WGET% !%PACKAGE%_OPTIONS! --directory-prefix %DOWNLOADS_DIR% !%PACKAGE%_URL!
  %WGET% !%PACKAGE%_OPTIONS! --directory-prefix %DOWNLOADS_DIR% !%PACKAGE%_URL!
  exit /B 0
)
echo already available.

exit /B 0

rem ======================================================================
rem Execute download of marked packages.
:execute_downloads
if not exist %DOWNLOADS% goto done
echo.
echo Downloading files:
type %DOWNLOADS%

rem Provide user and prompt for password if required (e.g. download from internal nexus or web space)
rem echo Please provide your nexus credentials.
rem wget --directory-prefix %TOOLS_DIR% --http-user=%SVN_USER% --ask-password -i %DOWNLOADS%
%WGET% %WGET_OPTIONS% --directory-prefix %DOWNLOADS_DIR% -i %DOWNLOADS%

del %DOWNLOADS%

exit /B

rem ======================================================================
rem Print DevPack status information
:info
echo.
echo Setup Information
echo =================
if exist conf\template.bat (
  echo Currently installed template: %TEMPLATE%
  echo.
  echo Base path: %DEVPACK_BASE%
  echo Workdrive: %WORK_DRIVE%
) else (
  echo DevPack is currently not installed!
  echo.
  echo Selected template: %TEMPLATE%
)
echo.
echo Package Status:
echo.

echo Package%TAB%%TAB%%TAB%Version%TAB%%TAB%Status
echo ======================================================================

for %%p in ( %DEVPACK_PACKAGES% )  do (
  call :query_package %%p
)
exit /B

rem ======================================================================
rem Install selected packages
:install
echo.
echo -^> Installing packages...
setlocal enabledelayedexpansion

for %%p in ( %DEVPACK_PACKAGES% ) do (
  set INSTALL_PACKAGE=INSTALL_%%p
  set PACKAGE_TYPE=%%p_TYPE
  call :expand_variable INSTALL_PACKAGE
  call :expand_variable PACKAGE_TYPE
  
  if "!INSTALL_PACKAGE!" == "TRUE" (
    call :install_single_package %%p
  )
)

if "%INSTALL_ECLIPSE%" == "EE" (
  call :install_zip_package ECLIPSE_EE
)
if "%INSTALL_ECLIPSE%" == "JAVA" (
  call :install_zip_package ECLIPSE_JAVA
)
if "%INSTALL_ECLIPSE%" == "CPP" (
  call :install_zip_package ECLIPSE_CPP
)
if "%INSTALL_SCALA%" == "TRUE" (
  call :install_zip_package SBT
)

call %WORK_DRIVE%:\setenv.bat

exit /B

rem ======================================================================
rem Uninstall packages not selected by the current template
:purge
setlocal enabledelayedexpansion
echo.
echo -^> Purging disabled packages...

for %%p in ( %DEVPACK_PACKAGES% ) do (
  set FOUND=FALSE
  for %%n in ( %DEVPACK_NO_PURGE% ) do (
    if %%n == %%p (
	  SET FOUND=TRUE
    )
    if "!FOUND!" == "FALSE" (
      set PURGE_PACKAGE=INSTALL_%%p
      call :expand_variable PURGE_PACKAGE
  
      if not "!PURGE_PACKAGE!" == "TRUE" (
        call :uninstall_package %%p
        if !ERRORLEVEL! neq 0 (
          exit /B !ERRORLEVEL!
        )
        if "%%p" == "SCALA" (
          call :uninstall_package SBT
          if !ERRORLEVEL! neq 0 (
            exit /B !ERRORLEVEL!
          )
		)
      )
	)
  )
)

if "%INSTALL_ECLIPSE%" == "FALSE" (
  call :uninstall_package ECLIPSE_EE
  if !ERRORLEVEL! neq 0 (
    exit /B !ERRORLEVEL!
  )
)
echo.
echo All done.

exit /B

rem ======================================================================
rem Uninstall packages in the DevPack
:uninstall
echo.

if "%1" == "" (
  rem Uninstall all packages
  echo -^> Uninstalling DevPack...
  for %%p in ( %DEVPACK_PACKAGES% ) do (
    call :uninstall_package %%p
  )
) else (
  rem Uninstall single package
  call :uninstall_package %1
)

echo.
echo All done.

exit /B

rem ======================================================================
rem Print the status of a package
rem %1: Package identifier
:query_package
set PACKAGE_SPEC=%~1

setlocal enabledelayedexpansion
set SELECTED=!INSTALL_%PACKAGE_SPEC%!
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

call :strlen OPTION_LEN OPTION 
call :strlen VERSION_LEN VERSION

if %OPTION_LEN% LEQ 7 (
  echo | set /p=%OPTION%%TAB%%TAB%%TAB%
) else if %OPTION_LEN% LEQ 16 (
  echo | set /p=%OPTION%%TAB%%TAB%
) else (
  echo | set /p=%OPTION%%TAB%
)

if NOT "%SELECTED%" == "TRUE" (
  echo | set /p=not selected%TAB%
) else (
  if %VERSION_LEN% LEQ 8 (
    echo | set /p=%VERSION%%TAB%%TAB%
  ) else (
    echo | set /p=%VERSION%%TAB%
  )
)

if not exist "%TOOLS_DIR%\%TARGET%" (
  if "%SELECTED%" == "TRUE" (
    echo | set /p=%PROMPT_NOT_INSTALLED% / 
  ) else (
    echo | set /p=not installed / 
  )
  if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
    echo | set /p=not 
  )
  echo downloaded
) else (
  call :get_installed_version %PACKAGE_SPEC% INSTALLED_VERSION
  if "!INSTALLED_VERSION!" == "%VERSION%" (
    if "%SELECTED%" == "TRUE" (
      echo %PROMPT_INSTALLED% [!INSTALLED_VERSION!]
	) else (
	  echo %PROMPT_MANUALLY_INSTALLED% [!INSTALLED_VERSION!]
	)
  ) else if "%SELECTED%" == "TRUE" (
    echo %PROMPT_OUTDATED% [!INSTALLED_VERSION!]
  ) else (
	echo present
  )
)

exit /B


rem ======================================================================
rem Install a node.js package using npm
rem %1: package identifier
:install_npm_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set VERSION=!%PACKAGE_SPEC%_VERSION!
set URL=!%PACKAGE_SPEC%_URL!
rem Set target folder for version info
set TARGET=nodejs\node_modules\%URL%

if "%OPTION%" == "" (
  echo Unknown package: %PACKAGE_SPEC%
  echo Use   setup packages   to display the list of available packages.
  echo.
  exit /B 1
)

echo | set /p=Package %OPTION%... 

if not exist %TOOLS_DIR%\nodejs (
  echo This package requires node.js. Please add node.js to your DevPack and try again.
  exit /B 1
)

call npm install -g %URL%@%VERSION%

call :postinstall_package

echo Package %OPTION% done.
echo.
exit /B

rem ======================================================================
rem Install an archived package
rem Unzips the package into target folder.
rem %1: package identifier
:install_zip_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

if "%OPTION%" == "" (
  echo Unknown package: %PACKAGE_SPEC%
  echo Use   setup packages   to display the list of available packages.
  echo.
  exit /B
)

echo | set /p=Package %OPTION%... 

if not exist "%TOOLS_DIR%\%TARGET%" (

  if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
    echo Error: Package %PACKAGE% was not downloaded!
    exit /B
  )

  echo installing now.
  pushd %TOOLS_DIR%

  if "%UNZIPPED%" == "--create--" (
    echo | set /p=Unpacking %OPTION% %VERSION% to %TOOLS_DIR%\%TARGET%... 
    %TOOLS_DIR%\7-Zip\7z x -y "%DOWNLOADS_DIR%\%PACKAGE%" -o%TARGET% >NUL
    echo %PROMPT_OK%.
  ) else (
    echo | set /p=Unpacking %OPTION% %VERSION% to %TOOLS_DIR%... 
    %TOOLS_DIR%\7-Zip\7z x -y "%DOWNLOADS_DIR%\%PACKAGE%" -o%TOOLS_DIR% >NUL
    echo %PROMPT_OK%.
  )
  if not "%UNZIPPED%" == "??" (
    if exist %UNZIPPED% (
	  if not exist %TARGET% (
        echo | set /p=Renaming %UNZIPPED% to %TARGET%... 
        move %UNZIPPED% %TARGET% >NUL
        echo ok.
	  )
    )
    if not "%KEEP_PACKAGES%" == "TRUE" del "%DOWNLOADS_DIR%\%PACKAGE%"
  )
  
  call :postinstall_package

  popd
  echo Package %OPTION% done.
  echo.
  exit /B
)
endlocal
echo already installed.
exit /B

rem ======================================================================
rem Install an MSI based installer
rem %1: package identifier
:install_msi_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!
echo.
echo | set /p=Package %OPTION%... 

if not exist "%TOOLS_DIR%\%TARGET%" (

  if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
    echo Error: Package %PACKAGE% was not downloaded!
    exit /B
  )

  echo installing now.
  pushd %TOOLS_DIR%

  echo | set /p=Unpacking %OPTION% %VERSION% to %TOOLS_DIR%\%TARGET%... 
  icacls %DOWNLOADS_DIR%\%PACKAGE% /grant SYSTEM:^(GR^) >NUL
  msiexec /a %DOWNLOADS_DIR%\%PACKAGE% /qn TARGETDIR=%TOOLS_DIR%\%TARGET%
  echo ok.
  
  call :postinstall_package

  popd
  echo Package %OPTION% done.
  echo.
  exit /B
)
endlocal
echo already installed.

exit /B

rem ======================================================================
rem Package post-installation.
rem Create version file, handle configured tools.
:postinstall_package
  echo %VERSION%> "%TOOLS_DIR%\%TARGET%\%VERSION_FILE%"
  
  set CONFIG_NAME=%PACKAGE_SPEC%_CONFIG
  set POSTINSTALL=%PACKAGE_SPEC%_POSTINSTALL
  call :expand_variable CONFIG_NAME
  call :expand_variable POSTINSTALL
  
  if not "!POSTINSTALL!" == "%PACKAGE_SPEC%_POSTINSTALL" (
    if exist %BIN_DIR%\%POSTINSTALL% call %BIN_DIR%\%POSTINSTALL%
  )
  
  if not "!CONFIG_NAME!" == "%PACKAGE_SPEC%_CONFIG" (
    if exist %CONF_DIR%\!CONFIG_NAME!.config copy %CONF_DIR%\!CONFIG_NAME!.config %CONF_DIR%\!CONFIG_NAME!.bat >NUL
  )
  
  for /l %%x in (1, 1, 10) do (
    
    set TOOL_NAME=%PACKAGE_SPEC%_TOOL_%%x
    set TOOL_VALUE=%PACKAGE_SPEC%_TOOL_%%x
    
    call :expand_variable TOOL_VALUE
    
    if NOT "!TOOL_VALUE!" == "!TOOL_NAME!" (
      if exist %~dp0bin\!TOOL_VALUE! copy %~dp0bin\!TOOL_VALUE! %~dp0 >NUL
    )
  )
exit /B

rem ======================================================================
rem Deinstallation routine
rem Remove target folder.
:uninstall_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set TYPE=!%PACKAGE_SPEC%_TYPE!
set URL=!%PACKAGE_SPEC%_URL!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

if "%OPTION%" == "" (
  echo Unknown package: %PACKAGE_SPEC%
  echo Use   setup packages   to display the list of available packages.
  echo.
  exit /B 1
)

echo | set /p=Package %OPTION%... 
if "%TYPE%" == "NPM" (
  where npm >NUL 2>&1
  if errorlevel 1 (
    echo not installed.
    exit /B 0
  )
  call npm uninstall -g %URL%
) else if exist "%TOOLS_DIR%\%TARGET%" (
  pushd %TOOLS_DIR%
  call :clean_folder "%TARGET%"
  if !ERRORLEVEL! neq 0 (
    exit /B !ERRORLEVEL!
  )
  popd
) else (
  echo not installed.
  exit /B 0
)

call :postuninstall_package
  
echo %PROMPT_UNINSTALLED%.
exit /B 0

:postuninstall_package
set CONFIG_NAME=%PACKAGE_SPEC%_CONFIG
    call :expand_variable CONFIG_NAME
    if not "!CONFIG_NAME!" == "" (
      call :clean_file %CONF_DIR%\!CONFIG_NAME!.bat
      if !ERRORLEVEL! neq 0 (
	    exit /B !ERRORLEVEL!
      )
    )
  for /l %%x in (1, 1, 10) do (
    set TOOL_NAME=%PACKAGE_SPEC%_TOOL_%%x
    set TOOL_VALUE=%PACKAGE_SPEC%_TOOL_%%x
    
    call :expand_variable TOOL_VALUE
    
    if NOT "!TOOL_VALUE!" == "!TOOL_NAME!" (
      call :clean_file %~dp0!TOOL_VALUE!
      if !ERRORLEVEL! neq 0 (
	    exit /B !ERRORLEVEL!
      )
    )
  )
exit /B

rem ======================================================================
rem Download routine
rem Add download package to download list
:download_package
set PACKAGE_SPEC=%~1

if "%PACKAGE_SPEC%" == "JDK6" (
  call :download_jdk6
  exit /B
)

setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!
set WGET_OPTIONS=!%PACKAGE_SPEC%_OPTIONS!

echo | set /p=Package %OPTION% [%PACKAGE%]... 
if not exist "%DOWNLOADS_DIR%\%PACKAGE%" if not exist "%TOOLS_DIR%\%TARGET%" (
  if "%PACKAGE%" == "%GIT_REPO%" (
    call :checkout_git_repo %PACKAGE_URL% %TARGET%
  ) else (
    if [!WGET_OPTIONS!] == [] (
      echo %PACKAGE_URL% >> %DOWNLOADS%
      echo marked for download.	
	) else (
	  call :download_single_package %PACKAGE_SPEC%
	)
  )
  exit /B
)
echo already available.
exit /B

rem ======================================================================
rem Checkout a git repository
rem %1: repository URL
rem %2: target folder (will be created) 
:checkout_git_repo
setlocal
set REPO_URL=%1
set REPO_TARGET=%2
if not exist "%REPO_TARGET%" (
  mkdir "%REPO_TARGET%"
)

echo | set /p=Checking out %PACKAGE%... 
git clone %REPO_URL% "%REPO_TARGET%"
echo done.	
exit /B

rem ======================================================================
rem Install a JDK 6 installer
rem  %1 package identifier
:install_jdk_6
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

echo | set /p=Package %OPTION%... 

if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
  echo Error: Package %PACKAGE% was not downloaded!
  exit /B
)
if exist %TOOLS_DIR%\%TARGET% (
  echo already installed.
  exit /B
)

echo installing now.
echo | set /p=extracting package... 
%TOOLS_DIR%\7-Zip\7z x -y %PACKAGE% -o%DOWNLOADS_DIR%\JDK >NUL
pushd %DOWNLOADS_DIR%\JDK

extrac32 .rsrc\JAVA_CAB10\111
echo done.

echo | set /p=extracting tools... 
%TOOLS_DIR%\7-Zip\7z x tools.zip -otools >NUL
echo done.

echo | set /p=unpacking jars... 
cd tools
for /r %%x in (*.pack) do (
  .\bin\unpack200 -r "%%x" "%%~dx%%~px%%~nx.jar"
) 
popd
echo done.

echo | set /p=copying files... 
xcopy /E %DOWNLOADS_DIR%\JDK\tools %TARGET%\ >NUL
echo done.

echo | set /p=cleaning up... 
call :clean_folder %DOWNLOADS_DIR%\JDK
if not "%KEEP_PACKAGES%" == "TRUE" del %PACKAGE%
echo done.
echo Package %OPTION% done.
echo.
exit /B

rem ======================================================================
rem Install a JDK installer (JDK >=7)
rem  %1 package identifier
:install_jdk
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

echo | set /p=Package %OPTION%... 

if exist %TOOLS_DIR%\%TARGET% (
  echo already installed.
  exit /B
)

if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
  echo Error: Package %PACKAGE% was not downloaded!
  exit /B
)

echo installing now.
if not "%INSTALL_JAVA_SOURCE%" == "TRUE" (
  call :install_jdk_without_source %PACKAGE_SPEC%
  exit /B
)

echo extracting package... 
PING 127.0.0.1 -n 3 >NUL

call bin\extract_installer %DOWNLOADS_DIR% %PACKAGE%
IF %ERRORLEVEL% NEQ 0 (
  echo.
  echo Error in installer based installation. Extracting the old way...
  call :install_jdk_without_source %PACKAGE_SPEC%
  exit /B
)
echo extract package done.

pushd %DOWNLOADS_DIR%\extract

echo | set /p=extracting tools... 
%TOOLS_DIR%\7-Zip\7z x tools.zip >NUL
del tools.zip
echo done.

echo | set /p=unpacking jars... 
for /r %%x in (*.pack) do (
  .\bin\unpack200 -r %%x %%~dx%%~px%%~nx.jar >NUL
)
echo done.
popd

echo | set /p=copying files... 
xcopy /E /I /Y %DOWNLOADS_DIR%\extract %TOOLS_DIR%\%TARGET%\ >NUL
echo done.

echo | set /p=cleaning up... 
call :clean_folder %DOWNLOADS_DIR%\extract
if not "%KEEP_PACKAGES%" == "TRUE" del "%DOWNLOADS_DIR%\%PACKAGE%"
echo done.

call :postinstall_package

echo Package %OPTION% done.
echo.
exit /B

rem ======================================================================
rem Install a NUPKG based installer
rem  %1 package identifier
:install_nupkg_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

set EXTRACT=%DOWNLOADS_DIR%\extract
echo | set /p=Package %OPTION%... 
if exist %TOOLS_DIR%\%TARGET% (
  echo already installed.
  exit /B
)

if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
  echo Error: Package %PACKAGE% was not downloaded!
  exit /B
)

echo installing now.

echo | set /p=Extracting package %OPTION%... 

call :clean_folder %EXTRACT%
mkdir %EXTRACT%
pushd %EXTRACT%

%TOOLS_DIR%\7-Zip\7z x %DOWNLOADS_DIR%\%PACKAGE% >NUL
%TOOLS_DIR%\7-Zip\7z x %UNZIPPED% >NUL
echo ok.

echo | set /p=Copying files to %TOOLS_DIR%\%TARGET%...
xcopy "lib\net45\*" "%TOOLS_DIR%\%TARGET%" /S /i >NUL
popd
echo ok.

echo | set /p=Cleaning up...
call :clean_folder %EXTRACT%
echo ok.

call :postinstall_package

echo Package %OPTION% done.
echo.
exit /B

rem ======================================================================
rem Expand variable: Recursively expand the given variable 
rem  %1 variable name
:expand_variable
set var=%1
:expand_loop
if not "!%var%!" == "" (
  set var=!%var%!
  goto :expand_loop
)
set %1=!var!
exit /B

rem ======================================================================
rem "Old" JDK installation procedure: Extract installer and contained CABs
rem %1: Package identifier
:install_jdk_without_source
set PACKAGE_SPEC=%1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

if not exist %DOWNLOADS_DIR%\%PACKAGE% (
  echo Error: Package %PACKAGE% was not downloaded!
  exit /B
)

if exist %TOOLS_DIR%\%TARGET% (
  echo Package %PACKAGE_NAME% is already installed.
  exit /B
)

echo ... extracting package ...
call :clean_folder %DOWNLOADS_DIR%\JDK
%TOOLS_DIR%\7-Zip\7z x -y %DOWNLOADS_DIR%\%PACKAGE% -o%DOWNLOADS_DIR%\JDK >NUL
pushd %DOWNLOADS_DIR%\JDK

echo ... extracting cab files ...
for /d /r %%x in (JAVA_CAB*) do (
  echo ... - extracting %%x...
  for %%y in (%%x\*.*) do (
    %TOOLS_DIR%\7-Zip\7z x -y %%y >NUL
  )
)

echo ... extracting tools ...
%TOOLS_DIR%\7-Zip\7z x -y tools.zip >NUL
if errorlevel 1 (
  echo.
  echo Error extracting files. Installation aborted.
  exit /B
)
del tools.zip

echo ... unpacking jars ...
for /r %%x in (*.pack) do (
  echo ... - unpacking %%x ...
  .\bin\unpack200 -r %%x %%~dx%%~px%%~nx.jar >NUL
)

echo ... cleaning up ...
del .data .pdata .rdata .reloc .text CERTIFICATE
call :clean_folder .rsrc
popd

echo ... copying files ...
xcopy /E /I /Y %DOWNLOADS_DIR%\JDK %TOOLS_DIR%\%TARGET% >NUL
call :clean_folder %DOWNLOADS_DIR%\JDK
if not "%KEEP_PACKAGES%" == "TRUE" del %DOWNLOADS_DIR%\%PACKAGE%
echo ... done.

call :postinstall_package

echo Package %OPTION% done.
echo.
exit /B

rem ======================================================================
rem Clean installing dev pack
rem Remove all user files, e.g. for distribution
:clean_devpack
echo.
echo Cleaning dev pack...
if exist %TOOLS_DIR%\npp (
  call :clean_file %TOOLS_DIR%\npp\session.xml
  call :clean_folder %TOOLS_DIR%\npp\backup
)

if exist workspace (
  echo.
  echo Cleaning workspace... press ctrl-c to abort!
  pause
  for /D /r %%G in ("workspace\*") do (
    if not "%%~nG" == "" (
      echo Removing workspace folder "%%G"
      call :clean_folder %%G
    )
  )
)
echo done
exit /B

rem ======================================================================
rem Get the length of a string
:strlen <resultVar> <stringVar>
(
  setlocal EnableDelayedExpansion
  set "s=!%~2!#"
  set "len=0"
  for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!s:~%%P,1!" NEQ "" ( 
      set /a "len+=%%P"
      set "s=!s:~%%P!"
    )
  )
)
( 
  endlocal
  set "%~1=%len%"
  exit /b
)

rem ======================================================================
rem Delete a file
rem %1: File path
:clean_file <filePath>
if exist %1 (
  del /Q %1 >NUL
  if exist %~1 (
    echo Error cleaning file %~1
    exit /B 1
  )
)
exit /B 0

rem ======================================================================
rem Recursively delete a folder
rem %1: Folder path
:clean_folder <folderPath>
if exist %1 (
  cmd /c rd /S /Q %1 > NUL
  if exist %~1 (
    echo Error cleaning folder %~1
    exit /B 1
  )
)
exit /B 0

rem ======================================================================
rem Get the file name from a path
rem %1: Result variable
rem %2: The Path
:get_filename <resultVar> <filePath>
set %1=%~nx2

:normalizePath <inputPath> <resultVar>
SET %2=%~dpfn1
exit /B

:call_debug
call %*
if "%DEBUG%" == "TRUE" echo on
exit /B

:done
