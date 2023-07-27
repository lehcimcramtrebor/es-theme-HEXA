#!/bin/bash

# Vérifie si pngquant est installé
if ! command -v pngquant &> /dev/null; then
    zenity --error --width=200 --height=100 --text="pngquant n'est pas installé. Veuillez l'installer en utilisant la commande: sudo apt install pngquant"
    exit 1
fi

# Récupère le bureau de l'utilisateur
bureau_utilisateur=$(xdg-user-dir DESKTOP)

# Fonction pour créer une sauvegarde des images PNG
sauvegarde_png () {
    # Récupère le répertoire courant et la date et l'heure actuelles
    repertoire_courant=$(basename "$PWD")
    date_heure=$(date '+%Y-%m-%d_%H-%M-%S')

    # Crée le répertoire de sauvegarde sur le bureau si nécessaire
    repertoire_sauvegarde="$bureau_utilisateur/Backup-PNG/$repertoire_courant-$date_heure"
    mkdir -p "$repertoire_sauvegarde"

    # Copie les fichiers PNG dans le répertoire de sauvegarde
    for fichier in "$@"
    do
        cp "$fichier" "$repertoire_sauvegarde"
    done
}

# Fonction pour optimiser les images PNG
optimiser_png () {
    for fichier in "$@"
    do
        pngquant --force --ext .png "$fichier"
    done
}

# Vérifie si des fichiers PNG ont été fournis en arguments
if [ $# -gt 0 ]; then
    # Si oui, sauvegarde et optimise ces fichiers
    sauvegarde_png "$@"
    optimiser_png "$@"
    fichiers=$@
else
    # Sinon, sauvegarde et optimise tous les fichiers PNG du répertoire courant
    fichiers=$(find . -maxdepth 1 -name "*.png")
    sauvegarde_png $fichiers
    optimiser_png $fichiers
fi

# Résumé des opérations
zenity --info --width=200 --height=100 --text="Optimisation terminée pour : $fichiers"
