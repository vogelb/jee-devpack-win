@echo off
rem ===================================================================
rem JEE DevPack Installation default Template
rem
rem Included packages:
rem - Oracle JDK 8
rem - Tom EE
rem - Apache Maven
rem - Eclipse JEE package
rem - Notepad++
rem - Console 2
rem ===================================================================

rem Set to TRUE if you want Maven installed
set INSTALL_MAVEN=TRUE

rem Set to TRUE if you want JBoss Forge installed
set INSTALL_FORGE=FALSE

rem Select Eclipse installation
rem   FALSE: Dont install eclipse
rem   EE: Install Eclipse for Java EE developers
rem   JAVA: Install Eclipse for Java developers
rem   CPP: Install Eclipse for C/C++ developers
set INSTALL_ECLIPSE=EE

rem Set to TRUE if you want Notepad++ installed
set INSTALL_NOTEPAD=TRUE

rem Set to TRUE to extract source.zip from JDK installation package.
rem This requires to start the installation to extract the installation files.
set INSTALL_JAVA_SOURCE=TRUE

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

rem Set to TRUE if you want Scala (and sbt) installed
set INSTALL_SCALA=FALSE

rem Set to TRUE if you want TomEE Plus installed
set INSTALL_TOMEE=TRUE

rem Set to TRUE if you want Wildfly installed
set INSTALL_WILDFLY=FALSE

rem Set to TRUE if you want Glassfish installed
set INSTALL_GLASSFISH=FALSE

rem Set to TRUE if you want Sublime installed
set INSTALL_SUBLIME=FALSE

rem Set to TRUE if you want to install babun (cygwin shell)
set INSTALL_BABUN=FALSE

rem Set to TRUE if you want Console2 installed
set INSTALL_CONSOLE=TRUE

rem Set to TRUE if you want SourceTree installed
set INSTALL_SOURCETREE=FALSE

rem Set to TRUE if you want the git client installed
set INSTALL_GIT=FALSE

rem set to TRUE is you want to install Meld Merge
set INSTALL_MELD=FALSE