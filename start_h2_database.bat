@echo off
rem ===================================================================
rem DevPack: Start H2 database
rem ===================================================================

call setenv.bat

java -cp %JBOSS_HOME%\modules\system\layers\base\com\h2database\h2\main\h2-1.3.173.jar org.h2.tools.Server