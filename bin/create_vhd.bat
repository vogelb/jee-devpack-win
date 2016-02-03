@echo off
rem ===================================================================
rem Create a VHD
rem ===================================================================

set VHD_CONTAINER=%1
set VHD_SIZE=%2
set VHD_LABEL=%3

set VHD_SCRIPT=%~dp0create_vhd.dps

echo create vdisk file=%VHD_CONTAINER% type=expandable maximum=%VHD_SIZE% > %VHD_SCRIPT%
echo select vdisk file=%VHD_CONTAINER% >> %VHD_SCRIPT%
echo attach vdisk >> %VHD_SCRIPT%
echo create partition primary >> %VHD_SCRIPT%
echo format FS=NTFS LABEL="%VHD_LABEL%" >> %VHD_SCRIPT%
echo assign letter=%WORK_DRIVE% >> %VHD_SCRIPT%
diskpart /s %VHD_SCRIPT%
del %VHD_SCRIPT%
