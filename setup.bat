@echo off
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

rem KEEP_PACKAGES: If set to true, downloaded packages will not be deleted after installation
set KEEP_PACKAGES=TRUE

set LAST_TEMPLATE=conf\template.bat

if exist %LAST_TEMPLATE% call %LAST_TEMPLATE%
if not "%SELECTED_TEMPLATE%" == "" (
	set TEMPLATE=%SELECTED_TEMPLATE%
) else (
	set TEMPLATE=templates\default.bat
)
set DEBUG=FALSE
set TAB=	

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
	set TEMPLATE=templates\%1.bat
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

call %~dp0bin\w_unmount_drive.bat

if not exist %WORK_DRIVE%:\ goto mount_work_drive
echo.
echo The configured work drive (%WORK_DRIVE%) is already in use.
echo Installation cancelled.
goto done

:mount_work_drive

rem Mount work drive and read configuration
call %~dp0bin\w_mount_drive.bat

cd /d %WORK_DRIVE%:\

set WGET=%~dp0bin\wget
set WGET_OPTIONS=--no-check-certificate --no-cookies

set DOWNLOADS=%DOWNLOADS_DIR%\download_packages.txt

call %~dp0conf\packages.bat

rem ===== PACKAGE CONFIGURATION STARTS HERE =====

call %TEMPLATE%

rem ===== END OF PACKAGE CONFIGURATION =====

if "%COMMAND%" == "info" goto info
if "%COMMAND%" == "install" goto install_devpack
if "%COMMAND%" == "download" goto download
if "%COMMAND%" == "purge" goto purge
if "%COMMAND%" == "uninstall" goto uninstall

echo.
echo J2EE Devpack setup
echo.
echo Usage: setup [-t template] command
echo.
echo Available commands:
echo   info      - Show currently installed packages
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

if not exist %TOOLS_DIR% mkdir %TOOLS_DIR%
if exist %DOWNLOADS% del %DOWNLOADS%
if not exist %DOWNLOADS_DIR% mkdir %DOWNLOADS_DIR%

if "%INSTALL_MAVEN%" == "TRUE" (
	call :download_package MAVEN
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

if "%INSTALL_BABUN%" == "TRUE" (
	call :download_package BABUN
)
if "%INSTALL_TOMEE%" == "TRUE" (
	call :download_package TOMEE
)
if "%INSTALL_WILDFLY%" == "TRUE" (
	call :download_package WILDFLY
)
if "%INSTALL_GLASSFISH%" == "TRUE" (
	call :download_package GLASSFISH
)
if "%INSTALL_NOTEPAD%" == "TRUE" (
	call :download_package NOTEPAD
)

if "%INSTALL_SUBLIME%" == "TRUE" (
	call :download_package SUBLIME
)
if "%INSTALL_FORGE%" == "TRUE" (
	call :download_package FORGE
)

if "%INSTALL_SCALA%" == "TRUE" (
	call :download_package SCALA
	call :download_package SBT
)

if "%INSTALL_CONSOLE%" == "TRUE" (
	call :download_package CONSOLE
)

if "%INSTALL_SOURCETREE%" == "TRUE" (
	call :download_package SOURCETREE
)

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
call :query_package JDK6
call :query_package JDK7
call :query_package JDK8
call :query_package JDK8_32
call :query_package MAVEN
call :query_package ECLIPSE
call :query_package TOMEE
call :query_package WILDFLY
call :query_package GLASSFISH
call :query_package NOTEPAD
call :query_package SUBLIME
call :query_package FORGE
call :query_package SCALA
call :query_package BABUN
call :query_package CONSOLE
call :query_package SOURCETREE

exit /B

:install
echo.
echo -^> Installing packages...

if "%INSTALL_MAVEN%" == "TRUE" (
	call :install_package MAVEN
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

if "%INSTALL_TOMEE%" == "TRUE" (
	call :install_package TOMEE
)
if "%INSTALL_WILDFLY%" == "TRUE" (
	call :install_package WILDFLY
)
if "%INSTALL_GLASSFISH%" == "TRUE" (
	call :install_package GLASSFISH
)
if "%INSTALL_NOTEPAD%" == "TRUE" (
	call :install_package NOTEPAD
)
if "%INSTALL_SUBLIME%" == "TRUE" (
	call :install_package SUBLIME
)
if "%INSTALL_FORGE%" == "TRUE" (
	call :install_package FORGE
)
if "%INSTALL_SCALA%" == "TRUE" (
	call :install_package SCALA
	call :install_package SBT
)

if "%INSTALL_JDK6%" == "TRUE" (
	call :install_jdk_6 JDK6
)
if "%INSTALL_JDK7%" == "TRUE" (
	call :install_jdk JDK7
)
if "%INSTALL_JDK8%" == "TRUE" (
	call :install_jdk JDK8
)
if "%INSTALL_JDK8_32%" == "TRUE" (
	call :install_jdk JDK8_32
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

if "%INSTALL_CONSOLE%" == "TRUE" (
	call :install_package CONSOLE
)

if "%INSTALL_SOURCETREE%" == "TRUE" (
	call :install_nupkg_package SOURCETREE
)

call %WORK_DRIVE%:\setenv.bat

exit /B

:purge
echo.
echo -^> Purging disabled packages...

if "%INSTALL_MAVEN%" == "FALSE" (
	call :uninstall_package MAVEN
)

if "%INSTALL_ECLIPSE%" == "FALSE" (
	call :uninstall_package ECLIPSE_EE
)

if "%INSTALL_FORGE%" == "FALSE" (
	call :uninstall_package FORGE
)

if "%INSTALL_TOMEE%" == "FALSE" (
	call :uninstall_package TOMEE
)
if "%INSTALL_WILDFLY%" == "FALSE" (
	call :uninstall_package WILDFLY
)
if "%INSTALL_GLASSFISH%" == "FALSE" (
	call :uninstall_package GLASSFISH
)

if "%INSTALL_NOTEPAD%" == "FALSE" (
	call :uninstall_package NOTEPAD
)
if "%INSTALL_SUBLIME%" == "FALSE" (
	call :uninstall_package SUBLIME
)
if "%INSTALL_SCALA%" == "FALSE" (
	call :uninstall_package SCALA
	call :uninstall_package SBT
)

if "%INSTALL_JDK6%" == "FALSE" (
	call :uninstall_package JDK6
)
if "%INSTALL_JDK7%" == "FALSE" (
	call :uninstall_package JDK7
)
if "%INSTALL_JDK8%" == "FALSE" (
	call :uninstall_package JDK8
)
if "%INSTALL_JDK8_32%" == "FALSE" (
	call :uninstall_package JDK8_32
)

if "%INSTALL_BABUN%" == "FALSE" (
	call :uninstall_package BABUN
)

if "%INSTALL_CONSOLE%" == "FALSE" (
	call :uninstall_package CONSOLE
)

if "%INSTALL_SOURCETREE%" == "FALSE" (
	call :uninstall_package SOURCETREE
)

echo.
echo All done.

exit /B

:uninstall
echo.
echo -^> Uninstalling DevPack...


echo.
echo All done.

exit /B

:query_package
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion

set SELECTED=!INSTALL_%PACKAGE_SPEC%!

if NOT "!INSTALL_%PACKAGE_SPEC%!" == "TRUE" (
	if NOT "!INSTALL_%PACKAGE_SPEC%!" == "FALSE" (
		set PACKAGE_SPEC=%PACKAGE_SPEC%_!INSTALL_%PACKAGE_SPEC%!
	)
)
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

call :strlen OPTION_LEN OPTION 

if %OPTION_LEN% LEQ 16 (
	echo | set /p=Package %OPTION%:%TAB%%TAB%
) else (
	echo | set /p=Package %OPTION%:%TAB%
)

echo | set /p=selected=%SELECTED%,%TAB%	

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
  echo | set /p=Unpacking %OPTION% %VERSION% to %TOOLS_DIR%\%TARGET%... 
	pushd %TOOLS_DIR%
	
	if "%UNZIPPED%" == "--create--" (
		%TOOLS_DIR%\7-Zip\7z x -y "%DOWNLOADS_DIR%\%PACKAGE%" -o%TARGET% >NUL
		set UNZIPPED=%TARGET%
	) else (
		%TOOLS_DIR%\7-Zip\7z x -y "%DOWNLOADS_DIR%\%PACKAGE%" >NUL
	)

	if not "%UNZIPPED%" == "??" (
		if exist %UNZIPPED% if not exist %TARGET% (
			echo Renaming %UNZIPPED% to %TARGET%
			rename %UNZIPPED% %TARGET%
			if not "%KEEP_PACKAGES%" == "TRUE" del "%DOWNLOADS_DIR%\%PACKAGE%"
		)
		echo %VERSION% > %TARGET%\version.txt
  ) 

  popd
  echo done.
  exit /B
)
endlocal
echo already installed.
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
	echo uninstalled.

  popd
  exit /B
)
endlocal
echo package not installed.
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

echo | set /p=Package %OPTION%... 
if not exist "%DOWNLOADS_DIR%\%PACKAGE%" if not exist "%TOOLS_DIR%\%TARGET%" (
	echo %PACKAGE_URL% >> %DOWNLOADS%
	echo marked for download.
	exit /B
)
endlocal
echo already available.
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

:done
