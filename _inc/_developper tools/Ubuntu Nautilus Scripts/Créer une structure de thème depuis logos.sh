#!/bin/bash

# Vérifier la présence des fichiers requis
required_files=("megadrive" "snes" "nes" "pcengine" "auto-favorites" "mastersystem" "gamegear" "gb" "gbc" "gba")
missing_files=()

for file in "${required_files[@]}"; do
    if [[ ! -f "$file.png" && ! -f "$file.svg" ]]; then
        missing_files+=("$file")
    fi
done

if [[ ${#missing_files[@]} -gt 0 ]]; then
    missing_files_list=$(printf " - %s\n" "${missing_files[@]}")
    zenity --error --text "Certains fichiers requis sont manquants :\n$missing_files_list\nVeuillez exécuter ce script dans le répertoire contenant les fichiers requis."
    exit 1
fi

# Si tous les fichiers requis sont présents, continuer avec le reste du script

desktop_path=$(xdg-user-dir DESKTOP)
folder_name="Theme Structure by Helmic"
new_folder_path="$desktop_path/$folder_name"
counter=1

while [[ -d "$new_folder_path" ]]; do
    new_folder_path="$desktop_path/$folder_name $counter"
    ((counter++))
done

desktop_path=$(xdg-user-dir DESKTOP)
folder_name="Theme Structure by Helmic"
new_folder_path="$desktop_path/$folder_name"
counter=1

while [[ -d "$new_folder_path" ]]; do
    new_folder_path="$desktop_path/$folder_name $counter"
    ((counter++))
done

mkdir "$new_folder_path"
cp -r ./* "$new_folder_path"
cd "$new_folder_path"

# Liste des suffixes valides
valid_suffixes=("-ca" "-de" "-es" "-fr" "-it" "-nl" "-pt" "-us" "-en" "-engb" "-eu" "-e" "-w" "-uk" "-s" "-f" "-d" "-i" "-gr" "-no" "-sw" "-se" "-pl" "-jp" "-j" "-br" "-ru" "-r" "-kr" "-cn" "-as" "-tw" "-c" "-fc" "-in" "-wor" "-wr" "-fre" "-ger" "-ch" "-hk" "-ptbr")

# Traiter les fichiers sans suffixe en premier
for file in *; do
    if [[ -f "$file" ]]; then
        # Vérifier si le fichier est un .png ou .svg
        if [[ "$file" == *.png || "$file" == *.svg ]]; then
            # Extraire le nom de base du fichier sans extension
            base_name="${file%.*}"

            # Vérifier si le nom de base du fichier ne contient pas de suffixe valide
            has_valid_suffix=false
            for suffix in "${valid_suffixes[@]}"; do
                if [[ "$base_name" == *"$suffix" ]]; then
                    has_valid_suffix=true
                    break
                fi
            done

            # Traiter le fichier s'il n'a pas de suffixe valide
            if [[ "$has_valid_suffix" == false ]]; then
                echo "Traitement du fichier sans suffixe : $file"
                # Créer le sous-dossier correspondant au nom du fichier
                folder_name="${file%.*}"
                mkdir "$folder_name"
                # Déplacer le fichier dans le sous-dossier
                mv "$file" "$folder_name"
            fi
        fi
    fi
done

# Traiter les fichiers avec suffixe ensuite
for file in *; do
    if [[ -f "$file" ]]; then
        # Vérifier si le fichier est un .png ou .svg
        if [[ "$file" == *.png || "$file" == *.svg ]]; then
            # Extraire le nom de base du fichier sans extension
            base_name="${file%.*}"

            # Vérifier si le nom de base du fichier contient un suffixe valide
            valid_suffix=""
            for suffix in "${valid_suffixes[@]}"; do
                if [[ "$base_name" == *"$suffix" ]]; then
                    valid_suffix="$suffix"
                    break
                fi
            done

            # Traiter le fichier s'il a un suffixe valide
            if [[ -n "$valid_suffix" ]]; then
                echo "Traitement du fichier avec suffixe : $file (Suffixe valide : $valid_suffix)"
                # Extraire le nom de base sans suffixe
                base_name_no_suffix="${base_name%"$valid_suffix"}"
                # Créer le sous-dossier correspondant au nom de base sans suffixe
                mkdir -p "$base_name_no_suffix"
                # Déplacer le fichier dans le sous-dossier correspondant
                mv "$file" "$base_name_no_suffix"
            fi
        fi
    fi
done

# Traiter les fichiers dans les dossiers "us" et "jp"
for dir in us jp; do
    if [[ -d "$dir" ]]; then
        echo "Traitement des fichiers dans le dossier $dir"
        cd "$dir"
        for file in *; do
            if [[ -f "$file" ]]; then
                # Vérifier si le fichier est un .png ou .svg
                if [[ "$file" == *.png || "$file" == *.svg ]]; then
                    # Extraire le nom de base du fichier sans extension
                    base_name="${file%.*}"
                    # Extraire le suffixe valide du nom de base
                    valid_suffix=""
                    for suffix in "${valid_suffixes[@]}"; do
                        if [[ "$base_name" == *"$suffix" ]]; then
                            valid_suffix="$suffix"
                            break
                        fi
                    done
                    # Extraire le nom de base sans le suffixe
                    base_name_no_suffix="${base_name%"$valid_suffix"}"
                    # Créer le sous-dossier correspondant au nom de base sans suffixe
                    mkdir -p "../$base_name_no_suffix/$dir"
                    # Déplacer le fichier dans le sous-dossier correspondant
                    mv "$file" "../$base_name_no_suffix/$dir"
                fi
            fi
        done
        cd ..
    fi
done

# Supprimer les dossiers "us" et "jp"
rm -r us jp

#!/bin/bash

# Fonction récursive pour parcourir les dossiers et les fichiers
parcourir_dossier() {
    local dossier="$1"
    local nom_dossier="$2"

    # Parcours des fichiers dans le dossier courant
    for fichier in "$dossier"/*; do
        if [ -d "$fichier" ]; then
            # Appel récursif pour parcourir les sous-dossiers
            parcourir_dossier "$fichier" "$nom_dossier"
        elif [ -f "$fichier" ]; then
            # Vérifier si le fichier est un fichier PNG ou SVG
            if [[ "$fichier" == *.png ]] || [[ "$fichier" == *.svg ]]; then
                # Récupérer le nom du fichier sans le chemin
                nom_fichier=$(basename "$fichier")
                # Remplacer les parties du nom du fichier correspondant au nom du dossier par "logo"
                nouveau_nom="${nom_fichier//$nom_dossier/logo}"
                # Renommer le fichier avec le nouveau nom
                mv "$fichier" "$dossier/$nouveau_nom"
            fi
        fi
    done
}

# Parcours des dossiers à la racine
for dossier in */; do
    # Supprimer le slash à la fin du nom du dossier
    nom_dossier="${dossier%/}"
    # Appel de la fonction pour parcourir le dossier et ses sous-dossiers
    parcourir_dossier "$nom_dossier" "$nom_dossier"
done

 Demander à l'utilisateur s'il souhaite créer les fichiers "theme.xml"
if zenity --question --text "Voulez-vous créer les fichiers 'theme.xml' dans chaque dossier ?"; then
    # Parcourir les dossiers
    for dossier in */; do
        # Supprimer le slash à la fin du nom du dossier
        nom_dossier="${dossier%/}"
        # Créer le contenu du fichier "theme.xml"
        contenu='<?xml version="1.0" encoding="UTF-8"?>\n<theme>\n<formatVersion>7</formatVersion>\n\n\t<include>./../theme.xml</include>\n\n</theme>'
        # Créer le fichier "theme.xml" dans chaque dossier
        echo -e "$contenu" >"$nom_dossier/theme.xml"
    done
    zenity --info --text "La structure a été créée avec les fichiers 'theme.xml'."
else
    zenity --info --text "La structure a été créée sans les fichiers 'theme.xml'."
fi

gio set "$new_folder_path" metadata::custom-icon ''




