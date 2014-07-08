@REM FILENAME: Page-File-Size.bat
@REM PURPOSE: Sets PageFile to a static 1.5 times the amount of RAM, with a max of 4095 MB for 32-bit systems.
@REM AUTHOR: Josh Cooley (cooley.josh@gmail.com)

@echo off
echo.

for /F "tokens=4 USEBACKQ" %%a in (`systeminfo ^| findstr /C:"Total Physical"`) do set RAM=%%a
for /f "tokens=1,2 delims= " %%n in ('echo %RAM%') do set RAM=%%n%%o
echo Amount of RAM: %RAM% MB
echo.

set /a "pfsize=3*%RAM%/2"
echo.

@REM Tests if we're on 32-bit AND if (1.5*the amount of RAM) is greater than 4095 MB.
@REM If so, sets the pfsize variable to the maximum of 4095 MB.
IF %PROCESSOR_ARCHITECTURE%==x86 IF %pfsize% GTR 4095 set pfsize=4095

echo ********************************
echo * Setting Page File to %pfsize% MB *
echo ********************************
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%pfsize%,MaximumSize=%pfsize%
echo.

echo Done.
echo ************************************************************
echo * Please reboot for the new Page File Size to take effect. *
echo ************************************************************
echo.
PAUSE