@echo off
set DOWNLOADS_DIR=%1
set INSTALLER=%2

set EXTRACT=%DOWNLOADS_DIR%\extract

rmdir /s /q %EXTRACT% >NUL 2>&1
rmdir /s /q %userprofile%\appdata\locallow\Oracle\Java >NUL 2>&1

mkdir %EXTRACT%

set retries=2
:retry_loop
set /a retries-=1
echo starting installer...
start /d %DOWNLOADS_DIR% %INSTALLER% /q

if %ERRORLEVEL% NEQ 0 (
	echo Installer returned with error %ERRORLEVEL%.
	if %retries% GTR 0 (
	   echo Retrying %retries% more times.
	   call :sleep 5
	   goto retry_loop
	)
	echo Aborting installation.
	exit /B %ERRORLEVEL%
)

call :sleep 30

echo copying MSI and CAB files...
for /R "%userprofile%\appdata\locallow\Oracle\Java" %%f in (*.msi, *.cab) do copy "%%f" "%EXTRACT%" >NUL 2>&1

echo killing installer...
taskkill /F /IM %INSTALLER% /T >NUL 2>&1

setlocal enableextensions
set count=0
for /R %EXTRACT% %%x in (*.msi, *.cab ) do set /a count+=1
echo got %count% files.
if %count% NEQ 0 goto UNPACK

echo.
echo did not get any files. Retrying...
echo.
call :sleep 5
if %retries% GTR 0 goto retry_loop 
echo error extracting JDK installation files.
exit /B 1

:UNPACK
echo expanding files...
expand -R %EXTRACT%\*.cab %EXTRACT% >NUL
del %EXTRACT%\*.msi
del %EXTRACT%\*.cab
exit /B 0

:sleep
PING 127.0.0.1 -n %1 >NUL
exit /B
