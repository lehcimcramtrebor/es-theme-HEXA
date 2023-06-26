@echo off
SETLOCAL

REM Définition du répertoire de travail
set "workingdir=%CD%"

REM Vérification des fichiers nécessaires dans le répertoire de travail
if not exist "%workingdir%\color.png" (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    pause
    exit /b
)
if not exist "%workingdir%\container.xml" (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    pause
    exit /b
)
if not exist "%workingdir%\layout.xml" (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    pause
    exit /b
)
if not exist "%workingdir%\theme.xml" (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    pause
    exit /b
)

REM Récupération du nom du répertoire de travail
for %%i in ("%workingdir%") do set "dirname=%%~nxi"

REM Remonter d'un niveau
cd ..

REM Copie du répertoire de travail sur le bureau
set "desktoppath=%USERPROFILE%\Desktop"
xcopy "%dirname%" "%desktoppath%\%dirname%" /E /I

REM Navigation vers le nouveau répertoire sur le bureau
cd "%desktoppath%\%dirname%"

REM Suppression des fichiers spécifiés
del /S *pi*
del /S container.xml
del /S layout.xml

REM Redimensionnement et optimisation des fichiers PNG
for /R %%F in (*color*.png) do (
    magick "%%F" -resize x446 "%%F"
    pngquant --force --ext .png "%%F"
)
