@echo off
SETLOCAL

REM On d‚finit le r‚pertoire de travail.
cd /d %CD%

REM V‚rification des fichiers n‚cessaires dans le r‚pertoire de travail.
if not exist color.png (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
    pause
    exit /b
)
if not exist container.xml (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
    pause
    exit /b
)
if not exist layout.xml (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
    exit /b
)
if not exist theme.xml (
    echo Ce script ne peut ˆtre ex‚cut‚ que depuis un dossier de thŠme HEXA.
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

REM Redimensionnement des fichiers png terminant par '-pi' … 670p de hauteur
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
ename%%extension%" "%directory%%filename%-pi%extension%"
goto :eof
