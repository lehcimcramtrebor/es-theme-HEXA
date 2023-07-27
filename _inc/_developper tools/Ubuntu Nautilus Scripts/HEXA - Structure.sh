#!/bin/bash

# Get the user's desktop path
desktop_path="$(xdg-user-dir DESKTOP)"

# 0) Vérifier l'existence des fichiers
if [[ ! -f "./color.png" ]] || [[ ! -f "./container.xml" ]]; then
    zenity --error --text="Le script ne peut être exécuté que dans un dossier de thème HEXA"
    exit 1
fi

# 1) Vérifier l'installation des programmes nécessaires
if ! command -v pngquant &> /dev/null || ! command -v convert &> /dev/null; then
    zenity --error --text="Les programmes pngquant et imagemagick doivent être installés pour exécuter ce script.\nPour installer pngquant: sudo apt install pngquant\nPour installer imagemagick: sudo apt install imagemagick"
    exit 1
fi

# 2) Créer une sauvegarde sur le desktop de l'utilisateur
backup_dir="$desktop_path/Backup-Hexa-Structure/$(basename $(pwd))-$(date +%Y%m%d%H%M)"
mkdir -p "$backup_dir"
cp -r . "$backup_dir"

# 3) Vérifier l'existence des fichiers -pi et les dupliquer si nécessaire
for dir in . us jp; do
    if [[ -d "$dir" ]]; then
        cd "$dir"
        for file in *color*.png; do
            if [[ ! "$file" == *-pi.png ]] && [[ ! -f "${file%.png}-pi.png" ]]; then
                cp "$file" "${file%.png}-pi.png"
            fi
        done
        cd -
    fi
done

# 4) Redimensionner les fichiers -pi
mogrify -geometry x670 *-pi.png

# 5) Optimiser tous les png contenant "color"
find . -name "*color*.png" -exec pngquant --ext .png --skip-if-larger --force {} \;

# 6) Créer un dossier HANDHELD-VERSION et redimensionner les fichiers png contenant "color"
handheld_dir="$desktop_path/HANDHELD-VERSION/$(basename $(pwd))"
mkdir -p "$handheld_dir"
cp -r . "$handheld_dir"
rm "$handheld_dir/container.xml" "$handheld_dir/layout.xml"
rm -r "$handheld_dir/HANDHELD-VERSION"
find "$handheld_dir" -name "*-pi.png" -delete
mogrify -path "$handheld_dir" -geometry x446 "$handheld_dir/*color*.png"
find "$handheld_dir" -name "*color*.png" -exec pngquant --ext .png --skip-if-larger --force {} \;

# 7) Afficher un récapitulatif des actions effectuées
zenity --info --text="Script terminé. Les actions suivantes ont été effectuées:\n1) Les fichiers nécessaires ont été vérifiés.\n2) Une sauvegarde a été créée sur le bureau de l'utilisateur dans $backup_dir.\n3) Les fichiers -pi ont été vérifiés et dupliqués si nécessaire.\n4) Les fichiers -pi ont été redimensionnés à 670p de haut.\n5) Les fichiers png contenant 'color' ont été optimisés.\n6) Un dossier HANDHELD-VERSION a été créé, le dossier parent a été copié à l'intérieur et les fichiers png contenant 'color' ont été redimensionnés à 446p de haut et optimisés.\n"
