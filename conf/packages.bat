@echo off
rem ===================================================================
rem Java DevPack Package definitions
rem ===================================================================

set BABUN_NAME="Babun"
set BABUN_URL=https://bintray.com/artifact/download/tombujok/babun/babun-1.2.0-dist.zip
set BABUN_EXPLODED=babun-1.2.0
set BABUN_PACKAGE=babun-1.2.0-dist.zip
set BABUN_FOLDER=.babun

set JDK8_NAME="Oracle JDK 8"
set JDK8_URL=http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-windows-x64.exe
set JDK8_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_PACKAGE=jdk-8u111-windows-x64.exe
set JDK8_FOLDER=jdk_8

set JDK8_32_NAME="Oracle JDK 8x32"
set JDK8_32_URL=http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-windows-i586.exe
set JDK8_32_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_32_PACKAGE=jdk-8u111-windows-i586.exe
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

set NOTEPAD_NAME="Notepad++"
set NOTEPAD_URL=https://notepad-plus-plus.org/repository/7.x/7.2.1/npp.7.2.1.bin.x64.zip
set NOTEPAD_EXPLODED=--create--
set NOTEPAD_PACKAGE=npp.7.2.1.bin.x64.zip
set NOTEPAD_FOLDER=npp

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