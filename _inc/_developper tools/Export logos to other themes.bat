@echo off
setlocal

:: R'pertoire source
set "src=%USERPROFILE%\Documents\Github\es-theme-HEXA\_inc\logos\"

:: R'pertoires de destination
set "dest1=%USERPROFILE%\Documents\Github\es-theme-batocer-club-reloaded\_inc\logos\"
set "dest2=%USERPROFILE%\Documents\Github\es-theme-comicscrap\_assets\logosClassic\"
set "dest3=%USERPROFILE%\Documents\Github\es-theme-ComicScrapV2\_inc\logosClassic\"
set "dest4=%USERPROFILE%\Documents\Github\es-theme-forever\CUSTOMIZE\logos\"
set "dest5=%USERPROFILE%\Documents\Github\es-theme-HEXA-HANDHELD\_inc\logos\"
set "dest6=%USERPROFILE%\Documents\Github\es-theme-HUDGEM\_assets\logos\"
set "dest7=%USERPROFILE%\Documents\Github\es-theme-RCBX\_inc\logo\"
set "dest8=%USERPROFILE%\Documents\Github\es-theme-butterfly\_engine\_inc\logos\"

:: Demande de confirmation
set /P confirm=Etes-vous s–r de vouloir vider les dossiers de logos classiques des autres d‚p“t Github et d'y copier les logos depuis led‚p“t HEXA? (O/N) ?
if /I not "%confirm%"=="O" exit /b

:: Vide et recr'er les dossiers de destination
for /D %%D in ("%dest1%" "%dest2%" "%dest3%" "%dest4%" "%dest5%" "%dest6%" "%dest7%" "%dest8%") do (
    if exist "%%~D" rd /s /q "%%~D"
    mkdir "%%~D"
)

:: Copie des fichiers et des dossiers de src vers chaque dest
for /D %%D in ("%dest1%" "%dest2%" "%dest3%" "%dest4%" "%dest5%" "%dest6%" "%dest7%" "%dest8%") do (
    xcopy /E /I "%src%" "%%~D"
)

endlocal
"%%~D"
)

endlocal
local
