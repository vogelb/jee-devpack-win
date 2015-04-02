Eclipse / Wildfly based Java Enterprise Dev Pack for Windows
============================================================

This is a Java / Eclipse / Wildfly [DevPack](http://blog.tknerr.de/blog/2014/10/09/devpack-philosophy-aka-works-on-your-machine/) for windows.
It includes standard packages needed to develop in such an environment.

General Idea
------------
The idea of the dev pack is to provide a self contained local development environment in a seperate logical drive (W).
The packages themselves are not included in the devPack but are downloaded during installation.

The Dev Pack includes the following
- Oracle JDK 8
- Apache Maven
- Eclipse JEE
- RedHat WildFly
- Notepad++
- 7-Zip
- Some scripts to help you get going. All scripts are designed to work out of the explorer (double click).

Use of 7-Zip
------------

The devpack ships with a version of 7-Zip that is used for the portable installation of Oracle JDK.

7-Zip is licensed under the GNU LGPL license.

The source code can be obtained here: www.7-zip.org

How to use
----------

To start working, run open_workspace.bat.

A new logical drive "W" will be created and pop up containing your dev pack.

Always work on the W drive because all settings rely on that.

Tools:
- Run init_workspace.bat to create your eclipse workspace. By default, is does not really do much but there are some templates provided to tailor the workspce to your needs
- Run _Start Eclipse" to start the Eclipse IDE.
- Run _Start Command Line to start a windows shell with the correct environment for maven.
- maven is started by typing "mvn" on the command line (wrapped by w:\bin\mvn.bat in order to pass the location of the configuration files)
- You can edit a file with notepad++ by typing "edit <filename>" on the command line
- Run start_h2_database to start the H2 Database included in the wildfly package

Locations
---------

- Global maven settings are in W:\tools\mvn\conf
- Public and private maven settings are in W:\conf
- The local maven repository is w:\tools\mvn-repo
- The toolchains.xml is packaged in w:\conf and copied to the user/.m2 directory
