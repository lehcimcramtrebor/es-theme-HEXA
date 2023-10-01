#!/bin/bash

# Répertoire source
src="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-HEXA/_inc/logos/*"

# Répertoires de destination
dest1="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-batocer-club-reloaded/_inc/logos/"
dest2="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-comicscrap/_assets/logosClassic/"
dest3="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-ComicScrapV2/_inc/logosClassic/"
dest4="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-forever/CUSTOMIZE/logos/"
dest5="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-HEXA-HANDHELD/_inc/logos/"
dest6="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-HUDGEM/_assets/logos/"
dest7="$(xdg-user-dir DOCUMENTS)/GitHub/es-theme-RCBX/_inc/logo/"

# Demande de confirmation
read -p "Êtes-vous sûr de vouloir vider les dossiers de logos classiques des autres dépôts GitHub et d'y copier les logos depuis le dépôt HEXA? (O/N) " confirm
if [ ! "$confirm" = "O" ] && [ ! "$confirm" = "o" ]; then
    exit 0
fi

# Vide et recrée les dossiers de destination
for dest in "$dest1" "$dest2" "$dest3" "$dest4" "$dest5" "$dest6" "$dest7"; do
    if [ -d "$dest" ]; then
        rm -rf "$dest"
    fi
    mkdir -p "$dest"
done

# Copie des fichiers de src vers chaque dest
for dest in "$dest1" "$dest2" "$dest3" "$dest4" "$dest5" "$dest6" "$dest7"; do
    cp -r $src "$dest"
done

echo "Opération terminée."

# Pause before exiting
read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
