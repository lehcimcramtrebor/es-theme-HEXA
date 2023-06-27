@echo off
setlocal enabledelayedexpansion
set LOGOS_DIR=%USERPROFILE%\Documents\Github\es-theme-HEXA\_inc\logos\
set THEMES_DIR=%USERPROFILE%\Documents\Github\es-theme-HEXA\

echo Verification s'il manque un fichier PNG pour chaque dossier...

for /D %%d in ("%THEMES_DIR%*") do (
    set "dir_name=%%~nxd"
    if "!dir_name!" neq "_inc" (
    if "!dir_name!" neq "_support" (
    if "!dir_name!" neq "_hexaCustom" (
    if "!dir_name!" neq "default" (
    if "!dir_name!" neq "template" (
    if "!dir_name!" neq "resources" (
        if not exist "%LOGOS_DIR%!dir_name!.png" (
            echo Fichier PNG manquant pour le dossier : !dir_name!
        )
    ))))))
)

echo Processus termin‚. Appuyez sur une touche pour fermer.
pause >nul

