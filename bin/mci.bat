@echo off
rem =====================================
rem Maven Wrapper for JavA Devpack
rem - Use maven from the dev pack
rem - Use maven setting from the dev pack
rem =====================================

call mvn.bat clean install %*
