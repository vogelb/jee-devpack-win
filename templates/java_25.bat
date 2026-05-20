@echo off
rem ===================================================================
rem JEE DevPack Installation default Template
rem
rem Configure which packages to install
rem Package configuration (from conf/packages.bat) can be overriden here.
rem
rem Included packages:
rem - Open JDK 25
rem - Apache Maven
rem - Eclipse Java package
rem - Notepad++
rem - Git
rem - SourceTree
rem ===================================================================

rem Set to TRUE if you want Maven installed
set INSTALL_MAVEN=TRUE

rem Select Eclipse installation
rem   FALSE: Dont install eclipse
rem   EE: Install Eclipse for Java EE developers
rem   JAVA: Install Eclipse for Java developers
rem   CPP: Install Eclipse for C/C++ developers
set INSTALL_ECLIPSE=JAVA

rem Set to TRUE if you want to install a preconfigured workspace
rem Additional settings required in package configuration (or here)
set INSTALL_ECLIPSE_WORKSPACE=FALSE

rem Set to TRUE if you want Notepad++ installed
set INSTALL_NOTEPAD=TRUE

rem Set to TRUE to extract source.zip from JDK installation package.
rem This requires to start the installation to extract the installation files.
set INSTALL_JAVA_SOURCE=FALSE

rem Set to TRUE if you want Open JDK 11 installed
set INSTALL_OPENJDK25=TRUE

rem Set to TRUE if you want SourceTree installed
set INSTALL_SOURCETREE=TRUE

rem Set to TRUE if you want the git client installed
set INSTALL_GIT=TRUE

rem Set to TRUE is you want to install PostgreSQL
set INSTALL_POSTGRES=FALSE