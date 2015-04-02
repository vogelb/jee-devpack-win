@echo off
rem ===================================================================
rem JEE DevPack Installation Script
rem - Download and install binary packages
rem - To Update a package, remove the exploded folder from the dev pack
rem
rem Included packages:
rem - Oracle JDK
rem - RedHat Wildfly
rem - Apache Maven
rem - Eclipse JEE package
rem - Notepad++
rem - JBoss Forge
rem ===================================================================

set TOOLS_DIR=%~dp0tools
set WGET=%~dp0bin\wget
set WGET_OPTIONS=--no-check-certificate --no-cookies 
set DOWNLOADS_DIR=%TOOLS_DIR%\downloads
set DOWNLOADS=%DOWNLOADS_DIR%\download_packages.txt

rem KEEP_PACKAGES: If set to true, downloaded packages will not be deleted after installation
set KEEP_PACKAGES=TRUE

set JDK8_URL=http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-windows-x64.exe
set JDK8_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_PACKAGE=jdk-8u40-windows-x64.exe

set ECLIPSE_URL=http://mirror.switch.ch/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-jee-luna-SR2-win32-x86_64.zip
set ECLIPSE_EXPLODED=eclipse-jee-luna-SR2-win32-x86_64
set ECLIPSE_PACKAGE=%ECLIPSE_EXPLODED%.zip

set MAVEN_URL=http://mirror.switch.ch/mirror/apache/dist/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip
set MAVEN_EXPLODED=apache-maven-3.3.1
set MAVEN_PACKAGE=%MAVEN_EXPLODED%-bin.zip

set WILDFLY_URL=http://download.jboss.org/wildfly/8.2.0.Final/wildfly-8.2.0.Final.zip
set WILDFLY_EXPLODED=wildfly-8.2.0.Final
set WILDFLY_PACKAGE=%WILDFLY_EXPLODED%.zip

set NPP_URL=http://dl.notepad-plus-plus.org/downloads/6.x/6.7.5/npp.6.7.5.bin.zip
set NPP_EXPLODED=npp.6.7.5.bin
set NPP_PACKAGE=%NPP_EXPLODED%.zip

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

:download
if not exist %TOOLS_DIR% mkdir %TOOLS_DIR%
if exist %DOWNLOADS% del %DOWNLOADS%
if not exist %DOWNLOADS_DIR% mkdir %DOWNLOADS_DIR%

:download_wildfly
if exist tools\wildfly goto download_maven
if exist %DOWNLOADS_DIR%\%WILDFLY_PACKAGE% goto download_maven
echo %WILDFLY_URL% >> %DOWNLOADS%

:download_maven
if exist tools\mvn goto download_eclipse
if exist %DOWNLOADS_DIR%\%MAVEN_PACKAGE% goto download_eclipse
echo %MAVEN_URL% >> %DOWNLOADS%

:download_eclipse
if exist tools\eclipse goto download_npp
if exist %DOWNLOADS_DIR%\%ECLIPSE_PACKAGE% goto download_npp
echo %ECLIPSE_URL% >> %DOWNLOADS%

:download_npp
if exist tools\npp goto download_forge
if exist %DOWNLOADS_DIR%\%NPP_PACKAGE% goto download_forge
echo %NPP_URL% >> %DOWNLOADS%

:download_forge
if exist tools\forge goto download_jdk8
if exist %DOWNLOADS_DIR%\%FORGE_PACKAGE% goto download_jdk8
echo %FORGE_URL% >> %DOWNLOADS%

:download_jdk8
if exist tools\jdk_8 goto execute_downloads
if exist %DOWNLOADS_DIR%\%JDK8_PACKAGE% goto execute_downloads
echo Downloading JDK 8...
%WGET% %JDK8_OPTIONS% --directory-prefix %DOWNLOADS_DIR% %JDK8_URL%

:execute_downloads
if not exist %DOWNLOADS% goto install
echo Downloading files:
type %DOWNLOADS%

rem Provide user and prompt for password if required (e.g. download from internal nexus or web space)
rem echo Please provide your nexus credentials.
rem wget --directory-prefix %TOOLS_DIR% --http-user=%SVN_USER% --ask-password -i %DOWNLOADS%
%WGET% %WGET_OPTIONS% --directory-prefix %DOWNLOADS_DIR% -i %DOWNLOADS%

del %DOWNLOADS%

:install
if not exist %DOWNLOADS_DIR%\%JDK8_PACKAGE% goto install_packages
if exist %TOOLS_DIR%\jdk_8 goto install_packages
echo Installing JDK 8 ..
%TOOLS_DIR%\7-Zip\7z e %DOWNLOADS_DIR%\%JDK8_PACKAGE% -o%DOWNLOADS_DIR%\JDK >NUL
pushd %DOWNLOADS_DIR%\JDK
%TOOLS_DIR%\7-Zip\7z x tools.zip >NUL
for /r %%x in (*.pack) do (
	.\bin\unpack200 -r %%x %%~dx%%~px%%~nx.jar
)
popd
move %DOWNLOADS_DIR%\JDK %TOOLS_DIR%\jdk_8 >NUL
if not "%KEEP_PACKAGES%" == "TRUE" del %DOWNLOADS_DIR%\%JDK8_PACKAGE%

:install_packages
call :install_package "Maven" %MAVEN_PACKAGE% %MAVEN_EXPLODED% mvn
call :install_package "Eclipse JEE Luna" %ECLIPSE_PACKAGE% %ECLIPSE_EXPLODED% eclipse
call :install_package "Wildfly 8.1" %WILDFLY_PACKAGE% %WILDFLY_EXPLODED% wildfly
call :install_package "Notepad++ 6.7.5" %NPP_PACKAGE% --create-- npp
call :install_package "JBoss Forge 2.15.2" %FORGE_PACKAGE% %FORGE_EXPLODED% forge

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
if exist %DOWNLOADS_DIR%\%PACKAGE% if not exist %TOOLS_DIR%\%TARGET% (
    echo Unpacking %NAME% to %TOOLS_DIR%\%TARGET%...
    pushd %TOOLS_DIR%
	if "%UNZIPPED%" == "--create--" (
		%TOOLS_DIR%\7-Zip\7z x %DOWNLOADS_DIR%\%PACKAGE% -o%TARGET% >NUL
		set UNZIPPED=%TARGET%
	) else (
		%TOOLS_DIR%\7-Zip\7z x %DOWNLOADS_DIR%\%PACKAGE% >NUL
	)
    if not "%UNZIPPED%" == "??" (
        if exist %UNZIPPED% if not exist %TARGET% (
            echo Renaming %UNZIPPED% to %TARGET%
            rename %UNZIPPED% %TARGET%
            if not "%KEEP_PACKAGES%" == "TRUE" del %DOWNLOADS_DIR%\%PACKAGE%
        )
  )

  popd
)

:done
