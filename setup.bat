@echo off & setlocal
rem ===================================================================
rem JEE DevPack Installation Script
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

rem Set DOWNLOADS_DIR in order to reuse existing downloads  
set DOWNLOADS_DIR=%~dp0downloads

set TEMPLATE_DIR=%~dp0templates

rem KEEP_PACKAGES: If set to true, downloaded packages will not be deleted after installation
set KEEP_PACKAGES=TRUE

set LAST_TEMPLATE=%TEMPLATE_DIR%\template.bat

if exist %LAST_TEMPLATE% call %LAST_TEMPLATE%
if not "%SELECTED_TEMPLATE%" == "" (
	set TEMPLATE=%SELECTED_TEMPLATE%
) else (
	set TEMPLATE=%TEMPLATE_DIR%\default.bat
)
set DOWNLOADS=%DOWNLOADS_DIR%\download_packages.txt
set DEBUG=FALSE
set TAB=	
set GIT_REPO=--git-repo--

:get_commandline
if "%1" == "-debug" goto debug_found
goto test_template

:debug_found
  shift
	set DEBUG=TRUE
	echo on
	goto get_commandline

:test_template
if "%1" == "-t" goto template_found
goto done_commandline

:template_found
  shift
	set TEMPLATE=%TEMPLATE_DIR%\%1.bat
	shift
	goto get_commandline

:done_commandline

set COMMAND=%1

if not exist %TEMPLATE% echo. && echo Template %TEMPLATE% not found. && echo Exiting... && goto done

echo Using template %TEMPLATE%...
	
echo set SELECTED_TEMPLATE=%TEMPLATE%>%LAST_TEMPLATE%

rem Unmount mounted drive. Might be another instance!
set DEVPACK_BASE=
call %~dp0conf\devpack.bat

rem If installation is started from running devpack, restart from base dir.
if "%WORK_DRIVE%:" == "%~d0" (
	echo Restarting installation from base dir %DEVPACK_BASE%...
	cd /d %DEVPACK_BASE%
	%DEVPACK_BASE%\setup.bat %*
	goto done
)

call %~dp0bin\unmount_devpack.bat

if not exist %WORK_DRIVE%:\ goto mount_work_drive
echo.
echo The configured work drive (%WORK_DRIVE%) is already in use.
echo Installation cancelled.
goto done

:mount_work_drive

rem Mount work drive and read configuration
call %~dp0bin\mount_devpack.bat

cd /d %WORK_DRIVE%:\

set WGET=%~dp0bin\wget
set WGET_OPTIONS=--no-check-certificate --no-cookies

call %~dp0conf\packages.bat

rem ===== PACKAGE CONFIGURATION STARTS HERE =====

call %TEMPLATE%

rem ===== END OF PACKAGE CONFIGURATION =====

if "%COMMAND%" == "info" goto info
if "%COMMAND%" == "status" goto info
if "%COMMAND%" == "install" goto install_devpack
if "%COMMAND%" == "download" goto download
if "%COMMAND%" == "purge" goto purge
if "%COMMAND%" == "uninstall" goto uninstall
if "%COMMAND%" == "clean" goto clean_devpack

echo.
echo J2EE Devpack setup
echo.
echo Usage: setup [-t template] command
echo.
echo Available commands:
echo   status    - Show currently installed packages
echo   install   - Install DevPack / configured packages
echo   download  - Only download packages
echo   purge     - Remove disabled packages
echo   uninstall - Uninstall DevPack
echo.
echo Available templates:
dir /B templates

exit /B

:install_devpack
echo.
echo Start Installation of JEE DevPack
echo =================================
echo.

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

echo.
echo All done.

exit /B

:download
echo.
echo -^> Downloading packages...
setlocal enabledelayedexpansion

if not exist %TOOLS_DIR% mkdir %TOOLS_DIR%
if exist %DOWNLOADS% del %DOWNLOADS%
if not exist %DOWNLOADS_DIR% mkdir %DOWNLOADS_DIR%

for %%p in ( %DEVPACK_PACKAGES% )  do (	
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

endlocal

:download_jdk6
if "%INSTALL_JDK6%" == "TRUE" (
	echo | set /p=Package JDK 6... 
	if not exist %TOOLS_DIR%\%JDK6_FOLDER% if not exist "%DOWNLOADS_DIR%\%JDK6_PACKAGE%" (
		echo.
		echo JDK 6 cannot be automatically downloaded because it requires an Oracle web account.
		echo Please Download it manually and place into the configured download folder %DOWNLOADS_DIR%.
		echo Installation cancelled.
		exit /B 
	)
	echo already available.
)

:download_jdk7
if "%INSTALL_JDK7%" == "TRUE" (
	echo | set /p=Package JDK 7... 
	if not exist %TOOLS_DIR%\%JDK7_FOLDER% if not exist "%DOWNLOADS_DIR%\%JDK7_PACKAGE%" (
		echo Downloading now.
		%WGET% %JDK7_OPTIONS% --directory-prefix %DOWNLOADS_DIR% %JDK7_URL%
		goto download_jdk8
	)
	echo already available.
)

:download_jdk8
if "%INSTALL_JDK8%" == "TRUE" (
	echo | set /p=Package JDK 8... 
	if not exist %TOOLS_DIR%\%JDK8_FOLDER% if not exist "%DOWNLOADS_DIR%\%JDK8_PACKAGE%" (
		echo Downloading now.
		%WGET% %JDK8_OPTIONS% --directory-prefix %DOWNLOADS_DIR% %JDK8_URL%
		goto download_jdk8_32
	)
	echo already available.
)

:download_jdk8_32
if "%INSTALL_JDK8_32%" == "TRUE" (
	echo | set /p=Package JDK 8_32... 
	if not exist %TOOLS_DIR%\%JDK8_32_FOLDER% if not exist "%DOWNLOADS_DIR%\%JDK8_32_PACKAGE%" (
		echo Downloading JDK 8_32...
		%WGET% %JDK8_32_OPTIONS% --directory-prefix %DOWNLOADS_DIR% %JDK8_32_URL%
		goto execute_downloads
	)
	echo already available.
)

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

for %%p in ( %DEVPACK_PACKAGES% )  do (	
	call :query_package %%p
)

exit /B

:install
echo.
echo -^> Installing packages...
setlocal enabledelayedexpansion

for %%p in ( %DEVPACK_PACKAGES% )  do (		
	set INSTALL_PACKAGE=INSTALL_%%p
	call :expand_variable INSTALL_PACKAGE
	
	if "!INSTALL_PACKAGE!" == "TRUE" (
		if "%%p" == "JDK6" (
			call :install_jdk_6 %%p
		) else if "%%p" == "JDK7" (
			call :install_jdk %%p
		) else if "%%p" == "JDK8" (
			call :install_jdk %%p
		) else if "%%p" == "JDK8_32" (
			call :install_jdk %%p
		) else if "%%p" == "SOURCETREE" (
			call :install_nupkg_package %%p
		) else if not "%%p" == "BABUN" (
			call :install_package %%p
		)
	)
)

if "%INSTALL_ECLIPSE%" == "EE" (
	call :install_package ECLIPSE_EE
)
if "%INSTALL_ECLIPSE%" == "JAVA" (
	call :install_package ECLIPSE_JAVA
)
if "%INSTALL_ECLIPSE%" == "CPP" (
	call :install_package ECLIPSE_CPP
)
if "%INSTALL_SCALA%" == "TRUE" (
	call :install_package SBT
)

if "%INSTALL_BABUN%" == "TRUE" (
	if not exist "%TOOLS_DIR%\%BABUN_FOLDER%" (
		call :install_package %BABUN_NAME% BABUN
		
		echo unpacked %BABUN_NAME%.
		echo calling %TOOLS_DIR%\%BABUN_EXPLODED%\install.bat /t %TOOLS_DIR%
		
		call "%TOOLS_DIR%\%BABUN_EXPLODED%\install.bat" /t "%TOOLS_DIR%"
		if errorlevel 1 set BABUN_ERROR=TRUE
		
		echo cleaning up...
		rmdir /S /Q "%TOOLS_DIR%\%BABUN_EXPLODED%" >NUL
		
	  if "%BABUN_ERROR%" == "TRUE" (
		echo.
		  echo ---
			echo %BABUN_NAME% was not correctly installed. Please see above error log.
			echo DevPack installation aborted!
			exit /B
		) else (
			echo %BABUN_NAME% installation done.	
		)
	)
	echo Package %BABUN_NAME% is already installed.
)
call %WORK_DRIVE%:\setenv.bat

exit /B

:purge
setlocal enabledelayedexpansion
echo.
echo -^> Purging disabled packages...

for %%p in ( %DEVPACK_PACKAGES% )  do (		
	set PURGE_PACKAGE=INSTALL_%%p
	call :expand_variable PURGE_PACKAGE
	
	if "!PURGE_PACKAGE!" == "FALSE" (
		call :uninstall_package %%p
		if "%%p" == "SCALA" (
			call :uninstall_package SBT
		)
	)	
)

if "%INSTALL_ECLIPSE%" == "FALSE" (
	call :uninstall_package ECLIPSE_EE
)
echo.
echo All done.

exit /B

:uninstall
echo.
echo -^> Uninstalling DevPack...

for %%p in ( %DEVPACK_PACKAGES% )  do (	
	call :uninstall_package %%p
)

echo.
echo All done.

exit /B

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

if %OPTION_LEN% LEQ 6 (
	echo | set /p=Package %OPTION%:%TAB%%TAB%%TAB%
) else if %OPTION_LEN% LEQ 14 (
	echo | set /p=Package %OPTION%:%TAB%%TAB%
) else (
	echo | set /p=Package %OPTION%:%TAB%
)

if "%SELECTED%" == "FALSE" (
	echo | set /p=not selected,%TAB%%TAB%%TAB%
) else (
	if %VERSION_LEN% LEQ 8 (
	  echo | set /p=version %VERSION%,%TAB%%TAB%%TAB%
	) else (
	  echo | set /p=version %VERSION%,%TAB%	
	)
)

if not exist "%TOOLS_DIR%\%TARGET%" (
	echo | set /p=not installed,%TAB%
	if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
		echo | set /p=not 
	)
	echo downloaded.
) else (
	echo installed.
)

exit /B

rem -------------------------------------------------
rem Installation routine
rem Unzip package into target folder.
rem -------------------------------------------------
:install_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!
echo | set /p=Package %OPTION%... 

if not exist "%TOOLS_DIR%\%TARGET%" (

	if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
		echo Error: Package %PACKAGE% was not downloaded!
		exit /B
	)

	echo installing now.
	pushd %TOOLS_DIR%
	
	if "%UNZIPPED%" == "--MSI--" (
		call :extract_msi_package "%DOWNLOADS_DIR%\%PACKAGE%" %TOOLS_DIR%\%TARGET%
		set UNZIPPED=%TARGET%
	) else if "%UNZIPPED%" == "--create--" (
		echo | set /p=Unpacking %OPTION% %VERSION% to %TOOLS_DIR%\%TARGET%... 
		%TOOLS_DIR%\7-Zip\7z x -y "%DOWNLOADS_DIR%\%PACKAGE%" -o%TARGET% >NUL
		set UNZIPPED=%TARGET%
		echo ok.
	) else (
		echo | set /p=Unpacking %OPTION% %VERSION% to %TOOLS_DIR%... 
		%TOOLS_DIR%\7-Zip\7z x -y "%DOWNLOADS_DIR%\%PACKAGE%" >NUL
		echo ok.
	)

	if not "%UNZIPPED%" == "??" (
		if exist %UNZIPPED% if not exist %TARGET% (
			echo Renaming %UNZIPPED% to %TARGET%
			move %UNZIPPED% %TARGET%
			if not "%KEEP_PACKAGES%" == "TRUE" del "%DOWNLOADS_DIR%\%PACKAGE%"
		)
  )
  
  call :postinstall_package

  popd
  echo done.
  exit /B
)
endlocal
echo already installed.
exit /B

rem -------------------------------------------------
rem Package post-installation.
rem Create version.txt, handle configured tools.
rem -------------------------------------------------
:postinstall_package
  echo %VERSION% > %TOOLS_DIR%\%TARGET%\version.txt
  
  for /l %%x in (1, 1, 10) do (
	
	set TOOL_NAME=%PACKAGE_SPEC%_TOOL_%%x
	set TOOL_VALUE=%PACKAGE_SPEC%_TOOL_%%x
	
	call :expand_variable TOOL_VALUE
	
	if NOT "!TOOL_VALUE!" == "!TOOL_NAME!" (
	  copy %~dp0bin\!TOOL_VALUE! %~dp0 >NUL
	)
  )
exit /B

rem -------------------------------------------------
rem Deinstallation routine
rem Remove target folder.
rem -------------------------------------------------
:uninstall_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

echo | set /p=Package %OPTION%... 

if exist "%TOOLS_DIR%\%TARGET%" (
	pushd %TOOLS_DIR%
	
	rmdir /Q /S "%TARGET%"
	
	for /l %%x in (1, 1, 10) do (
		set TOOL_NAME=%PACKAGE_SPEC%_TOOL_%%x
		set TOOL_VALUE=%PACKAGE_SPEC%_TOOL_%%x
		
		call :expand_variable TOOL_VALUE
		
		if NOT "!TOOL_VALUE!" == "!TOOL_NAME!" (
		  del %~dp0!TOOL_VALUE!
		)
	  )
	
	echo uninstalled.

  popd
  exit /B
)
endlocal
echo not installed.
exit /B

rem -------------------------------------------------
rem Download routine
rem Add download package to download list
rem -------------------------------------------------
:download_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

echo | set /p=Package %OPTION% [%PACKAGE%]... 

if not exist "%DOWNLOADS_DIR%\%PACKAGE%" if not exist "%TOOLS_DIR%\%TARGET%" (
	if "%PACKAGE%" == "%GIT_REPO%" (
		call :checkout_git_repo %PACKAGE_URL% %TARGET%
	) else (
		echo %PACKAGE_URL% >> %DOWNLOADS%
		echo marked for download.	
	)
	exit /B
)
endlocal
echo already available.
exit /B

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

echo installing now!
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
rmdir /S /Q %DOWNLOADS_DIR%\JDK >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del %PACKAGE%
echo done.
echo Install package %OPTION% done.
echo.
exit /B


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
if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
	echo Error: Package %PACKAGE% was not downloaded!
	exit /B
)
if exist %TOOLS_DIR%\%TARGET% (
	echo already installed.
	exit /B
)

echo installing now.

if not "%INSTALL_JAVA_SOURCE%" == "TRUE" (
  echo.
  echo extracting JDK...
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
rmdir /S /Q %DOWNLOADS_DIR%\extract >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del "%DOWNLOADS_DIR%\%PACKAGE%"
echo done.
echo Install package %OPTION% done.
echo.
exit /B

:extract_msi_package
set MSI_PACKAGE=%1
set MSI_TARGET=%2

if not exist %MSI_PACKAGE% (
	echo.
	echo Error: Package %MSI_PACKAGE% does not exist.
	exit /B
)

echo | set /p=Unpacking %OPTION% %VERSION% to %MSI_TARGET%...
msiexec /a %MSI_PACKAGE% /qn TARGETDIR=%MSI_TARGET% 

exit /B

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
if not exist "%DOWNLOADS_DIR%\%PACKAGE%" (
	echo Error: Package %PACKAGE% was not downloaded!
	exit /B
)
if exist %TOOLS_DIR%\%TARGET% (
	echo already installed.
	exit /B
)

echo installing now.

echo extracting package... 

rmdir /s /q %EXTRACT% >NUL 2>&1
mkdir %EXTRACT%
pushd %EXTRACT%

%TOOLS_DIR%\7-Zip\7z x %DOWNLOADS_DIR%\%PACKAGE% >NUL
%TOOLS_DIR%\7-Zip\7z x %UNZIPPED% >NUL

xcopy "lib\net45\*" "%TOOLS_DIR%\%TARGET%" /S /i >NUL
popd

rmdir /s /q %EXTRACT% >NUL 2>&1

call :postinstall_package

exit /B

:expand_variable
set var=%1
:expand_loop
if not "!%var%!" == "" (
  set var=!%var%!
  goto :expand_loop
)
set %1=!var!
exit /B

:install_jdk_without_source
set PACKAGE_SPEC=%1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

echo | set /p=Package %OPTION%... 

if not exist %DOWNLOADS_DIR%\%PACKAGE% (
	echo Error: Package %PACKAGE% was not downloaded!
	exit /B
)

if exist %TOOLS_DIR%\%TARGET% (
	echo Package %PACKAGE_NAME% is already installed.
	exit /B
)

echo Installing %PACKAGE_NAME% ...
echo ... extracting package ...
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
rmdir /S /Q .rsrc >NUL
popd

echo ... copying files ...
xcopy /E /I /Y %DOWNLOADS_DIR%\JDK %TOOLS_DIR%\%TARGET% >NUL
rmdir /S /Q %DOWNLOADS_DIR%\JDK >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del %DOWNLOADS_DIR%\%PACKAGE%
echo ... done.
echo.
exit /B

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
  FOR /D /r %%G in ("workspace\*") DO (
	if NOT "%%~nG" == "" (
		echo Removing workspace folder "%%G"
		call :clean_folder %%G
	)
  )
)
echo done
exit /B

:clean_file
if exist %1 del /Q %1 >NUL
exit /B

:clean_folder
if exist %1 rmdir /S /Q %1 >NUL
exit /B


:done
