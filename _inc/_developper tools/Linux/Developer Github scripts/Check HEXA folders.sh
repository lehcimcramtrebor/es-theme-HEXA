#!/bin/bash

LOGOS_DIR="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-HEXA/_inc/logos/"
THEMES_DIR="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-HEXA/"

echo "Vérification s'il manque un dossier pour chaque fichier PNG..."

# Utilisation de find pour parcourir les fichiers PNG dans LOGOS_DIR
find "$LOGOS_DIR" -type f -iname "*.png" | while read file; do
    file_name=$(basename "$file" .png)
    
    exclude=false
    for a in "-fr" "-ca" "-de" "-es" "-it" "-nl" "-pt" "-ptbr" "-engb" "_alt" "-alt" "_backup"; do
        if [[ "$file_name" == *"$a"* ]]; then
            exclude=true
            break
        fi
    done

    if [ "$exclude" = false ] && [ ! -d "$THEMES_DIR$file_name" ]; then
        echo "Dossier manquant pour le fichier PNG : $file_name"
    fi
done

echo "Processus terminé. Appuyez sur une touche pour fermer."
read -n 1 -s
