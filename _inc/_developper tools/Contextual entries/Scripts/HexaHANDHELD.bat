@echo off
SETLOCAL

REM D‚finition du r‚pertoire de travail
set "workingdir=%CD%"

REM V‚rification des fichiers n‚cessaires dans le r‚pertoire de travail
if not exist "%workingdir%\color.png" (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
    pause
    exit /b
)
if not exist "%workingdir%\container.xml" (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
    pause
    exit /b
)
if not exist "%workingdir%\layout.xml" (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
    pause
    exit /b
)
if not exist "%workingdir%\theme.xml" (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
    pause
    exit /b
)

REM R‚cup‚ration du nom du r‚pertoire de travail
for %%i in ("%workingdir%") do set "dirname=%%~nxi"

REM Remonter d'un niveau
cd ..

REM Copie du r‚pertoire de travail sur le bureau
set "desktoppath=%USERPROFILE%\Desktop"
xcopy "%dirname%" "%desktoppath%\%dirname%" /E /I

REM Navigation vers le nouveau r‚pertoire sur le bureau
cd "%desktoppath%\%dirname%"

REM Suppression des fichiers sp‚cifi‚s
del /S *pi*
del /S container.xml
del /S layout.xml

REM Redimensionnement et optimisation des fichiers PNG
for /R %%F in (*color*.png) do (
    magick "%%F" -resize x446 "%%F"
    pngquant --force --ext .png "%%F"
)
olor*.png) do (
    magick "%%F" -resize x446 "%%F"
    pngquant --force --ext .png "%%F"
)
