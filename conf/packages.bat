@echo off
rem ===================================================================
rem DevPack Package definitions
rem  Be sure to escape % using %% in package URLs!
rem ===================================================================

set DEVPACK_PACKAGES=OPENJDK8 OPENJDK11 OPENJDK17 OPENJDK25 JDK8 JDK8_32 JDK8_APIDOC JDK10 ECLIPSE_EE ECLIPSE_JAVA ECLIPSE_CPP ECLIPSE_WORKSPACE MAVEN DOTNET VS NOTEPAD ATOM SCALA SOURCETREE GIT MELD POSTGRES POSTGRES_JDBC NODE SQUIRREL INTELLIJ
set DEVPACK_NO_PURGE=ECLIPSE_WORKSPACE

set OPENJDK8_NAME=Open JDK 8
set OPENJDK8_VERSION=1.8.0
set OPENJDK8_URL=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u362-b09/OpenJDK8U-jdk_x64_windows_hotspot_8u362b09.zip
set OPENJDK8_OPTIONS=
set OPENJDK8_TYPE=ZIP
set OPENJDK8_PACKAGE=OpenJDK8U-jdk_x64_windows_hotspot_8u362b09.zip
set OPENJDK8_EXPLODED=jdk8u362-b09
set OPENJDK8_FOLDER=openjdk_8

set OPENJDK11_NAME=Open JDK 11
set OPENJDK11_VERSION=11.0.20
set OPENJDK11_URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20+8/OpenJDK11U-jdk_x64_windows_hotspot_11.0.20_8.zip
set OPENJDK11_OPTIONS=--no-check-certificate --no-cookies
set OPENJDK11_TYPE=ZIP
set OPENJDK11_PACKAGE=OpenJDK11U-jdk_x64_windows_hotspot_11.0.20_8.zip
set OPENJDK11_EXPLODED=jdk-11.0.20+8
set OPENJDK11_FOLDER=openjdk_11

set OPENJDK17_NAME=Open JDK 17
set OPENJDK17_VERSION=17.0.6
set OPENJDK17_URL=https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.6+10/OpenJDK17U-jdk_x64_windows_hotspot_17.0.6_10.zip
set OPENJDK17_OPTIONS=--no-check-certificate --no-cookies
set OPENJDK17_TYPE=ZIP
set OPENJDK17_PACKAGE=OpenJDK17U-jdk_x64_windows_hotspot_17.0.6_10.zip
set OPENJDK17_EXPLODED=jdk-17.0.6+10
set OPENJDK17_FOLDER=openjdk_17

set OPENJDK25_NAME=Adoptium Temurin 25
set OPENJDK25_VERSION=25.0.3+9
set OPENJDK25_URL=https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25.0.3+9/OpenJDK25U-jdk_x64_windows_hotspot_25.0.3_9.zip
set OPENJDK25_OPTIONS=--no-check-certificate --no-cookies
set OPENJDK25_TYPE=ZIP
set OPENJDK25_PACKAGE=OpenJDK25U-jdk_x64_windows_hotspot_25.0.3_9.zip
set OPENJDK25_EXPLODED=jdk-25.0.3+9
set OPENJDK25_FOLDER=jdk_25

set JDK8_NAME=Oracle JDK 8
set JDK8_VERSION=8u212
set JDK8_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_TYPE=JDK
set JDK8_PACKAGE=jdk-%JDK8_VERSION%-windows-x64.exe
set JDK8_FOLDER=jdk_8

set JDK8_APIDOC_NAME=Oracle JDK 8 Apidoc
set JDK8_APIDOC_VERSION=8u181
set JDK8_APIDOC_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_APIDOC_TYPE=ZIP
set JDK8_APIDOC_EXPLODED=docs
set JDK8_APIDOC_PACKAGE=jdk-%JDK8_APIDOC_VERSION%-docs-all.zip
set JDK8_APIDOC_FOLDER=%JDK8_FOLDER%\docs

set JDK8_32_NAME=Oracle JDK 8x32
set JDK8_32_VERSION=8u111
set JDK8_32_TYPE=JDK
set JDK8_32_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK8_32_PACKAGE=jdk-8u111-windows-i586.exe
set JDK8_32_FOLDER=jdk_8_32

set JDK10_NAME=Oracle JDK 10
set JDK10_VERSION=10.0.2
set JDK10_OPTIONS=--no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
set JDK10_TYPE=JDK
set JDK10_PACKAGE=jdk-%JDK10_VERSION%_windows-x64_bin.exe
set JDK10_FOLDER=jdk_10

set ECLIPSE_EE_NAME=Eclipse EE
set ECLIPSE_EE_VERSION=2025-12
set ECLIPSE_EE_URL=https://download.eclipse.org/technology/epp/downloads/release/2025-12/R/eclipse-jee-2025-12-R-win32-x86_64.zip
set ECLIPSE_EE_OPTIONS=--no-check-certificate
set ECLIPSE_EE_TYPE=ZIP
set ECLIPSE_EE_EXPLODED=eclipse
set ECLIPSE_EE_PACKAGE=eclipse-jee-2025-12-R-win32-x86_64.zip
set ECLIPSE_EE_FOLDER=eclipse_ee
set ECLIPSE_EE_TOOL_1=start_eclipse_ee.bat

set ECLIPSE_JAVA_NAME=Eclipse Java
set ECLIPSE_JAVA_VERSION=2026-06
set ECLIPSE_JAVA_URL=https://mirrors.dotsrc.org/eclipse//technology/epp/downloads/release/2026-06/M1/eclipse-java-2026-06-M1-win32-x86_64.zip
set ECLIPSE_JAVA_OPTIONS=--no-check-certificate
set ECLIPSE_JAVA_TYPE=ZIP
set ECLIPSE_JAVA_EXPLODED=eclipse
set ECLIPSE_JAVA_PACKAGE=eclipse-java-2026-06-M1-win32-x86_64.zip
set ECLIPSE_JAVA_FOLDER=eclipse
set ECLIPSE_JAVA_TOOL_1=start_eclipse.bat

set ECLIPSE_CPP_NAME=Eclipse C/C++
set ECLIPSE_CPP_VERSION=Photon.R
set ECLIPSE_CPP_URL=http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/photon/R/eclipse-cpp-photon-R-win32-x86_64.zip
set ECLIPSE_CPP_OPTIONS=--no-check-certificate
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

rem The used version is set in the template!
set MAVEN_NAME=Maven
set MAVEN_3_3_VERSION=3.3.9
set MAVEN_3_3_URL=https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip
set MAVEN_3_3_EXPLODED=apache-maven-%MAVEN_3_3_VERSION%
set MAVEN_3_3_PACKAGE=apache-maven-%MAVEN_3_3_VERSION%-bin.zip
set MAVEN_3_3_FOLDER=mvn_3.3
set MAVEN_3_5_VERSION=3.5.4
set MAVEN_3_5_URL=http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.zip
set MAVEN_3_5_EXPLODED=apache-maven-%MAVEN_3_5_VERSION%
set MAVEN_3_5_PACKAGE=apache-maven-%MAVEN_3_5_VERSION%-bin.zip
set MAVEN_3_5_FOLDER=mvn_3.5
set MAVEN_3_6_VERSION=3.6.3
set MAVEN_3_6_URL=http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
set MAVEN_3_6_EXPLODED=apache-maven-%MAVEN_3_6_VERSION%
set MAVEN_3_6_PACKAGE=apache-maven-%MAVEN_3_6_VERSION%-bin.zip
set MAVEN_3_6_FOLDER=mvn_3.6
set MAVEN_3_9_VERSION=3.9.16
set MAVEN_3_9_URL=https://dlcdn.apache.org/maven/maven-3/3.9.16/binaries/apache-maven-3.9.16-bin.zip
set MAVEN_3_9_EXPLODED=apache-maven-%MAVEN_3_9_VERSION%
set MAVEN_3_9_PACKAGE=apache-maven-%MAVEN_3_9_VERSION%-bin.zip
set MAVEN_3_9_FOLDER=mvn_3.9
set MAVEN_VERSION=%MAVEN_3_9_VERSION%
set MAVEN_URL=%MAVEN_3_9_URL%
set MAVEN_OPTIONS=--no-check-certificate --no-cookies
set MAVEN_EXPLODED=%MAVEN_3_9_EXPLODED%
set MAVEN_PACKAGE=%MAVEN_3_9_PACKAGE%
set MAVEN_TYPE=ZIP
set MAVEN_FOLDER=%MAVEN_3_9_FOLDER%

set NOTEPAD_NAME=Notepad++
set NOTEPAD_VERSION=latest
set NOTEPAD_URL=notepadplusplus
set NOTEPAD_TYPE=SCOOP

set ATOM_NAME=Atom
set ATOM_VERSION=1.16.0
set ATOM_URL=https://github.com/atom/atom/releases/download/v1.16.0/atom-windows.zip
set ATOM_TYPE=ZIP
set ATOM_EXPLODED=Atom
set ATOM_PACKAGE=atom-windows.zip
set ATOM_FOLDER=atom

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

set SOURCETREE_NAME=SourceTree
set SOURCETREE_VERSION=latest
set SOURCETREE_URL=sourcetree
set SOURCETREE_TYPE=SCOOP
set SOURCETREE_FOLDER=extras
set SOURCETREE_TOOL_1=start_sourcetree.bat

set GIT_NAME=Git
set GIT_VERSION=latest
set GIT_URL=git
set GIT_TYPE=SCOOP

set MELD_NAME=Meld Merge
set MELD_VERSION=3.20.0
set MELD_URL=https://download.gnome.org/binaries/win32/meld/3.20/Meld-3.20.0-mingw.msi
set MELD_TYPE=MSI
set MELD_EXPLODED=
set MELD_PACKAGE=Meld-3.20.0-mingw.msi
set MELD_FOLDER=meld
set MELD_CONFIG=meld

set POSTGRES_NAME=PostgreSQL
set POSTGRES_18_VERSION=18.4-1

set POSTGRES_VERSION=%POSTGRES_18_VERSION%
set POSTGRES_TYPE=ZIP
set POSTGRES_EXPLODED=pgsql
set POSTGRES_FOLDER=postgres
set POSTGRES_CONFIG=postgres
set POSTGRES_TOOL_1=start_postgres.bat
set POSTGRES_URL=https://get.enterprisedb.com/postgresql/postgresql-%POSTGRES_VERSION%-windows-x64-binaries.zip
set POSTGRES_PACKAGE=postgresql-%POSTGRES_VERSION%-windows-x64-binaries.zip

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
set NODE_VERSION=latest
set NODE_URL=nodejs
set NODE_TYPE=SCOOP

set SQUIRREL_NAME=Squirrel SQL
set SQUIRREL_VERSION=latest
set SQUIRREL_URL=squirrel-sql
set SQUIRREL_TYPE=SCOOP
set SQUIRREL_TOOL_1=start_squirrel.bat

set INTELLIJ_NAME=IntelliJ IDEA
set INTELLIJ_VERSION=2022.3.2
set INTELLIJ_URL=https://download-cdn.jetbrains.com/idea/ideaIC-2022.3.2.win.zip
set INTELLIJ_OPTIONS=--no-check-certificate --no-cookies
set INTELLIJ_TYPE=ZIP
set INTELLIJ_PACKAGE=ideaIC-%INTELLIJ_VERSION%.win.zip
set INTELLIJ_EXPLODED=--create--
set INTELLIJ_FOLDER=intellij
set INTELLIJ_TOOL_1=start_intellij.bat
