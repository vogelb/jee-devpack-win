@echo off
set DOWNLOADS_DIR=%1
set INSTALLER=%2

set EXTRACT=%DOWNLOADS_DIR%\extract

rmdir /s /q %EXTRACT% >NUL 2>&1
rmdir /s /q %userprofile%\appdata\locallow\Oracle\Java >NUL 2>&1

rem NET SESSION >NUL 2>&1
rem IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE
GOTO ADMINTASKS

:ELEVATE
echo Elevating command shell...
cd /d %~dp0
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('cmd', '/c %~nx0 %DOWNLOADS_DIR% %INSTALLER%', '', 'runas', 1);close();"

echo Waiting for process...
call :sleep 3

if not exist %EXTRACT% goto ERROR

set wait_cycles=10
:wait_loop
set /a wait_cycles-=1
call :sleep 1
if not exist %EXTRACT%\done if wait_cycles GTR 0 goto wait_loop

if not exist %EXTRACT%\done goto ERROR

goto DONE

:ADMINTASKS

mkdir %EXTRACT%

set retries=5
:retry_loop
set /a retries-=1
echo Starting installer...
start /d %DOWNLOADS_DIR% %INSTALLER% /q

call :sleep 30

echo Copying MSI and CAB files...
for /R "%userprofile%\appdata\locallow\Oracle\Java" %%f in (*.msi, *.cab) do copy "%%f" "%EXTRACT%" >NUL 2>&1

echo Killing installer...
taskkill /F /IM %INSTALLER% /T >NUL 2>&1

setlocal enableextensions
set count=0
rem for %%x in (dir %EXTRACT%\*.msi ) do set /a count+=1
for /R %EXTRACT% %%x in (*.msi, *.cab ) do set /a count+=1
echo Got %count% files.
if %count% NEQ 0 goto UNPACK

echo.
echo Did not get any files. Retrying...
echo.
call :sleep 5
if retries GTR 0 goto retry_loop 
echo Error extracting JDK installation files.
exit /B

:sleep
PING 127.0.0.1 -n %1 >NUL
exit /B

:ERROR
echo Unable to elevate the shell.
exit /B 1

:UNPACK
echo Expanding files...
expand -R %EXTRACT%\*.cab %EXTRACT% >NUL
del %EXTRACT%\*.msi
del %EXTRACT%\*.cab

:DONE
echo done>%EXTRACT%\done
exit /B 0
