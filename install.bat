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

rem ===== PACKAGE CONFIGURATION STARTS HERE =====

rem Set DOWNLOADS_DIR in order to reuse existing downloads  
set DOWNLOADS_DIR=%TOOLS_DIR%\downloads

rem KEEP_PACKAGES: If set to true, downloaded packages will not be deleted after installation
set KEEP_PACKAGES=TRUE

rem Set to TRUE if you want Java 8 installed
set INSTALL_JDK8=TRUE
rem Set to TRUE if you want Java 8 32bit installed
set INSTALL_JDK8_32=FALSE

rem Set to TRUE if you want Java 7 installed
set INSTALL_JDK7=FALSE

rem Set to TRUE if you want Java 6 installed
rem Note: JDK 6 cannot be automatically downloaded because it requires to log into the oracle web site.
rem Download it manually and place into the configured download folder (see DOWNLOADS_DIR above). 
set INSTALL_JDK6=FALSE

rem Set to TRUE if you want Wildfly installed
set INSTALL_WILDFLY=TRUE

rem Set to TRUE if you want Glassfish installed
set INSTALL_GLASSFISH=FALSE

rem Set to TRUE if you want Sublime installed
set INSTALL_SUBLIME=FALSE

rem ===== END OF PACKAGE CONFIGURATION =====

rem Unmount mounted drive. Might be another instance!
call %~dp0conf\devpack.bat

rem If installation is started from running devpack, restart from base dir.
if "%WORK_DRIVE%:" == "%~d0" (
	echo Restarting installation from base dir %DEVPACK_BASE%...
	cd /d %DEVPACK_BASE%
	%DEVPACK_BASE%\install.bat
	goto EOF
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

set JDK8_URL=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-windows-x64.exe
set JDK8_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_PACKAGE=jdk-8u60-windows-x64.exe

set JDK8_32_URL=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-windows-i586.exe
set JDK8_32_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_32_PACKAGE=jdk-8u60-windows-i586.exe

set JDK7_URL=http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-windows-x64.exe
set JDK7_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK7_PACKAGE=jdk-7u79-windows-x64.exe

set JDK6_URL=http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-windows-x64.exe
set JDK6_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK6_PACKAGE=jdk-6u45-windows-x64.exe

set ECLIPSE_URL=http://mirror.switch.ch/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-jee-luna-SR2-win32-x86_64.zip
set ECLIPSE_EXPLODED=eclipse-jee-luna-SR2-win32-x86_64
set ECLIPSE_PACKAGE=%ECLIPSE_EXPLODED%.zip

set MAVEN_URL=http://mirror.switch.ch/mirror/apache/dist/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip
set MAVEN_EXPLODED=apache-maven-3.3.1
set MAVEN_PACKAGE=%MAVEN_EXPLODED%-bin.zip

set WILDFLY_URL=http://download.jboss.org/wildfly/8.2.0.Final/wildfly-8.2.0.Final.zip
set WILDFLY_EXPLODED=wildfly-8.2.0.Final
set WILDFLY_PACKAGE=%WILDFLY_EXPLODED%.zip

set GLASSFISH_URL=http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip
set GLASSFISH_EXPLODED=glassfish-4
set GLASSFISH_PACKAGE=glassfish-4.1.zip

set NPP_URL=http://dl.notepad-plus-plus.org/downloads/6.x/6.7.5/npp.6.7.5.bin.zip
set NPP_EXPLODED=npp.6.7.5.bin
set NPP_PACKAGE=%NPP_EXPLODED%.zip

set SUBLIME_URL=http://c758482.r82.cf2.rackcdn.com/Sublime Text 2.0.2 x64.zip
set SUBLIME_EXPLODED=Sublime Text 2.0.2 x64
set SUBLIME_PACKAGE=%SUBLIME_EXPLODED%.zip

set FORGE_URL=https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/jboss/forge/forge-distribution/2.15.2.Final/forge-distribution-2.15.2.Final-offline.zip
set FORGE_EXPLODED=forge-distribution-2.15.2.Final
set FORGE_PACKAGE=%FORGE_EXPLODED%-offline.zip

echo Start Installation of JEE DevPack
echo.

findstr /m "SET SVN_USER" conf\devpack.bat > NUL
if %errorlevel%==0 goto download
set SVN_USER=%USERNAME%
setlocal enabledelayedexpansion 
for %%a in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z" "Ä=ä" "Ö=ö" "Ü=ü") do ( 
    set "SVN_USER=!SVN_USER:%%~a!" 
)
echo set SVN_USER=%SVN_USER% >> conf\devpack.bat
endlocal

:download
if not exist %TOOLS_DIR% mkdir %TOOLS_DIR%
if exist %DOWNLOADS% del %DOWNLOADS%
if not exist %DOWNLOADS_DIR% mkdir %DOWNLOADS_DIR%

if "%INSTALL_WILDFLY%" == "TRUE" (
	call :download_package "%WILDFLY_PACKAGE%" "%WILDFLY_URL%" wildfly
)
if "%INSTALL_GLASSFISH%" == "TRUE" (
	call :download_package "%GLASSFISH_PACKAGE%" "%GLASSFISH_URL%" glassfish
)
call :download_package "%MAVEN_PACKAGE%" "%MAVEN_URL%" mvn
call :download_package "%ECLIPSE_PACKAGE%" "%ECLIPSE_URL%" eclipse
call :download_package "%NPP_PACKAGE%" "%NPP_URL%" npp
if "%INSTALL_SUBLIME%" == "TRUE" (
	call :download_package "%SUBLIME_PACKAGE%" "%SUBLIME_URL%" sublime
)
call :download_package "%FORGE_PACKAGE%" "%FORGE_URL%" forge

:download_jdk6
if "%INSTALL_JDK6%" == "TRUE" (
	if exist %TOOLS_DIR%\jdk_6 goto download_jdk7
	if exist "%DOWNLOADS_DIR%\%JDK6_PACKAGE%" goto download_jdk7
	echo.
	echo JDK 6 cannot be automatically downloaded because it requires an Oracle web account.
	echo Please Download it manually and place into the configured download folder %DOWNLOADS_DIR%.
	echo Installation cancelled.
	goto done 
)

:download_jdk7
if "%INSTALL_JDK7%" == "TRUE" (
	if exist %TOOLS_DIR%\jdk_7 goto download_jdk8
	if exist "%DOWNLOADS_DIR%\%JDK7_PACKAGE%" goto download_jdk8
	echo Downloading JDK 7...
	%WGET% %JDK7_OPTIONS% --directory-prefix %DOWNLOADS_DIR% %JDK7_URL%
)

:download_jdk8
if "%INSTALL_JDK8%" == "TRUE" (
	if exist %TOOLS_DIR%\jdk_8 goto download_jdk8_32
	if exist "%DOWNLOADS_DIR%\%JDK8_PACKAGE%" goto download_jdk8_32
	echo Downloading JDK 8...
	%WGET% %JDK8_OPTIONS% --directory-prefix %DOWNLOADS_DIR% %JDK8_URL%
)

:download_jdk8_32
if "%INSTALL_JDK8_32%" == "TRUE" (
	if exist %TOOLS_DIR%\jdk_8_32 goto execute_downloads
	if exist "%DOWNLOADS_DIR%\%JDK8_32_PACKAGE%" goto execute_downloads
	echo Downloading JDK 8...
	%WGET% %JDK8_32_OPTIONS% --directory-prefix %DOWNLOADS_DIR% %JDK8_32_URL%
)

:execute_downloads
if not exist %DOWNLOADS% goto install
echo Downloading files:
type %DOWNLOADS%

rem Provide user and prompt for password if required (e.g. download from internal nexus or web space)
rem echo Please provide your nexus credentials.
rem wget --directory-prefix %TOOLS_DIR% --http-user=%SVN_USER% --ask-password -i %DOWNLOADS%
%WGET% %WGET_OPTIONS% --directory-prefix %DOWNLOADS_DIR% -i %DOWNLOADS%

del %DOWNLOADS%

: install
if "%INSTALL_JDK6%" == "TRUE" (
	call :install_jdk_6 "Oracle JDK 6" "%DOWNLOADS_DIR%\%JDK6_PACKAGE%" "%TOOLS_DIR%\jdk_6"
)
if "%INSTALL_JDK7%" == "TRUE" (
	call :install_jdk "Oracle JDK 7" "%DOWNLOADS_DIR%\%JDK7_PACKAGE%" "%TOOLS_DIR%\jdk_7"
)
if "%INSTALL_JDK8%" == "TRUE" (
	call :install_jdk "Oracle JDK 8" "%DOWNLOADS_DIR%\%JDK8_PACKAGE%" "%TOOLS_DIR%\jdk_8"
)
if "%INSTALL_JDK8_32%" == "TRUE" (
	call :install_jdk "Oracle JDK 8 32bit" "%DOWNLOADS_DIR%\%JDK8_32_PACKAGE%" "%TOOLS_DIR%\jdk_8_32"
)

:install_packages
call :install_package "Maven" "%MAVEN_PACKAGE%" "%MAVEN_EXPLODED%" mvn
call :install_package "Eclipse JEE Luna" "%ECLIPSE_PACKAGE%" "%ECLIPSE_EXPLODED%" eclipse
if "%INSTALL_WILDFLY%" == "TRUE" (
	call :install_package "Wildfly" "%WILDFLY_PACKAGE%" "%WILDFLY_EXPLODED%" wildfly
)
if "%INSTALL_GLASSFISH%" == "TRUE" (
	call :install_package "Glassfish" "%GLASSFISH_PACKAGE%" "%GLASSFISH_EXPLODED%" glassfish
)
call :install_package "Notepad++ 6.7.5" "%NPP_PACKAGE%" --create-- npp
if "%INSTALL_SUBLIME%" == "TRUE" (
	call :install_package "Sublime 2.0.2 x64" "%SUBLIME_PACKAGE%" --create-- sublime
)
call :install_package "JBoss Forge 2.15.2" "%FORGE_PACKAGE%" "%FORGE_EXPLODED%" forge

call %WORK_DRIVE%:\setenv.bat

echo All done.
goto :done

rem -------------------------------------------------
rem Installation routine
rem Unzip package into target folder.
rem -------------------------------------------------
:install_package
set NAME=%~1
set PACKAGE=%~2
set UNZIPPED=%~3
set TARGET=%~4
if exist "%DOWNLOADS_DIR%\%PACKAGE%" if not exist "%TOOLS_DIR%\%TARGET%" (
    echo Unpacking %NAME% to %TOOLS_DIR%\%TARGET%...
    pushd %TOOLS_DIR%
	if "%UNZIPPED%" == "--create--" (
		%TOOLS_DIR%\7-Zip\7z x "%DOWNLOADS_DIR%\%PACKAGE%" -o%TARGET% >NUL
		set UNZIPPED=%TARGET%
	) else (
		%TOOLS_DIR%\7-Zip\7z x "%DOWNLOADS_DIR%\%PACKAGE%" >NUL
	)
    if not "%UNZIPPED%" == "??" (
        if exist %UNZIPPED% if not exist %TARGET% (
            echo Renaming %UNZIPPED% to %TARGET%
            rename %UNZIPPED% %TARGET%
            if not "%KEEP_PACKAGES%" == "TRUE" del "%DOWNLOADS_DIR%\%PACKAGE%"
        )
  )

  popd
)
goto done

:download_package
set PACKAGE=%~1
set PACKAGE_URL=%~2
set TARGET=%~3
if not exist "%DOWNLOADS_DIR%\%PACKAGE%" if not exist "%TOOLS_DIR%\%TARGET%" (
	echo %PACKAGE_URL% >> %DOWNLOADS%
)
goto done

:install_jdk_6
set PACKAGE_NAME=%~1
set PACKAGE=%~2
set TARGET=%~3
if not exist %PACKAGE% goto done
if exist %TARGET% goto done

echo Installing %PACKAGE_NAME% ...
echo ... extracting package ...
%TOOLS_DIR%\7-Zip\7z x -y %PACKAGE% -o%DOWNLOADS_DIR%\JDK >NUL
pushd %DOWNLOADS_DIR%\JDK

rem extract tools.zip
extrac32 .rsrc\JAVA_CAB10\111

echo ... extracting tools ...
%TOOLS_DIR%\7-Zip\7z x tools.zip -otools >NUL

echo ... unpacking jars ...
cd tools
for /r %%x in (*.pack) do (
  .\bin\unpack200 -r "%%x" "%%~dx%%~px%%~nx.jar"
) 
popd

echo ... copying files ...
xcopy /E %DOWNLOADS_DIR%\JDK\tools %TARGET%\ >NUL
rmdir /S /Q %DOWNLOADS_DIR%\JDK >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del %PACKAGE%
echo ... done.
echo.
goto done


:install_jdk
set PACKAGE_NAME=%~1
set PACKAGE=%~2
set TARGET=%~3
if not exist %PACKAGE% goto done
if exist %TARGET% goto done

echo Installing %PACKAGE_NAME% ...
echo ... extracting package ...
%TOOLS_DIR%\7-Zip\7z e -y %PACKAGE% -o%DOWNLOADS_DIR%\JDK >NUL
pushd %DOWNLOADS_DIR%\JDK

echo ... extracting tools ...
%TOOLS_DIR%\7-Zip\7z x tools.zip >NUL

echo ... unpacking jars ...
for /r %%x in (*.pack) do (
	.\bin\unpack200 -r %%x %%~dx%%~px%%~nx.jar >NUL
)
popd

echo ... copying files ...
xcopy /E %DOWNLOADS_DIR%\JDK %TARGET%\ >NUL
rmdir /S /Q %DOWNLOADS_DIR%\JDK >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del %PACKAGE%
echo ... done.
echo.

:done
