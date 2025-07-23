#!/bin/bash

# 🔄 Script de renommage spécifique pour les images de retraite Inde
# 📝 Usage: ./rename-images-inde.sh [dossier] [numero-depart]
# 🎯 Exemple: ./rename-images-inde.sh images/webp/images-inde 33

echo "🔄 RENOMMAGE DES IMAGES RETRAITE INDE"
echo "======================================"

# Vérifier les arguments
if [ $# -lt 1 ]; then
    echo "❌ Usage: $0 [dossier] [numero-depart]"
    echo "📝 Exemple: $0 images/webp/images-inde 33"
    exit 1
fi

DOSSIER="$1"
COMPTEUR="${2:-33}"  # Numéro de départ par défaut: 33

# Vérifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "❌ Le dossier '$DOSSIER' n'existe pas"
    exit 1
fi

echo ""
echo "🎯 Configuration:"
echo "   Dossier: $DOSSIER"
echo "   Numéro de départ: $COMPTEUR"
echo ""

# Compter les images
NB_IMAGES=$(find "$DOSSIER" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.JPG" -o -name "*.JPEG" -o -name "*.PNG" \) | wc -l)
echo "📊 Images trouvées: $NB_IMAGES"

if [ $NB_IMAGES -eq 0 ]; then
    echo "❌ Aucune image trouvée dans le dossier"
    exit 1
fi

echo ""
echo "🔄 Début du renommage..."
echo "----------------------------------------"

# Traiter chaque image avec gestion des espaces
find "$DOSSIER" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.JPG" -o -name "*.JPEG" -o -name "*.PNG" \) -print0 | while IFS= read -r -d '' image; do
    # Obtenir l'extension
    extension="${image##*.}"
    
    # Créer le nouveau nom avec le format demandé
    nouveau_nom="retraite-inde-melanie-elbaz-sunset-ibiza-inde-retraite-yoga-holistique-mandala-project-India-${COMPTEUR}.${extension}"
    nouveau_chemin="${DOSSIER}/${nouveau_nom}"
    
    echo "🖼️  Renommage: $(basename "$image")"
    echo "   → $nouveau_nom"
    
    # Renommer le fichier
    if mv "$image" "$nouveau_chemin" 2>/dev/null; then
        echo "   ✅ Renommé avec succès"
    else
        echo "   ❌ Erreur lors du renommage"
    fi
    
    # Incrémenter le compteur
    ((COMPTEUR++))
    echo ""
done

echo "🎉 Renommage terminé !"
echo "📁 Dossier: $DOSSIER"
echo "🚀 Images renommées avec le format: retraite-inde-melanie-elbaz-sunset-ibiza-inde-retraite-yoga-holistique-mandala-project-India-XX" 