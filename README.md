# Configurable DevPack for Windows
[On GitHub](https://github.com/vogelb/jee-devpack-win)

This is a lightweight [DevPack](http://blog.tknerr.de/blog/2014/10/09/devpack-philosophy-aka-works-on-your-machine/) for windows.
It includes standard packages needed to develop in such an environment and is based on a simple installation folder SUBSTed into a self contained work drive (no VM).

The repository name suggests a Java EE environment, however the DevPack has evolved to be more multipurpose over time.

## General Idea

The idea of the dev pack is to provide a self contained local development environment in a separate logical drive (W).
The packages themselves are not included in the devPack but are downloaded during installation.

The Dev Pack supports the following packages:
- Oracle JDK 8 x64
- Oracle JDK 8 x86
- Oracle JDK 7 + 6
- Scala and sbt
- Apache Maven
- Eclipse EE / Java / C++
- TomEE Plus
- RedHat WildFly
- Oracle GlassFish
- Notepad++
- Atom
- .NET Core SDK
- Visual Studio Code
- node.js
- gitbook
- gitbook editor
- 7-Zip
- SourceTree
- PostgreSQL
- Some aliases and scripts to help you get going. Most scripts are designed to work out of the explorer (double click).

## Use of 7-Zip

The devpack ships with a version of 7-Zip that is used for the portable installation of Oracle JDK.

7-Zip by Igor Pavlov is licensed under the GNU LGPL license.

The source code can be obtained here: www.7-zip.org

## Installation

### 1. Check out the dev pack

	$ git clone https://github.com/vogelb/jee-devpack-win
	
### 2. Configure installation and template

| | |
| -------------------------------------------------------------- | ----------------------------------- |
| - Packages will be downloaded to w:\tools\downloads            | -- setup.bat -> DOWNLOADS_DIR       |
| - Installed packages will NOT be deleted                       | -- setup.bat -> KEEP_PACKAGES       |
| - Check the packages you want to use for updates.              | -- conf\packages.bat                |
| - Select and customize a template or create a new one          | -- templates\default.bat            |
| - Add or remove packages as required.                          |                                     | 

### 3. Adapt the dev pack configuration to your needs
| | |
| -------------------------------------- | ----------------------------------- |
| - Working drive is w:\                 |   -- conf/devpack.bat -> WORK_DRIVE |
| - Tools installation dir is w:\tools   |  -- conf/devpack.bat -> TOOLS_DIR   |
| - Workspace location is w:\workspace   |  -- conf/devpack.bat -> WORKSPACE   |
| - Paths and aliases                    |	-- setenv.bat                      |

### 4. To download and install the configured software packages, run

	$ setup install
	
This will install the packages defined in the default template.

	$ setup -t java_8 install
	
Will install the packages defined in the Java 8 template (templates\java_8.bat).

Packages can also be installed and uninstalled regardless of the current template:
	
	$ setup install POSTGRES
	$ setup uninstall POSTGRES
	
Get the list of available packages:
	
	$ setup packages

Get the list of available templates:
	
	$ setup templates
	
## Updates
The DevPack has an update mechanism. When the package configuration is updated on GitHub just issue

	$ git pull
	$ setup update

To update packages yourself, change the package versions and URLs in conf/packages.bat and issue

	$ setup update
	
This will check the installed against configured versions and uninstall, download and install **mismatching** packages (no check for higher version number).

## How to use

To start working, run `open_devpack.bat`, `open_workspace.bat` or `start_eclipse.bat`. The configured logical drive will be created and pop up containing your dev pack.

Always work on the configured drive because paths and settings rely on that. Its also quite convenient because everything is in one place and paths are shorter.

Tools:

- Run `init_workspace.bat` to create your eclipse workspace. By default, is does not really do much but there are some templates provided to tailor the workspace to your needs.

- Run `start_eclipse.bat` to start the Eclipse IDE.

- Run `start_command_shell.bat` to start a windows shell with the correct environment.

- Run `start_cygwin_shell.bat` to start a cygwin shell with the correct environment. Requires cygwin to be installed in c:\cygwin.

- Run `start_h2_database.bat` to start the H2 Database included in the wildfly package

- Run `eclipse_settings` to store, backup or restore your eclipse settings. Settings will be stored in the devpack's conf folder.

- Maven is started by typing `mvn` on the command line (wrapped by \bin\mvn.bat in order to pass the location of the configuration files)

- You can edit a file in notepad++ / sublime by typing `edit <filename>` resp. `sublime <filename>` on the command line

## Locations and shared usage

- Global maven settings are in \tools\mvn\conf
- Public and private maven settings are in \conf
- The local maven repository is \mvn-repo
- The toolchains.xml is packaged in \conf and copied to the user/.m2 directory in init_workspace.bat (if enabled)

In order to share installed tools and local maven config & repository between several instances of the dev pack (e.g. one dev pack per project), configure TOOLS_DIR, PUBLIC_M2_CONFIG and PRIVATE_M2_CONFIG in conf\devpack.bat to point to a global location.
