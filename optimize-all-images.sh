#!/bin/bash

# 🎯 Script d'optimisation complète pour toutes les images non-WebP
# 📏 Taille optimisée : 1200x800 pour le web
# 🔄 Redimensionne ET convertit en WebP
# 🚀 Optimise tous les dossiers en une seule commande

echo "🎯 OPTIMISATION COMPLÈTE - TOUTES LES IMAGES"
echo "=============================================="

# Configuration
LARGEUR=1200
HAUTEUR=800

# Vérifier ImageMagick
if ! command -v convert &> /dev/null; then
    echo "❌ ImageMagick non trouvé - Installation requise :"
    echo "   brew install imagemagick"
    exit 1
fi

# Fonction d'optimisation d'un dossier
optimize_folder() {
    local folder="$1"
    local count_resize=0
    local count_webp=0
    
    echo ""
    echo "📁 Traitement du dossier : $folder"
    echo "----------------------------------------"
    
    # Trouver toutes les images non-WebP dans le dossier
    while IFS= read -r -d '' image; do
        if [[ -f "$image" ]]; then
            echo "🖼️  Traitement: $(basename "$image")"
            
            # Créer un fichier temporaire pour le redimensionnement
            temp_file="${image}.temp"
            
            # 1. Redimensionner l'image originale
            if convert "$image" -resize "${LARGEUR}x${HAUTEUR}>" "$temp_file" > /dev/null 2>&1; then
                mv "$temp_file" "$image"
                echo "✅ $(basename "$image") redimensionné"
                ((count_resize++))
            else
                echo "❌ Erreur de redimensionnement avec $(basename "$image")"
                rm -f "$temp_file"
                continue
            fi
            
            # 2. Créer une version WebP
            webp_file="${image%.*}.webp"
            if convert "$image" -resize "${LARGEUR}x${HAUTEUR}>" "$webp_file" > /dev/null 2>&1; then
                echo "🔄 $(basename "$webp_file") créé (WebP)"
                ((count_webp++))
            else
                echo "❌ Erreur de conversion WebP avec $(basename "$image")"
                rm -f "$webp_file"
            fi
        fi
    done < <(find "$folder" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp" -o -name "*.tiff" \) -print0)
    
    if [ $count_resize -gt 0 ] || [ $count_webp -gt 0 ]; then
        echo "🎉 $count_resize image(s) redimensionnée(s) et $count_webp version(s) WebP créée(s) dans $folder"
    else
        echo "ℹ️  Aucune image à optimiser dans $folder"
    fi
}

# Liste des dossiers à optimiser
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

# Optimiser chaque dossier
for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        optimize_folder "$folder"
    else
        echo "⚠️  Dossier non trouvé : $folder"
    fi
done

echo ""
echo "🎯 OPTIMISATION TERMINÉE !"
echo "=========================="
echo "📏 Taille optimisée : ${LARGEUR}x${HAUTEUR}"
echo "🔄 Images redimensionnées + versions WebP créées"
echo "🚀 Toutes les images sont prêtes pour le web !"
echo ""
echo "💡 Pour redémarrer le serveur :"
echo "   lsof -ti:8000 | xargs kill -9 && python3 -m http.server 8000 &" 