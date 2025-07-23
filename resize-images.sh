#!/bin/bash

# Script pour optimiser les images pour le web
# Usage: ./resize-images.sh [dossier]

# Vérifier les arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 [dossier]"
    echo "Exemple: $0 images/webp/retraites-inde"
    echo "Taille optimisée: 1200x800 (web responsive)"
    exit 1
fi

DOSSIER="$1"
LARGEUR="1200"
HAUTEUR="800"

# Vérifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur: Le dossier $DOSSIER n'existe pas"
    exit 1
fi

echo "🔧 Optimisation web des images dans $DOSSIER..."
echo "📏 Taille optimisée: ${LARGEUR}x${HAUTEUR} (responsive web)"
echo "💾 Noms de fichiers conservés"

# Compter les images avant
NB_AVANT=$(find "$DOSSIER" -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" | wc -l)
echo "📊 Images trouvées: $NB_AVANT"

# Traiter chaque image
find "$DOSSIER" -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" | while read -r image; do
    echo "🖼️  Traitement: $(basename "$image")"
    
    # Créer un fichier temporaire
    temp_file="${image}.temp"
    
    # Redimensionner avec ImageMagick (meilleur support WebP)
    if command -v convert &> /dev/null; then
        # Vérifier si c'est un fichier WebP
        if [[ "$image" == *.webp ]]; then
            echo "🖼️  WebP détecté: $(basename "$image") - redimensionnement avec ImageMagick..."
            # Créer une copie temporaire
            temp_webp="${image}.temp"
            
            # Redimensionner avec ImageMagick (gère WebP nativement)
            if convert "$image" -resize "${LARGEUR}x${HAUTEUR}>" "$temp_webp" > /dev/null 2>&1; then
                mv "$temp_webp" "$image"
                echo "✅ $(basename "$image") redimensionnée (WebP)"
            else
                echo "❌ Erreur avec $(basename "$image")"
                rm -f "$temp_webp"
            fi
        else
            # Traitement normal pour JPG/PNG avec ImageMagick
            temp_file="${image}.temp"
            if convert "$image" -resize "${LARGEUR}x${HAUTEUR}>" "$temp_file" > /dev/null 2>&1; then
                mv "$temp_file" "$image"
                echo "✅ $(basename "$image") redimensionnée"
            else
                echo "❌ Erreur avec $(basename "$image")"
                rm -f "$temp_file"
            fi
        fi
    else
        echo "❌ ImageMagick non trouvé - installation requise: brew install imagemagick"
        exit 1
    fi
done

echo "🎉 Optimisation web terminée !"
echo "📁 Dossier: $DOSSIER"
echo "📏 Taille optimisée: ${LARGEUR}x${HAUTEUR}"
echo "🚀 Images prêtes pour le web !" 