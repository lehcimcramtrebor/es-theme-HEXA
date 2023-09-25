#!/bin/bash

source="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-HEXA"
exclusions=(" _inc" "resources" "default" "template" "_hexaCustom" "_support")
destinations=(
    "$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-HEXA-HANDHELD"
    "$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-RCBX"
    "$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-batocer-club-reloaded"
    "$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-comicscrap"
    "$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-ComicScrapV2"
)

declare -A missingFolders

for folder in "$source"/*; do
    if [ -d "$folder" ]; then
        folderName=$(basename "$folder")

        if [ "$folderName" != "_inc" ]; then
            excluded=false
            for exclusion in "${exclusions[@]}"; do
                if [ "$folderName" == "$exclusion" ]; then
                    excluded=true
                    break
                fi
            done

            if [ "$excluded" == false ]; then
                for destination in "${destinations[@]}"; do
                    if [ ! -d "$destination/$folderName" ]; then
                        if [ -z "${missingFolders[$destination]}" ]; then
                            missingFolders[$destination]="$folderName "
                        else
                            missingFolders[$destination]="${missingFolders[$destination]}$folderName "
                        fi
                    fi
                done
            fi
        fi
    fi
done

for destination in "${!missingFolders[@]}"; do
    echo "Les dossiers suivants sont manquants dans l'emplacement $destination :"
    echo "${missingFolders[$destination]}"
done

# Pause before exiting
echo "Appuyez sur une touche pour continuer..."
read -n 1 -s
