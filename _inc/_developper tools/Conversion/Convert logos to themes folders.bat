@echo off
setlocal enabledelayedexpansion

set "folderPath=%~dp0"
set "suffixes=-ca -de -es -fr -it -nl -pt -ptbr -usa -us -en -us -eu -e -ue -euro -w -wor -world -wr -uk -spain -s -france -fre -french -f -germany -d -italy -i -netherlands -gr -greece -no -sw -sweden -se -portugal -pl -poland -jp -japan -ja -j -br -brazil -ru -r -kr -lorea -cn -china -hong -kong -ch -hk -as -tw -canada -c -fc -in -india"

for %%G in ("%folderPath%*.png") do (
    set "filename=%%~nG"
    set "suffix="
    call :checkSuffix "!filename!" filename suffix
    md "!filename!" 2>nul
    if defined suffix (
        move /Y "%%G" "!filename!\logo!suffix!.png" >nul
    ) else (
        move /Y "%%G" "!filename!\logo.png" >nul
        (
        echo ^<?xml version="1.0" encoding="UTF-8"?^>
        echo ^<theme^>
        echo ^<formatVersion^>7^</formatVersion^>
        echo.
        echo     ^<include^>./../theme.xml^</include^>
        echo.
        echo ^</theme^>
        ) > "!filename!\theme.xml"
    )
)

cd "%folderPath%\jp"
for %%G in ("*.png") do (
    set "filename=%%~nG"
    set "suffix="
    call :checkSuffix "!filename!" filename suffix
    md "%folderPath%!filename!\jp" 2>nul
    if defined suffix (
        move /Y "%%G" "%folderPath%!filename!\jp\logo!suffix!.png" >nul
    ) else (
        move /Y "%%G" "%folderPath%!filename!\jp\logo.png" >nul
    )
)

cd "%folderPath%\us"
for %%G in ("*.png") do (
    set "filename=%%~nG"
    set "suffix="
    call :checkSuffix "!filename!" filename suffix
    md "%folderPath%!filename!\us" 2>nul
    if defined suffix (
        move /Y "%%G" "%folderPath%!filename!\us\logo!suffix!.png" >nul
    ) else (
        move /Y "%%G" "%folderPath%!filename!\us\logo.png" >nul
    )
)

cd "%folderPath%"
rd "jp" /S /Q
rd "us" /S /Q

goto :eof

:checkSuffix
set "localFilename=%~1"
set "localSuffix="
for %%H in (%suffixes%) do (
    if "!localFilename:~-2!"=="%%H" (
        set "localSuffix=%%H"
        set "localFilename=!localFilename:~0,-2!"
        goto :setResult
    ) else if "!localFilename:~-3!"=="%%H" (
        set "localSuffix=%%H"
        set "localFilename=!localFilename:~0,-3!"
        goto :setResult
    ) else if "!localFilename:~-4!"=="%%H" (
        set "localSuffix=%%H"
        set "localFilename=!localFilename:~0,-4!"
        goto :setResult
    )
)

:setResult
set "%~2=!localFilename!"
set "%~3=!localSuffix!"
goto :eof
