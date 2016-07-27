@echo off

set INSTALLER=%1

set EXTRACT=%~dp0extract

rmdir /s /q %EXTRACT% >NUL 2>&1
rmdir /s /q %userprofile%\appdata\locallow\Oracle\Java >NUL 2>&1

NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE
GOTO ADMINTASKS

:ELEVATE
echo Elevating command shell...
CD %~dp0
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"

echo Waiting for process...
PING 1.1.1.1 -n 1 -w 3000 >NUL

if not exist %EXTRACT% goto ERROR

set wait_cycles=10
:wait_loop
set /a wait_cycles-=1
PING 1.1.1.1 -n 1 -w 1000 >NUL
if not exist %EXTRACT%\done if wait_cycles GTR 0 goto wait_loop

if not exist %EXTRACT%\done goto ERROR

expand -R %EXTRACT%\*.cab %EXTRACT%
goto DONE

:ADMINTASKS

md %EXTRACT%

echo Starting installer...
start /d %~dp0 %INSTALLER% /q

PING 1.1.1.1 -n 1 -w 5000 >NUL

echo Copying MSI and CAB files...
for /R "%userprofile%\appdata\locallow\Oracle\Java" %%f in (*.msi, *.cab) do copy "%%f" "%EXTRACT%" >NUL 2>&1

echo Killing installer...
taskkill /F /IM %INSTALLER% /T >NUL 2>&1

setlocal enableextensions
set count=0
rem for %%x in (dir %EXTRACT%\*.msi ) do set /a count+=1
for /R %EXTRACT% %%x in (*.msi, *.cab ) do set /a count+=1
echo Got %count% files.
if %count% NEQ 0 goto DONE

echo.
echo Did not get any files. Retrying...
echo.
PING 1.1.1.1 -n 1 -w 5000 >NUL
goto ADMINTASKS 

:ERROR
echo Unable to elevate the shell.
exit /B 1

:DONE
echo done>%EXTRACT%\done
exit /B 0
