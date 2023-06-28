@echo off
for %%i in (%CD%\*.png) do (
    pngquant --force --ext .png --quality=70-85 "%%i"
)
echo Tous les fichiers PNG ont ‚t‚ optimis‚s.
pause
