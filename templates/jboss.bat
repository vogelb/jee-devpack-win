@echo off
rem ===================================================================
rem JEE DevPack Installation Template "JBoss"
rem
rem Included packages:
rem - Oracle JDK 8
rem - RedHat Wildfly
rem - Apache Maven
rem - Eclipse JEE package
rem - JBoss Forge
rem ===================================================================

rem Set to TRUE if you want Maven installed
set INSTALL_MAVEN=TRUE

rem Set to TRUE if you want JBoss Forge installed
set INSTALL_FORGE=TRUE

rem Set to TRUE if you want Eclipse installed
set INSTALL_ECLIPSE=TRUE

rem Set to TRUE if you want Notepad++ installed
set INSTALL_NOTEPAD=FALSE

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
set INSTALL_TOMEE=FALSE

rem Set to TRUE if you want Wildfly installed
set INSTALL_WILDFLY=TRUE

rem Set to TRUE if you want Glassfish installed
set INSTALL_GLASSFISH=FALSE

rem Set to TRUE if you want Sublime installed
set INSTALL_SUBLIME=FALSE

rem Set to TRUE if you want to install babun (cygwin shell)
set INSTALL_BABUN=FALSE

rem Set to TRUE if you want Console2 installed
set INSTALL_CONSOLE=FALSE
