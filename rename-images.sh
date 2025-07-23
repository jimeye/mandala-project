#!/bin/bash

# 🔄 Script de renommage d'images avec nom personnalisé et numérotation
# 📝 Usage: ./rename-images.sh "nom-personnalise" [dossier] [numero-depart]
# 🎯 Exemple: ./rename-images.sh "retraite-inde" images/retraites-inde 33

echo "🔄 SCRIPT DE RENOMMAGE D'IMAGES"
echo "================================="

# Vérifier les arguments
if [ $# -lt 1 ]; then
    echo "❌ Usage: $0 \"nom-personnalise\" [dossier] [numero-depart]"
    echo "📝 Exemples:"
    echo "   $0 \"cuisine\" images/cuisine"
    echo "   $0 \"villa\" images/villa"
    echo "   $0 \"retraite-inde\" images/retraites-inde 33"
    exit 1
fi

# Configuration
NOM_PERSONNALISE="$1"
DOSSIER="${2:-images}"  # Dossier par défaut si non spécifié
COMPTEUR="${3:-1}"      # Numéro de départ par défaut si non spécifié

echo ""
echo "🎯 Configuration:"
echo "   Nom personnalisé: $NOM_PERSONNALISE"
echo "   Dossier: $DOSSIER"
echo "   Numéro de départ: $COMPTEUR"
echo ""

# Vérifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "❌ Le dossier '$DOSSIER' n'existe pas"
    exit 1
fi

# Fonction de renommage
rename_images() {
    local folder="$1"
    local count=0
    
    echo "📁 Renommage du dossier: $folder"
    echo "----------------------------------------"
    
    # Trouver toutes les images dans le dossier
    while IFS= read -r -d '' image; do
        if [[ -f "$image" ]]; then
            # Obtenir l'extension du fichier
            extension="${image##*.}"
            
            # Créer le nouveau nom avec le format complet
            if [[ "$NOM_PERSONNALISE" == "retraite-inde" ]]; then
                nouveau_nom="${folder}/retraite-inde-melanie-elbaz-sunset-ibiza-inde-retraite-yoga-holistique-mandala-project-India-${COMPTEUR}.${extension}"
            else
                nouveau_nom="${folder}/${NOM_PERSONNALISE}-${COMPTEUR}.${extension}"
            fi
            
            # Renommer le fichier
            if mv "$image" "$nouveau_nom" 2>/dev/null; then
                echo "✅ $(basename "$image") → $(basename "$nouveau_nom")"
                ((count++))
                ((COMPTEUR++))
            else
                echo "❌ Erreur avec $(basename "$image")"
            fi
        fi
    done < <(find "$folder" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.tiff" \) -print0 | sort -z)
    
    echo "📊 $count images renommées dans $folder"
    return $count
}

# Traitement principal
total_images=0

# Si c'est un dossier spécifique
if [ "$DOSSIER" != "images" ] || [ -d "$DOSSIER" ]; then
    if rename_images "$DOSSIER"; then
        total_images=$?
    fi
else
    # Traiter tous les sous-dossiers d'images
    for subfolder in images/*/; do
        if [ -d "$subfolder" ]; then
            folder_name=$(basename "$subfolder")
            echo ""
            echo "🔄 Traitement du dossier: $folder_name"
            if rename_images "$subfolder"; then
                ((total_images += $?))
            fi
        fi
    done
fi

echo ""
echo "🎉 RENOMMAGE TERMINÉ !"
echo "======================="
echo "📊 Total d'images renommées: $total_images"
echo "🎯 Nom utilisé: $NOM_PERSONNALISE"
echo "📁 Dossier(s) traité(s): $DOSSIER"
echo "🔢 Numéro de départ: ${3:-1}"
echo ""
echo "💡 Les images sont maintenant nommées:"
if [[ "$NOM_PERSONNALISE" == "retraite-inde" ]]; then
    echo "   retraite-inde-melanie-elbaz-sunset-ibiza-inde-retraite-yoga-holistique-mandala-project-India-${3:-1}.extension"
    echo "   retraite-inde-melanie-elbaz-sunset-ibiza-inde-retraite-yoga-holistique-mandala-project-India-$((COMPTEUR-1)).extension"
else
    echo "   ${NOM_PERSONNALISE}-${3:-1}.extension"
    echo "   ${NOM_PERSONNALISE}-$((COMPTEUR-1)).extension"
fi
echo "   etc..." 