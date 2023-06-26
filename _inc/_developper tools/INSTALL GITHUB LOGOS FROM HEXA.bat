@echo off
setlocal

:: Répertoire source
set "src=%USERPROFILE%\Documents\Github\es-theme-HEXA\_inc\logos\"

:: Répertoires de destination
set "dest1=%USERPROFILE%\Documents\Github\es-theme-batocer-club-reloaded\_inc\logos\"
set "dest2=%USERPROFILE%\Documents\Github\es-theme-comicscrap\_assets\logosClassic\"
set "dest3=%USERPROFILE%\Documents\Github\es-theme-ComicScrapV2\_inc\logosClassic\"
set "dest4=%USERPROFILE%\Documents\Github\es-theme-forever\CUSTOMIZE\logos\"
set "dest5=%USERPROFILE%\Documents\Github\es-theme-HEXA-HANDHELD\_inc\logos\"
set "dest6=%USERPROFILE%\Documents\Github\es-theme-HUDGEM\_assets\logos\"
set "dest7=%USERPROFILE%\Documents\Github\es-theme-RCBX\_inc\logo\"

:: Demande de confirmation
set /P confirm=Êtes-vous sûr de vouloir vider les dossiers de destination et copier les fichiers depuis le dossier source (O/N) ?
if /I not "%confirm%"=="O" exit /b

:: Vide et recréer les dossiers de destination
for /D %%D in ("%dest1%" "%dest2%" "%dest3%" "%dest4%" "%dest5%" "%dest6%" "%dest7%") do (
    if exist "%%~D" rd /s /q "%%~D"
    mkdir "%%~D"
)

:: Copie des fichiers et des dossiers de src vers chaque dest
for /D %%D in ("%dest1%" "%dest2%" "%dest3%" "%dest4%" "%dest5%" "%dest6%" "%dest7%") do (
    xcopy /E /I "%src%" "%%~D"
)

endlocal
