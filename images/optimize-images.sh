#!/bin/bash

# Script d'optimisation et d'organisation des images
# Mandala Project

echo "🖼️  Script d'optimisation des images - Mandala Project"
echo "=================================================="

# Fonction pour créer les dossiers s'ils n'existent pas
create_directories() {
    echo "📁 Création des dossiers..."
    mkdir -p about cuisine hero retraites villa
    mkdir -p webp/about webp/cuisine webp/hero webp/retraites webp/villa
    echo "✅ Dossiers créés"
}

# Fonction pour déplacer les images dans les bons dossiers
organize_images() {
    echo "📦 Organisation des images..."
    
    # Déplacer les images dans les dossiers appropriés
    mv about-*.jpg about/ 2>/dev/null || echo "⚠️  Aucune image about à déplacer"
    mv cuisine-*.jpg cuisine/ 2>/dev/null || echo "⚠️  Aucune image cuisine à déplacer"
    mv hero-*.jpg hero/ 2>/dev/null || echo "⚠️  Aucune image hero à déplacer"
    mv retraite-*.jpg retraites/ 2>/dev/null || echo "⚠️  Aucune image retraite à déplacer"
    mv villa-*.jpg villa/ 2>/dev/null || echo "⚠️  Aucune image villa à déplacer"
    
    # Déplacer les WebP
    mv about-*.webp webp/about/ 2>/dev/null || echo "⚠️  Aucune WebP about à déplacer"
    mv cuisine-*.webp webp/cuisine/ 2>/dev/null || echo "⚠️  Aucune WebP cuisine à déplacer"
    mv hero-*.webp webp/hero/ 2>/dev/null || echo "⚠️  Aucune WebP hero à déplacer"
    mv retraite-*.webp webp/retraites/ 2>/dev/null || echo "⚠️  Aucune WebP retraite à déplacer"
    mv villa-*.webp webp/villa/ 2>/dev/null || echo "⚠️  Aucune WebP villa à déplacer"
    
    echo "✅ Images organisées"
}

# Fonction pour créer des versions WebP (si cwebp est installé)
create_webp() {
    if command -v cwebp &> /dev/null; then
        echo "🔄 Création des versions WebP..."
        
        # Créer des WebP pour chaque dossier
        for dir in about cuisine hero retraites villa; do
            if [ -d "$dir" ]; then
                echo "📁 Traitement du dossier $dir..."
                for img in "$dir"/*.jpg; do
                    if [ -f "$img" ]; then
                        filename=$(basename "$img" .jpg)
                        webp_path="webp/$dir/${filename}.webp"
                        echo "  🔄 Conversion: $img → $webp_path"
                        cwebp -q 80 "$img" -o "$webp_path"
                    fi
                done
            fi
        done
        echo "✅ Versions WebP créées"
    else
        echo "⚠️  cwebp non installé. Installez WebP pour créer des versions optimisées."
        echo "   macOS: brew install webp"
        echo "   Ubuntu: sudo apt-get install webp"
    fi
}

# Fonction pour afficher les statistiques
show_stats() {
    echo "📊 Statistiques des images:"
    echo "=========================="
    
    for dir in about cuisine hero retraites villa; do
        if [ -d "$dir" ]; then
            count=$(find "$dir" -name "*.jpg" | wc -l)
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo "📁 $dir: $count images ($size)"
        fi
    done
    
    if [ -d "webp" ]; then
        webp_count=$(find webp -name "*.webp" | wc -l)
        webp_size=$(du -sh webp 2>/dev/null | cut -f1)
        echo "🔄 WebP: $webp_count images ($webp_size)"
    fi
}

# Menu principal
main() {
    case "${1:-}" in
        "organize")
            create_directories
            organize_images
            ;;
        "optimize")
            create_webp
            ;;
        "stats")
            show_stats
            ;;
        "all")
            create_directories
            organize_images
            create_webp
            show_stats
            ;;
        *)
            echo "Usage: $0 [organize|optimize|stats|all]"
            echo ""
            echo "Options:"
            echo "  organize  - Organiser les images dans les dossiers"
            echo "  optimize  - Créer des versions WebP optimisées"
            echo "  stats     - Afficher les statistiques"
            echo "  all       - Exécuter toutes les opérations"
            echo ""
            echo "Exemples:"
            echo "  $0 organize    # Organiser les images"
            echo "  $0 optimize    # Créer des WebP"
            echo "  $0 all         # Tout faire"
            ;;
    esac
}

# Exécuter le script
main "$@" 