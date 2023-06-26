@echo off
SETLOCAL

REM On définit le répertoire de travail.
cd /d %CD%

REM Vérification des fichiers nécessaires dans le répertoire de travail.
if not exist color.png (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    pause
    exit /b
)
if not exist container.xml (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    pause
    exit /b
)
if not exist layout.xml (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    exit /b
)
if not exist theme.xml (
    echo Ce script ne peut être exécuté que depuis un dossier de theme HEXA.
    pause
    exit /b
)

REM Parcours des sous-dossiers et duplication des fichiers png avec 'color' dans le nom mais sans '-pi'
for /R %%G in (*color*.png) do (
    echo %%G | findstr /v /c:"-pi" >nul && (
        set "filename=%%~nG"
        set "extension=%%~xG"
        set "directory=%%~dpG"
        call :duplicateFile
    )
)

REM Redimensionnement des fichiers png terminant par '-pi' à 670p de hauteur
for /R %%G in (*-pi.png) do (
    magick "%%G" -resize x670 "%%G"
)

REM Optimisation de tous les fichiers png avec pngquant
for /R %%G in (*.png) do (
    pngquant --ext .png --force "%%G"
)

goto :eof

:duplicateFile
    copy "%directory%%filename%%extension%" "%directory%%filename%-pi%extension%"
goto :eof
