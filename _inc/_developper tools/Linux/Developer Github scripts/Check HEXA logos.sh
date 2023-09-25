#!/bin/bash

LOGOS_DIR="$HOME/Documents/GitHub/es-theme-HEXA/_inc/logos/"
THEMES_DIR="$HOME/Documents/GitHub/es-theme-HEXA/"

echo "Vérification s'il manque un fichier PNG pour chaque dossier..."

for dir in "$THEMES_DIR"*; do
    if [ -d "$dir" ]; then
        dir_name=$(basename "$dir")
        
        if [ "$dir_name" != "_inc" ] && [ "$dir_name" != "_support" ] && [ "$dir_name" != "_hexaCustom" ] && [ "$dir_name" != "default" ] && [ "$dir_name" != "template" ] && [ "$dir_name" != "resources" ]; then
            if [ ! -e "$LOGOS_DIR$dir_name.png" ]; then
                echo "Fichier PNG manquant pour le dossier : $dir_name"
            fi
        fi
    fi
done

echo "Processus terminé. Appuyez sur une touche pour fermer."
read -n 1 -s
