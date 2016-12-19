@echo off
rem =====================================
rem Initialise git repo
rem =====================================
if not exist .git (
	git init
)

if not exist README.md (
	for %%* in (.) do set CurrDirName=%%~nx*
	echo #%CurrDirName%>README.md
)

rem Detect maven project: Ignore mvn/eclipse files
if exist pom.xml (
	if not exist .gitignore (
		echo /target>.gitignore
		echo /.settings>>.gitignore
		echo /.project>>.gitignore
		echo /.classpath>>.gitignore
	)
		
	git add src
	git add pom.xml
)

if exist .gitignore (
	git add .gitignore
)
git add README.md
