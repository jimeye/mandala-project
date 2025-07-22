#!/bin/bash

# Créer le dossier images s'il n'existe pas
mkdir -p images

# Télécharger les images depuis le site
curl -o images/hero-bg.jpg "https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=1920"
curl -o images/about-1.jpg "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=800"
curl -o images/about-2.jpg "https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=800"
curl -o images/retraite-1.jpg "https://images.unsplash.com/photo-1545205597-3d9d02c29597?q=80&w=800"
curl -o images/retraite-2.jpg "https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=800"
curl -o images/retraite-3.jpg "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=800"
curl -o images/villa-1.jpg "https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800"
curl -o images/villa-2.jpg "https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800"
curl -o images/villa-3.jpg "https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800"
curl -o images/villa-4.jpg "https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800"

# Télécharger les images pour la section cuisine
curl -o images/cuisine-1.jpg "https://images.unsplash.com/photo-1547592180-85f173990554?w=1200&h=800&fit=crop"
curl -o images/cuisine-2.jpg "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=1200&h=800&fit=crop"
curl -o images/cuisine-3.jpg "https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=1200&h=800&fit=crop"

# Rendre le script exécutable
chmod +x download-images.sh 