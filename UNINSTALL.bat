@echo off
title AddHashtag Uninstaller
color 07

echo.
echo =====================================
echo        AddHashtag Uninstaller
echo =====================================
echo.

set "INSTALLDIR=C:\Scripts\AddHashtag"
set "SENDTO=%APPDATA%\Microsoft\Windows\SendTo"

choice /M "Do you want to remove AddHashtag?"

if errorlevel 2 (
    echo.
    echo Uninstallation cancelled.
    pause
    exit /b 0
)

echo.

:: Remove SendTo shortcut

if exist "%SENDTO%\AddHashtag.lnk" (
    echo Removing Send To shortcut...
    del "%SENDTO%\AddHashtag.lnk"
) else (
    echo Send To shortcut not found.
)

echo.

:: Remove only AddHashtag folder

if exist "%INSTALLDIR%" (
    echo Removing AddHashtag installation folder...
    rmdir /S /Q "%INSTALLDIR%"
) else (
    echo AddHashtag installation folder not found.
)

echo.

echo =====================================
echo AddHashtag has been removed.
echo =====================================
echo.

echo Note:
echo The C:\Scripts folder was intentionally left untouched.
echo.

pause