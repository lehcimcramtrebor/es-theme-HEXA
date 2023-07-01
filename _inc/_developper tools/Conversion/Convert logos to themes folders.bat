@echo off
setlocal enabledelayedexpansion

set "folderPath=%~dp0"

for %%G in ("%folderPath%*.png") do (
    md "%%~nG" 2>nul
    move /Y "%%G" "%%~nG\logo.png"
    
    (
    echo ^<?xml version="1.0" encoding="UTF-8"?^>
    echo ^<theme^>
    echo ^<formatVersion^>7^</formatVersion^>
    echo.
    echo     ^<include^>./../theme.xml^</include^>
    echo.
    echo ^</theme^>
    ) > "%%~nG\theme.xml"
)

cd "%folderPath%\jp"
for %%G in ("*.png") do (
    md "%folderPath%%%~nG\jp" 2>nul
    move /Y "%%G" "%folderPath%%%~nG\jp\logo.png"
)

cd "%folderPath%\us"
for %%G in ("*.png") do (
    md "%folderPath%%%~nG\us" 2>nul
    move /Y "%%G" "%folderPath%%%~nG\us\logo.png"
)

rd "%folderPath%\jp" 2>nul
rd "%folderPath%\us" 2>nul
