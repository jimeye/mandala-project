#!/bin/bash

# Script pour convertir les images JPG en WebP
# Améliore les performances du site web

echo "Conversion des images en WebP..."

# Vérifier si ImageMagick est installé
if ! command -v convert &> /dev/null; then
    echo "ImageMagick n'est pas installé. Installation..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install imagemagick
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        sudo apt-get update && sudo apt-get install -y imagemagick
    else
        echo "Système d'exploitation non supporté. Veuillez installer ImageMagick manuellement."
        exit 1
    fi
fi

# Créer le dossier webp s'il n'existe pas
mkdir -p images/webp

# Convertir toutes les images JPG en WebP
for file in images/*.jpg; do
    if [ -f "$file" ]; then
        filename=$(basename "$file" .jpg)
        echo "Conversion de $file en WebP..."
        convert "$file" -quality 85 "images/webp/${filename}.webp"
    fi
done

# Convertir aussi les images PNG si elles existent
for file in images/*.png; do
    if [ -f "$file" ]; then
        filename=$(basename "$file" .png)
        echo "Conversion de $file en WebP..."
        convert "$file" -quality 85 "images/webp/${filename}.webp"
    fi
done

echo "Conversion terminée ! Les images WebP sont dans le dossier images/webp/"
echo "Vous pouvez maintenant remplacer les références dans vos fichiers HTML." 