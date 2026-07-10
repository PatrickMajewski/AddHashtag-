@echo off
title AddHashtag Installer
color 07

echo.
echo =====================================
echo          AddHashtag Installer
echo =====================================
echo.

set "INSTALLDIR=C:\Scripts\AddHashtag"
set "SOURCE=%~dp0"
set "SENDTO=%APPDATA%\Microsoft\Windows\SendTo"

if not exist "%SOURCE%AddHashtag\Taggen.ps1" (
    echo ERROR: Taggen.ps1 not found.
    pause
    exit /b 1
)

if not exist "%SOURCE%AddHashtag\hashtag32.ico" (
    echo ERROR: hashtag32.ico not found.
    pause
    exit /b 1
)

if not exist "%SOURCE%AddHashtag.lnk" (
    echo ERROR: AddHashtag.lnk not found.
    pause
    exit /b 1
)

echo Required files found.
echo.

if exist "%INSTALLDIR%" (
    echo Existing AddHashtag installation detected.
    echo.

    choice /M "Do you want to overwrite the existing installation?"

    if errorlevel 2 (
        echo Installation cancelled.
        pause
        exit /b 0
    )

    echo Updating installation...
) else (
    mkdir "%INSTALLDIR%"
)

echo.

echo Copying Taggen.ps1...
copy "%SOURCE%AddHashtag\Taggen.ps1" "%INSTALLDIR%\Taggen.ps1" /Y >nul

echo Copying hashtag32.ico...
copy "%SOURCE%AddHashtag\hashtag32.ico" "%INSTALLDIR%\hashtag32.ico" /Y >nul

echo Installing Send To shortcut...

if exist "%SENDTO%\AddHashtag.lnk" (
    echo Existing shortcut detected.

    choice /M "Replace existing AddHashtag shortcut?"

    if errorlevel 2 (
        goto FINISH
    )
)

copy "%SOURCE%AddHashtag.lnk" "%SENDTO%\AddHashtag.lnk" /Y >nul


:FINISH

echo.
echo =====================================
echo Installation completed successfully.
echo =====================================
echo.
echo Usage:
echo Right click file -^> Send to -^> AddHashtag
echo.

pause