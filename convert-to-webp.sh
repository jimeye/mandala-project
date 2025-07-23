#!/bin/bash

# 🔄 Script de conversion WebP pour toutes les images non-WebP
# 📝 Usage: ./convert-to-webp.sh [dossier]
# 🎯 Exemple: ./convert-to-webp.sh images/webp/images-inde

echo "🔄 CONVERSION WEBP - TOUTES LES IMAGES"
echo "======================================="

# Vérifier les arguments
if [ $# -lt 1 ]; then
    echo "❌ Usage: $0 [dossier]"
    echo "📝 Exemple: $0 images/webp/images-inde"
    exit 1
fi

DOSSIER="$1"

# Vérifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "❌ Le dossier '$DOSSIER' n'existe pas"
    exit 1
fi

# Vérifier ImageMagick
if ! command -v convert &> /dev/null; then
    echo "❌ ImageMagick non trouvé - Installation requise :"
    echo "   brew install imagemagick"
    exit 1
fi

echo ""
echo "🎯 Configuration:"
echo "   Dossier: $DOSSIER"
echo ""

# Compter les images non-WebP
NB_IMAGES=$(find "$DOSSIER" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.JPG" -o -name "*.JPEG" -o -name "*.PNG" \) | wc -l)
echo "📊 Images non-WebP trouvées: $NB_IMAGES"

if [ $NB_IMAGES -eq 0 ]; then
    echo "❌ Aucune image non-WebP trouvée dans le dossier"
    exit 1
fi

echo ""
echo "🔄 Début de la conversion WebP..."
echo "----------------------------------------"

# Traiter chaque image non-WebP avec gestion des espaces
find "$DOSSIER" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.JPG" -o -name "*.JPEG" -o -name "*.PNG" \) -print0 | while IFS= read -r -d '' image; do
    # Obtenir le nom de base sans extension
    nom_base="${image%.*}"
    webp_file="${nom_base}.webp"
    
    echo "🖼️  Conversion: $(basename "$image")"
    echo "   → $(basename "$webp_file")"
    
    # Convertir en WebP avec ImageMagick
    if convert "$image" "$webp_file" > /dev/null 2>&1; then
        echo "   ✅ Converti avec succès"
    else
        echo "   ❌ Erreur lors de la conversion"
    fi
    echo ""
done

echo "🎉 Conversion WebP terminée !"
echo "📁 Dossier: $DOSSIER"
echo "🚀 Images WebP créées à côté des originaux" 