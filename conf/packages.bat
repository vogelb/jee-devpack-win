@echo off
rem ===================================================================
rem DevPack Package definitions
rem ===================================================================

set DEVPACK_PACKAGES=ANSICON JDK10 OPENJDK10 JDK8 OPENJDK8 JDK8_32 JDK7 OPENJDK7 JDK6 JDK8_APIDOC ECLIPSE_EE ECLIPSE_JAVA ECLIPSE_CPP ECLIPSE_WORKSPACE MAVEN TOMCAT TOMEE WILDFLY GLASSFISH DOTNET VS NOTEPAD ATOM FORGE SCALA CONSOLE SOURCETREE GIT MELD POSTGRES POSTGRES_JDBC BABUN NODE GITBOOK GITBOOK_EDITOR VAGRANT GRADLE ANT SQUIRREL
set DEVPACK_NO_PURGE=ECLIPSE_WORKSPACE

set ANSICON_NAME=Ansic0n
set ANSICON_VERSION=1.85
set ANSICON_URL=https://github.com/adoxa/ansicon/releases/download/v1.85/ansi185-bin.zip
set ANSICON_TYPE=ZIP
set ANSICON_PACKAGE=ansi185-bin.zip
set ANSICON_EXPLODED=--create--
set ANSICON_FOLDER=ansic0n

set ANT_NAME=Apache Ant
set ANT_VERSION=1.10.5
set ANT_URL=http://www.pirbot.com/mirrors/apache//ant/binaries/apache-ant-1.10.5-bin.zip
set ANT_TYPE=ZIP
set ANT_PACKAGE=apache-ant-1.10.5-bin.zip
set ANT_EXPLODED=apache-ant-1.10.5
set ANT_FOLDER=ant
set ANT_CONFIG=ant

set BABUN_NAME=Babun
set BABUN_VERSION=1.2.0
set BABUN_URL=https://bintray.com/artifact/download/tombujok/babun/babun-1.2.0-dist.zip
set BABUN_TYPE=ZIP
set BABUN_EXPLODED=babun-1.2.0
set BABUN_PACKAGE=babun-1.2.0-dist.zip
set BABUN_FOLDER=babun-1.2.0
set BABUN_POSTINSTALL=babun_postinstall.bat

set OPENJDK10_NAME=Open JDK 10
set OPENJDK10_VERSION=10.0.2
set OPENJDK10_URL=https://download.java.net/java/GA/jdk10/10.0.2/19aef61b38124481863b1413dce1855f/13/openjdk-10.0.2_windows-x64_bin.tar.gz
set OPENJDK10_OPTIONS=
set OPENJDK10_TYPE=ZIP
set OPENJDK10_PACKAGE=openjdk-10.0.2_windows-x64_bin.tar.gz
set OPENJDK10_EXPLODED=jdk-10.0.2
set OPENJDK10_FOLDER=openjdk_10

set OPENJDK8_NAME=Open JDK 8
set OPENJDK8_VERSION=1.8.0.181
set OPENJDK8_URL=https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.181-1/java-1.8.0-openjdk-1.8.0.181-1.b13.ojdkbuild.windows.x86_64.zip
set OPENJDK8_OPTIONS=
set OPENJDK8_TYPE=ZIP
set OPENJDK8_PACKAGE=java-1.8.0-openjdk-1.8.0.181-1.b13.ojdkbuild.windows.x86_64.zip
set OPENJDK8_EXPLODED=java-1.8.0-openjdk-1.8.0.181-1.b13.ojdkbuild.windows.x86_64
set OPENJDK8_FOLDER=openjdk_8

set OPENJDK7_NAME=Open JDK 7
set OPENJDK7_VERSION=1.7.0-u80
set OPENJDK7_URL=https://bitbucket.org/alexkasko/openjdk-unofficial-builds/downloads/openjdk-1.7.0-u80-unofficial-windows-i586-image.zip
set OPENJDK7_OPTIONS=
set OPENJDK7_TYPE=ZIP
set OPENJDK7_PACKAGE=openjdk-1.7.0-u80-unofficial-windows-i586-image.zip
set OPENJDK7_EXPLODED=openjdk-1.7.0-u80-unofficial-windows-i586-image
set OPENJDK7_FOLDER=openjdk_7

set JDK10_NAME=Oracle JDK 10
set JDK10_VERSION=10.0.1
set JDK10_URL=http://download.oracle.com/otn-pub/java/jdk/10.0.1+10/fb4372174a714e6b8c52526dc134031e/jdk-10.0.1_windows-x64_bin.exe
set JDK10_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK10_TYPE=JDK
set JDK10_PACKAGE=jdk-%JDK10_VERSION%_windows-x64_bin.exe
set JDK10_FOLDER=jdk_10

set JDK8_NAME=Oracle JDK 8
set JDK8_VERSION=8u181
set JDK8_URL=http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-windows-x64.exe
set JDK8_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_TYPE=JDK
set JDK8_PACKAGE=jdk-%JDK8_VERSION%-windows-x64.exe
set JDK8_FOLDER=jdk_8

set JDK8_APIDOC_NAME=Oracle JDK 8 Apidoc
set JDK8_APIDOC_VERSION=8u181
set JDK8_APIDOC_URL=http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-docs-all.zip
set JDK8_APIDOC_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_APIDOC_TYPE=ZIP
set JDK8_APIDOC_EXPLODED=docs
set JDK8_APIDOC_PACKAGE=jdk-%JDK8_APIDOC_VERSION%-docs-all.zip
set JDK8_APIDOC_FOLDER=%JDK8_FOLDER%\docs

set JDK8_32_NAME=Oracle JDK 8x32
set JDK8_32_VERSION=8u111
set JDK8_32_URL=http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-windows-i586.exe
set JDK8_32_TYPE=JDK
set JDK8_32_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_32_PACKAGE=jdk-8u111-windows-i586.exe
set JDK8_32_FOLDER=jdk_8_32

set JDK7_NAME=Oracle JDK 7
set JDK7_VERSION=7u79
set JDK7_URL=http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-windows-x64.exe
set JDK7_TYPE=JDK7
set JDK7_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK7_PACKAGE=jdk-7u79-windows-x64.exe
set JDK7_FOLDER=jdk_7

set JDK6_NAME=Oracle JDK 6
set JDK6_VERSION=6u45
set JDK6_URL=http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-windows-x64.exe
set JDK6_TYPE=JDK6
set JDK6_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK6_PACKAGE=jdk-6u45-windows-x64.exe
set JDK6_FOLDER=jdk_6

rem set ECLIPSE_EE_NAME=Eclipse EE
rem set ECLIPSE_EE_VERSION=Photon.R
rem set ECLIPSE_EE_URL=http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-win32-x86_64.zip
rem set ECLIPSE_EE_TYPE=ZIP
rem set ECLIPSE_EE_EXPLODED=eclipse
rem set ECLIPSE_EE_PACKAGE=eclipse-jee-photon-R-win32-x86_64.zip
rem set ECLIPSE_EE_FOLDER=eclipse_ee
rem set ECLIPSE_EE_TOOL_1=start_eclipse_ee.bat

set ECLIPSE_EE_NAME=Eclipse EE
set ECLIPSE_EE_VERSION=Neon
set ECLIPSE_EE_URL=http://ftp.fau.de/eclipse/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-win32-x86_64.zip
set ECLIPSE_EE_TYPE=ZIP
set ECLIPSE_EE_EXPLODED=eclipse
set ECLIPSE_EE_PACKAGE=eclipse-jee-neon-3-win32-x86_64.zip
set ECLIPSE_EE_FOLDER=eclipse_ee
set ECLIPSE_EE_TOOL_1=start_eclipse_ee.bat

set ECLIPSE_JAVA_NAME=Eclipse Java
set ECLIPSE_JAVA_VERSION=Photon.R
set ECLIPSE_JAVA_URL=http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/photon/R/eclipse-java-photon-R-win32-x86_64.zip
set ECLIPSE_JAVA_TYPE=ZIP
set ECLIPSE_JAVA_EXPLODED=eclipse
set ECLIPSE_JAVA_PACKAGE=eclipse-java-photon-R-win32-x86_64.zip
set ECLIPSE_JAVA_FOLDER=eclipse
set ECLIPSE_JAVA_TOOL_1=start_eclipse.bat

set ECLIPSE_CPP_NAME=Eclipse C/C++
set ECLIPSE_CPP_VERSION=Photon.R
set ECLIPSE_CPP_URL=http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/photon/R/eclipse-cpp-photon-R-win32-x86_64.zip
set ECLIPSE_CPP_TYPE=ZIP
set ECLIPSE_CPP_EXPLODED=eclipse
set ECLIPSE_CPP_PACKAGE=eclipse-cpp-photon-R-win32-x86_64.zip
set ECLIPSE_CPP_FOLDER=eclipse_cpp
set ECLIPSE_CPP_TOOL_1=start_eclipse_cpp.bat

rem Option to install preconfigured eclipse workspace
set ECLIPSE_WORKSPACE_NAME=Eclipse workspace
set ECLIPSE_WORKSPACE_VERSION=0
set ECLIPSE_WORKSPACE_URL=
set ECLIPSE_WORKSPACE_TYPE=ZIP
set ECLIPSE_WORKSPACE_PACKAGE=
set ECLIPSE_WORKSPACE_EXPLODED=workspace
set ECLIPSE_WORKSPACE_FOLDER=..\workspace

set MAVEN_NAME=Maven
set MAVEN_VERSION=3.5.4
set MAVEN_URL=http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.zip
set MAVEN_TYPE=ZIP
set MAVEN_EXPLODED=apache-maven-3.5.4
set MAVEN_PACKAGE=%MAVEN_EXPLODED%-bin.zip
set MAVEN_FOLDER=mvn

set TOMCAT_NAME=Apache Tomcat
set TOMCAT_VERSION=7.0.90
set TOMCAT_URL=http://mirror.23media.de/apache/tomcat/tomcat-7/v7.0.90/bin/apache-tomcat-7.0.90-windows-x64.zip
set TOMCAT_TYPE=ZIP
set TOMCAT_EXPLODED=apache-tomcat-7.0.90
set TOMCAT_PACKAGE=apache-tomcat-7.0.90-windows-x64.zip
set TOMCAT_FOLDER=tomcat
set TOMCAT_CONFIG=tomcat
set TOMCAT_TOOL_1=start_tomcat.bat

set TOMEE_NAME=Tom EE
set TOMEE_VERSION=1.7.2
set TOMEE_URL=http://apache.openmirror.de/tomee/tomee-1.7.2/apache-tomee-1.7.2-plus.zip
set TOMEE_TYPE=ZIP
set TOMEE_EXPLODED=apache-tomee-plus-1.7.2
set TOMEE_PACKAGE=apache-tomee-1.7.2-plus.zip
set TOMEE_FOLDER=tomee
set TOMEE_CONFIG=tomee
set TOMEE_TOOL_1=start_tomee.bat

set WILDFLY_NAME=Wildfly
set WILDFLY_VERSION=9.0.2
set WILDFLY_VERSION=9.0.2.Final
set WILDFLY_URL=http://download.jboss.org/wildfly/%WILDFLY_VERSION%/wildfly-%WILDFLY_VERSION%.zip
set WILDFLY_TYPE=ZIP
set WILDFLY_EXPLODED=wildfly-%WILDFLY_VERSION%
set WILDFLY_PACKAGE=%WILDFLY_EXPLODED%.zip
set WILDFLY_FOLDER=wildfly
set WILDFLY_CONFIG=jboss
set WILDFLY_TOOL_1=start_wildfly.bat
set WILDFLY_TOOL_2=start_h2_database.bat

set GLASSFISH_NAME=Glassfish
set GLASSFISH_VERSION=4.1
set GLASSFISH_URL=http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip
set GLASSFISH_TYPE=ZIP
set GLASSFISH_EXPLODED=glassfish-4
set GLASSFISH_PACKAGE=glassfish-4.1.zip
set GLASSFISH_FOLDER=glassfish
set GLASSFISH_TOOL_1=start_glassfish.bat

set NOTEPAD_NAME=Notepad++
set NOTEPAD_VERSION=7.3.3
set NOTEPAD_URL=https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.bin.zip
set NOTEPAD_TYPE=ZIP
set NOTEPAD_EXPLODED=--create--
set NOTEPAD_PACKAGE=npp.%NOTEPAD_VERSION%.bin.zip
set NOTEPAD_FOLDER=npp

set ATOM_NAME=Atom
set ATOM_VERSION=1.16.0
set ATOM_URL=https://github.com/atom/atom/releases/download/v1.16.0/atom-windows.zip
set ATOM_TYPE=ZIP
set ATOM_EXPLODED=Atom
set ATOM_PACKAGE=atom-windows.zip
set ATOM_FOLDER=atom

set FORGE_NAME=JBoss Forge
set FORGE_VERSION=2.15.2
set FORGE_URL=https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/jboss/forge/forge-distribution/2.15.2.Final/forge-distribution-2.15.2.Final-offline.zip
set FORGE_TYPE=ZIP
set FORGE_EXPLODED=forge-distribution-2.15.2.Final
set FORGE_PACKAGE=%FORGE_EXPLODED%-offline.zip
set FORGE_FOLDER=forge
set FORGE_CONFIG=forge

set SCALA_NAME=Scala
set SCALA_VERSION=2.11.7
set SCALA_URL=http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.zip?_ga=1.251179782.1811953383.1443169031
set SCALA_TYPE=ZIP
set SCALA_EXPLODED=scala-2.11.7
set SCALA_PACKAGE=%SCALA_EXPLODED%.zip
set SCALA_FOLDER=scala
set SCALA_CONFIG=scala

set SBT_NAME=SBT
set SBT_VERSION=0.13.9
set SBT_URL=https://dl.bintray.com/sbt/native-packages/sbt/0.13.9/sbt-0.13.9.zip
set SBT_TYPE=ZIP
set SBT_EXPLODED=sbt-0.13.9
set SBT_PACKAGE=%SBT_EXPLODED%.zip
set SBT_FOLDER=sbt

set CONSOLE_NAME=ConsoleZ
set CONSOLE_VERSION=1.18.3
set CONSOLE_URL=https://github.com/cbucher/console/releases/download/1.18.3/ConsoleZ.x64.1.18.3.18143.zip
set CONSOLE_TYPE=ZIP
set CONSOLE_EXPLODED=--create--
set CONSOLE_PACKAGE=ConsoleZ.x64.1.18.3.18143.zip
set CONSOLE_FOLDER=console

rem set CONSOLE_NAME=Console 2
rem set CONSOLE_VERSION=2.0
rem set CONSOLE_URL=http://downloads.sourceforge.net/project/console/console-devel/2.00/Console-2.00b148-Beta_32bit.zip
rem set CONSOLE_TYPE=ZIP
rem set CONSOLE_EXPLODED=Console2
rem set CONSOLE_PACKAGE=Console-2.00b148-Beta_32bit.zip
rem set CONSOLE_FOLDER=console

set SOURCETREE_NAME=SourceTree
set SOURCETREE_VERSION=2.6.9
set SOURCETREE_URL=https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-%SOURCETREE_VERSION%.exe
set SOURCETREE_TYPE=NUPKG
set SOURCETREE_EXPLODED=SourceTree-%SOURCETREE_VERSION%-full.nupkg
set SOURCETREE_PACKAGE=SourceTreeSetup-%SOURCETREE_VERSION%.exe
set SOURCETREE_FOLDER=sourcetree
set SOURCETREE_TOOL_1=start_sourcetree.bat

set GIT_NAME=Git
set GIT_VERSION=2.12.1
set GIT_URL=https://github.com/git-for-windows/git/releases/download/v%GIT_VERSION%.windows.1/PortableGit-%GIT_VERSION%-64-bit.7z.exe
set GIT_TYPE=ZIP
set GIT_EXPLODED=--create--
set GIT_PACKAGE=PortableGit-%GIT_VERSION%-64-bit.7z.exe
set GIT_FOLDER=git
set GIT_CONFIG=git

set MELD_NAME=Meld Merge
set MELD_VERSION=3.16.2
set MELD_URL=https://download.gnome.org/binaries/win32/meld/3.16/Meld-3.16.2-win32.msi
set MELD_TYPE=MSI
set MELD_EXPLODED=
set MELD_PACKAGE=Meld-3.16.2-win32.msi
set MELD_FOLDER=meld
set MELD_CONFIG=meld

set POSTGRES_NAME=PostgreSQL
set POSTGRES_VERSION=9.6.2
set POSTGRES_URL=http://get.enterprisedb.com/postgresql/postgresql-9.6.2-2-windows-x64-binaries.zip
set POSTGRES_TYPE=ZIP
set POSTGRES_PACKAGE=postgresql-9.6.2-2-windows-x64-binaries.zip
set POSTGRES_EXPLODED=pgsql
set POSTGRES_FOLDER=postgres
set POSTGRES_CONFIG=postgres
set POSTGRES_TOOL_1=start_postgres.bat

set POSTGRES_JDBC_NAME=PostgreSQL JDBC Driver
set POSTGRES_JDBC_VERSION=42.2.50
set POSTGRES_JDBC_URL=https://jdbc.postgresql.org/download/postgresql-42.2.5.jar
set POSTGRES_JDBC_TYPE=FILE
set POSTGRES_JDBC_PACKAGE=postgresql-42.2.5.jar
set POSTGRES_JDBC_EXPLODED=
set POSTGRES_JDBC_FOLDER=postgres/lib

set DOTNET_NAME=.NET Core SDK
set DOTNET_VERSION=1.0.4
set DOTNET_URL=https://download.microsoft.com/download/E/7/8/E782433E-7737-4E6C-BFBF-290A0A81C3D7/dotnet-dev-win-x64.1.0.4.zip
set DOTNET_TYPE=ZIP
set DOTNET_PACKAGE=dotnet-dev-win-x64.1.0.4.zip
set DOTNET_EXPLODED=--create--
set DOTNET_FOLDER=dotnet
set DOTNET_CONFIG=dotnet

set VS_NAME=Visual Studio Code
set VS_VERSION=1.11.2
set VS_URL=https://az764295.vo.msecnd.net/stable/6eaebe3b9c70406d67c97779468c324a7a95db0e/VSCode-win32-1.11.2.zip
set VS_TYPE=ZIP
set VS_PACKAGE=VSCode-win32-1.11.2.zip
set VS_EXPLODED=--create--
set VS_FOLDER=vstudio
set VS_TOOL_1=start_visual_studio.bat
set VS_CONFIG=vstudio

set NODE_NAME=Node.js
set NODE_VERSION=6.10.3
set NODE_URL=https://nodejs.org/dist/v6.10.3/node-v6.10.3-win-x64.zip
set NODE_TYPE=ZIP
set NODE_PACKAGE=node-v%NODE_VERSION%-win-x64.zip
set NODE_EXPLODED=node-v%NODE_VERSION%-win-x64
set NODE_FOLDER=nodejs
set NODE_CONFIG=node

set GRADLE_NAME=Gradle
set GRADLE_VERSION=2.2
set GRADLE_URL=https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-all.zip
set GRADLE_TYPE=ZIP
set GRADLE_PACKAGE=gradle-%GRADLE_VERSION%-all.zip
set GRADLE_EXPLODED=gradle-%GRADLE_VERSION%
set GRADLE_FOLDER=gradle
set GRADLE_CONFIG=gradle

set SQUIRREL_NAME=Squirrel SQL
set SQUIRREL_VERSION=3.8.1
set SQUIRREL_URL=https://netcologne.dl.sourceforge.net/project/squirrel-sql/1-stable/3.8.1-plainzip/squirrelsql-3.8.1-standard.zip
set SQUIRREL_TYPE=ZIP
set SQUIRREL_PACKAGE=squirrelsql-%SQUIRREL_VERSION%-standard.zip
set SQUIRREL_EXPLODED=squirrelsql-%SQUIRREL_VERSION%-standard
set SQUIRREL_FOLDER=squirrel
set SQUIRREL_TOOL_1=start_squirrel.bat
