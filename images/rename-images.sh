#!/bin/bash

# Script de renommage des images avec numérotation séquentielle
# Mandala Project

echo "🔄 Script de renommage des images - Mandala Project"
echo "=================================================="

# Fonction pour renommer les images dans un dossier
rename_images_in_folder() {
    local folder="$1"
    local prefix="$2"
    local counter=1
    
    if [ ! -d "$folder" ]; then
        echo "⚠️  Dossier $folder n'existe pas"
        return
    fi
    
    echo "📁 Renommage des images dans $folder..."
    
    # Trouver toutes les images dans le dossier
    find "$folder" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.avif" \) | sort | while read -r file; do
        # Obtenir l'extension du fichier
        extension="${file##*.}"
        filename=$(basename "$file")
        
        # Nouveau nom avec numéro séquentiel
        new_name="${prefix}-${counter}.${extension}"
        new_path="$folder/$new_name"
        
        # Éviter de renommer si le nom est déjà correct
        if [ "$filename" != "$new_name" ]; then
            echo "  🔄 $filename → $new_name"
            mv "$file" "$new_path"
        else
            echo "  ✅ $filename (déjà correct)"
        fi
        
        ((counter++))
    done
    
    echo "✅ Renommage terminé pour $folder"
}

# Fonction pour renommer les images WebP
rename_webp_images() {
    echo "🔄 Renommage des images WebP..."
    
    for folder in about cuisine hero retraites villa; do
        if [ -d "webp/$folder" ]; then
            rename_images_in_folder "webp/$folder" "$folder"
        fi
    done
}

# Fonction pour afficher les statistiques avant/après
show_rename_stats() {
    echo "📊 Statistiques de renommage:"
    echo "============================"
    
    for folder in about cuisine hero retraites villa; do
        if [ -d "$folder" ]; then
            count=$(find "$folder" -maxdepth 1 -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.avif" | wc -l)
            echo "📁 $folder: $count images"
            
            # Afficher les noms actuels
            find "$folder" -maxdepth 1 -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.avif" | sort | while read -r file; do
                echo "    📄 $(basename "$file")"
            done
        fi
    done
}

# Fonction pour mettre à jour les références dans les fichiers HTML
update_html_references() {
    echo "🔗 Mise à jour des références HTML..."
    
    # Aller au répertoire parent pour accéder aux fichiers HTML
    cd ..
    
    # Mettre à jour les références pour chaque dossier
    for folder in about cuisine hero retraites villa; do
        if [ -d "images/$folder" ]; then
            counter=1
            find "images/$folder" -maxdepth 1 -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.avif" | sort | while read -r file; do
                extension="${file##*.}"
                old_name=$(basename "$file")
                new_name="${folder}-${counter}.${extension}"
                
                if [ "$old_name" != "$new_name" ]; then
                    echo "  🔄 Mise à jour: $old_name → $new_name"
                    
                    # Mettre à jour dans tous les fichiers HTML
                    find . -name "*.html" -exec sed -i '' "s|images/$folder/$old_name|images/$folder/$new_name|g" {} \;
                fi
                
                ((counter++))
            done
        fi
    done
    
    echo "✅ Références HTML mises à jour"
}

# Fonction pour créer un rapport de renommage
create_rename_report() {
    local report_file="rename-report-$(date +%Y%m%d-%H%M%S).txt"
    
    echo "📝 Création du rapport de renommage: $report_file"
    
    {
        echo "Rapport de renommage - $(date)"
        echo "================================="
        echo ""
        
        for folder in about cuisine hero retraites villa; do
            if [ -d "$folder" ]; then
                echo "📁 Dossier: $folder"
                echo "-------------------"
                
                counter=1
                find "$folder" -maxdepth 1 -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.avif" | sort | while read -r file; do
                    extension="${file##*.}"
                    old_name=$(basename "$file")
                    new_name="${folder}-${counter}.${extension}"
                    
                    echo "  $counter. $old_name → $new_name"
                    
                    ((counter++))
                done
                echo ""
            fi
        done
    } > "$report_file"
    
    echo "✅ Rapport créé: $report_file"
}

# Menu principal
main() {
    case "${1:-}" in
        "rename")
            echo "🔄 Renommage des images..."
            rename_images_in_folder "about" "about"
            rename_images_in_folder "cuisine" "cuisine"
            rename_images_in_folder "hero" "hero"
            rename_images_in_folder "retraites" "retraites"
            rename_images_in_folder "villa" "villa"
            rename_webp_images
            ;;
        "html")
            update_html_references
            ;;
        "stats")
            show_rename_stats
            ;;
        "report")
            create_rename_report
            ;;
        "all")
            echo "🔄 Exécution complète du renommage..."
            rename_images_in_folder "about" "about"
            rename_images_in_folder "cuisine" "cuisine"
            rename_images_in_folder "hero" "hero"
            rename_images_in_folder "retraites" "retraites"
            rename_images_in_folder "villa" "villa"
            rename_webp_images
            update_html_references
            create_rename_report
            show_rename_stats
            ;;
        *)
            echo "Usage: $0 [rename|html|stats|report|all]"
            echo ""
            echo "Options:"
            echo "  rename  - Renommer les images avec numérotation"
            echo "  html    - Mettre à jour les références HTML"
            echo "  stats   - Afficher les statistiques"
            echo "  report  - Créer un rapport de renommage"
            echo "  all     - Exécuter toutes les opérations"
            echo ""
            echo "Convention de nommage:"
            echo "  about-1.jpg, about-2.jpg, etc."
            echo "  cuisine-1.jpg, cuisine-2.jpg, etc."
            echo "  hero-1.jpg, hero-2.jpg, etc."
            echo "  retraite-1.jpg, retraite-2.jpg, etc."
            echo "  villa-1.jpg, villa-2.jpg, etc."
            echo ""
            echo "Exemples:"
            echo "  $0 rename    # Renommer les images"
            echo "  $0 html      # Mettre à jour HTML"
            echo "  $0 all       # Tout faire"
            ;;
    esac
}

# Exécuter le script
main "$@" 