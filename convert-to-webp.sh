#!/bin/bash

# 🔄 Script de conversion WebP pour toutes les images non-WebP
# 📏 Garde la taille originale
# 🚀 Convertit tous les dossiers en une seule commande

echo "🔄 CONVERSION WEBP - TOUTES LES IMAGES"
echo "======================================"

# Vérifier ImageMagick
if ! command -v convert &> /dev/null; then
    echo "❌ ImageMagick non trouvé - Installation requise :"
    echo "   brew install imagemagick"
    exit 1
fi

# Fonction de conversion d'un dossier
convert_folder() {
    local folder="$1"
    local count=0
    
    echo ""
    echo "📁 Conversion du dossier : $folder"
    echo "----------------------------------------"
    
    # Trouver toutes les images non-WebP dans le dossier
    while IFS= read -r -d '' image; do
        if [[ -f "$image" ]]; then
            echo "🖼️  Conversion: $(basename "$image")"
            
            # Créer le nom du fichier WebP
            webp_file="${image%.*}.webp"
            
            # Convertir en WebP (garder la taille originale)
            if convert "$image" "$webp_file" > /dev/null 2>&1; then
                echo "✅ $(basename "$webp_file") créé (WebP)"
                ((count++))
            else
                echo "❌ Erreur de conversion avec $(basename "$image")"
                rm -f "$webp_file"
            fi
        fi
    done < <(find "$folder" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp" -o -name "*.tiff" \) -print0)
    
    if [ $count -gt 0 ]; then
        echo "🎉 $count version(s) WebP créée(s) dans $folder"
    else
        echo "ℹ️  Aucune image à convertir dans $folder"
    fi
}

# Liste des dossiers à convertir
folders=(
    "images/about"
    "images/cuisine"
    "images/villa"
    "images/retraites"
    "images/retraites-old"
    "images/retraites-ibiza"
    "images/hero"
    "images"
)

# Convertir chaque dossier
for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        convert_folder "$folder"
    else
        echo "⚠️  Dossier non trouvé : $folder"
    fi
done

echo ""
echo "🔄 CONVERSION TERMINÉE !"
echo "========================"
echo "📏 Taille originale conservée"
echo "🔄 Versions WebP créées"
echo "🚀 Toutes les images sont prêtes !"
echo ""
echo "💡 Pour redémarrer le serveur :"
echo "   lsof -ti:8000 | xargs kill -9 && python3 -m http.server 8000 &" 