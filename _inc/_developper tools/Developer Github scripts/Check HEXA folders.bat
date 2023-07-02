@echo off
setlocal enabledelayedexpansion
set LOGOS_DIR=%USERPROFILE%\Documents\Github\es-theme-HEXA\_inc\logos\
set THEMES_DIR=%USERPROFILE%\Documents\Github\es-theme-HEXA\

echo Verification s'il manque un dossier pour chaque fichier PNG...

for %%f in ("%LOGOS_DIR%*.png") do (
    set "file_name=%%~nf"
    
    set "exclude=false"
    for %%a in ("-fr" "-ca" "-de" "-es" "-it" "-nl" "-pt" "-ptbr" "-engb" "_alt" "-alt" "_backup") do (
        if "!file_name:%%~a=!" neq "!file_name!" (
            set "exclude=true"
        )
    )

    if "!exclude!"=="false" (
        if not exist "%THEMES_DIR%!file_name!" (
            echo Dossier manquant pour le fichier PNG : !file_name!
        )
    )
)

echo Processus termin‚. Appuyez sur une touche pour fermer.
pause >nul

