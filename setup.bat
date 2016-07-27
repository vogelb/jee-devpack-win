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

set TEMPLATE=templates\default.bat
set DEBUG=FALSE

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
	echo Using template %TEMPLATE%...
	shift
	goto get_commandline

:done_commandline

set COMMAND=%1

if not exist %TEMPLATE% echo. && echo Template %TEMPLATE% not found. && echo Exiting... && goto done

rem Unmount mounted drive. Might be another instance!
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

set BABUN_NAME=Babun
set BABUN_URL=https://bintray.com/artifact/download/tombujok/babun/babun-1.2.0-dist.zip
set BABUN_EXPLODED=babun-1.2.0
set BABUN_PACKAGE=babun-1.2.0-dist.zip
set BABUN_FOLDER=.babun

set JDK8_NAME="Oracle JDK 8"
set JDK8_URL=http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-windows-x64.exe
set JDK8_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_PACKAGE=jdk-8u92-windows-x64.exe
set JDK8_FOLDER=jdk_8

set JDK8_32_NAME="Oracle JDK 8 32bit"
set JDK8_32_URL=http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-windows-i586.exe
set JDK8_32_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_32_PACKAGE=jdk-8u92-windows-i586.exe
set JDK8_32_FOLDER=jdk_8_32

set JDK7_NAME="Oracle JDK 7"
set JDK7_URL=http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-windows-x64.exe
set JDK7_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK7_PACKAGE=jdk-7u79-windows-x64.exe
set JDK7_FOLDER=jdk_7

set JDK6_NAME="Oracle JDK 6"
set JDK6_URL=http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-windows-x64.exe
set JDK6_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK6_PACKAGE=jdk-6u45-windows-x64.exe
set JDK6_FOLDER=jdk_6

set ECLIPSE_EE_NAME="Eclipse EE"
set ECLIPSE_EE_URL=http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/R/eclipse-jee-neon-R-win32-x86_64.zip
set ECLIPSE_EE_EXPLODED=eclipse-jee-neon-R-win32-x86_64
set ECLIPSE_EE_PACKAGE=%ECLIPSE_EE_EXPLODED%.zip
set ECLIPSE_EE_FOLDER=eclipse

set ECLIPSE_JAVA_NAME="Eclipse Java"
set ECLIPSE_JAVA_URL=http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/R/eclipse-java-neon-R-win32-x86_64.zip
set ECLIPSE_JAVA_EXPLODED=eclipse-java-neon-R-win32-x86_64
set ECLIPSE_JAVA_PACKAGE=%ECLIPSE_JAVA_EXPLODED%.zip
set ECLIPSE_JAVA_FOLDER=eclipse

set ECLIPSE_CPP_NAME="Eclipse C/C++"
set ECLIPSE_CPP_URL=http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/R/eclipse-cpp-neon-R-win32-x86_64.zip
set ECLIPSE_CPP_EXPLODED=eclipse-cpp-neon-R-win32-x86_64
set ECLIPSE_CPP_PACKAGE=%ECLIPSE_CPP_EXPLODED%.zip
set ECLIPSE_CPP_FOLDER=eclipse

set MAVEN_NAME="Maven"
set MAVEN_URL=http://mirror.switch.ch/mirror/apache/dist/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip
set MAVEN_EXPLODED=apache-maven-3.3.1
set MAVEN_PACKAGE=%MAVEN_EXPLODED%-bin.zip
set MAVEN_FOLDER=mvn

set TOMEE_NAME="Tom EE"
set TOMEE_URL=http://apache.openmirror.de/tomee/tomee-1.7.2/apache-tomee-1.7.2-plus.zip
set TOMEE_EXPLODED=apache-tomee-plus-1.7.2
set TOMEE_PACKAGE=apache-tomee-1.7.2-plus.zip
set TOMEE_FOLDER=tomee

set WILDFLY_NAME="Wildfly"
set WILDFLY_VERSION=9.0.2.Final
set WILDFLY_URL=http://download.jboss.org/wildfly/%WILDFLY_VERSION%/wildfly-%WILDFLY_VERSION%.zip
set WILDFLY_EXPLODED=wildfly-%WILDFLY_VERSION%
set WILDFLY_PACKAGE=%WILDFLY_EXPLODED%.zip
set WILDFLY_FOLDER=wildfly

set GLASSFISH_NAME="Glassfish"
set GLASSFISH_URL=http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip
set GLASSFISH_EXPLODED=glassfish-4
set GLASSFISH_PACKAGE=glassfish-4.1.zip
set GLASSFISH_FOLDER=glassfish

set NPP_NAME="Notepad++"
set NPP_URL=https://notepad-plus-plus.org/repository/6.x/6.9.2/npp.6.9.2.bin.zip
set NPP_EXPLODED=--create--
set NPP_PACKAGE=npp.6.9.2.bin.zip
set NPP_FOLDER=npp

set SUBLIME_NAME="Sublime Text"
set SUBLIME_URL=http://c758482.r82.cf2.rackcdn.com/Sublime Text 2.0.2 x64.zip
set SUBLIME_EXPLODED=--create--
set SUBLIME_PACKAGE=Sublime Text 2.0.2 x64.zip
set SUBLIME_FOLDER=sublime

set FORGE_NAME="JBoss Forge"
set FORGE_URL=https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/jboss/forge/forge-distribution/2.15.2.Final/forge-distribution-2.15.2.Final-offline.zip
set FORGE_EXPLODED=forge-distribution-2.15.2.Final
set FORGE_PACKAGE=%FORGE_EXPLODED%-offline.zip
set FORGE_FOLDER=forge

set SCALA_NAME="Scala"
set SCALA_URL=http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.zip?_ga=1.251179782.1811953383.1443169031
set SCALA_EXPLODED=scala-2.11.7
set SCALA_PACKAGE=%SCALA_EXPLODED%.zip
set SCALA_FOLDER=scala

set SBT_NAME="SBT"
set SBT_URL=https://dl.bintray.com/sbt/native-packages/sbt/0.13.9/sbt-0.13.9.zip
set SBT_EXPLODED=sbt-0.13.9
set SBT_PACKAGE=%SBT_EXPLODED%.zip
set SBT_FOLDER=sbt

set CONSOLE_NAME="Console 2"
set CONSOLE_URL=http://downloads.sourceforge.net/project/console/console-devel/2.00/Console-2.00b148-Beta_32bit.zip
set CONSOLE_EXPLODED=Console2
set CONSOLE_PACKAGE=Console-2.00b148-Beta_32bit.zip
set CONSOLE_FOLDER=console

rem ===== PACKAGE CONFIGURATION STARTS HERE =====

call %TEMPLATE%

rem ===== END OF PACKAGE CONFIGURATION =====

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
	call :download_package NPP
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
	call :install_package NPP
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

call %WORK_DRIVE%:\setenv.bat

exit /B

:purge
echo.
echo -^> Purging disabled packages...

if "%INSTALL_MAVEN%" == "FALSE" (
	call :uninstall_package MAVEN
)

if NOT "%INSTALL_ECLIPSE%" == "EE" (
	call :uninstall_package ECLIPSE_EE
)
if NOT "%INSTALL_ECLIPSE%" == "JAVA" (
	call :uninstall_package ECLIPSE_JAVA
)
if NOT "%INSTALL_ECLIPSE%" == "CPP" (
	call :uninstall_package ECLIPSE_CPP
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
	call :uninstall_package NPP
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

echo.
echo All done.

exit /B

:uninstall
echo.
echo -^> Uninstalling DevPack...


echo.
echo All done.

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
  echo error. Extracting the old way...
  call :install_jdk_old %PACKAGE_SPEC%
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
xcopy /E %DOWNLOADS_DIR%\extract %TOOLS_DIR%\%TARGET%\ >NUL
echo done.

echo | set /p=cleaning up... 
rmdir /S /Q %DOWNLOADS_DIR%\extract >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del "%DOWNLOADS_DIR%\%PACKAGE%"
echo done.
echo Install package %OPTION% done.
echo.
echo Install package %OPTION% done.
echo.
exit /B

:install_jdk_old
set PACKAGE_SPEC=%~1
setlocal enabledelayedexpansion
set OPTION=!%PACKAGE_SPEC%_NAME!
set PACKAGE=!%PACKAGE_SPEC%_PACKAGE!
set PACKAGE_URL=!%PACKAGE_SPEC%_URL!
set UNZIPPED=!%PACKAGE_SPEC%_EXPLODED!
set TARGET=!%PACKAGE_SPEC%_FOLDER!
set VERSION=!%PACKAGE_SPEC%_VERSION!

echo | set /p=Package %OPTION%... 

if not exist %DOWNLOADS_DIR%\%PACKAGE% 
(
	echo Error: Package %PACKAGE% was not downloaded!
	exit /B
)

if exist %TOOLS_DIR%\%TARGET% (
	echo Package %PACKAGE_NAME% is already installed.
	exit /B
)

echo Installing %PACKAGE_NAME% ...
echo ... extracting package ...
%TOOLS_DIR%\7-Zip\7z e -y %DOWNLOADS_DIR%\%PACKAGE% -o%DOWNLOADS_DIR%\JDK >NUL
pushd %DOWNLOADS_DIR%\JDK

echo ... extracting tools ...
%TOOLS_DIR%\7-Zip\7z x tools.zip >NUL
del tools.zip

echo ... unpacking jars ...
for /r %%x in (*.pack) do (
	.\bin\unpack200 -r %%x %%~dx%%~px%%~nx.jar >NUL
)
popd

echo ... copying files ...
xcopy /E %DOWNLOADS_DIR%\JDK %TOOLS_DIR%\%TARGET%\ >NUL
rmdir /S /Q %DOWNLOADS_DIR%\JDK >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del %DOWNLOADS_DIR%\%PACKAGE%
echo ... done.
echo.
exit /B

:done
