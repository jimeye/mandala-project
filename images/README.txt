ORGANISATION DES IMAGES - MANDALA PROJECT
==========================================

STRUCTURE DES DOSSIERS
----------------------

images/
├── about/           # Images de la page "À propos"
│   ├── about-1.jpg
│   └── about-2.jpg
├── cuisine/         # Images de la cuisine
│   ├── cuisine-1.jpg
│   ├── cuisine-2.jpg
│   └── cuisine-3.jpg
├── hero/            # Images d'arrière-plan des sections hero
│   └── hero-1.jpg
├── retraites/       # Images des pages de retraites
│   ├── retraites-1.jpg
│   ├── retraites-2.jpg
│   └── retraites-3.jpg
├── villa/           # Images de la villa
│   ├── villa-1.jpg
│   ├── villa-2.jpg
│   ├── villa-3.jpg
│   └── villa-4.jpg
├── webp/            # Versions WebP optimisées
│   ├── about/
│   ├── cuisine/
│   ├── hero/
│   ├── retraites/
│   └── villa/
├── icons.svg        # Icônes SVG
└── sunset-ibiza-inde-retraite-yoga-holistique.jpg  # Image hero principale

UTILISATION
-----------

Images JPG/PNG (dossiers principaux)
- Utilisées pour les images de haute qualité
- Formats : JPG, PNG, AVIF

Images WebP (dossier webp/)
- Versions optimisées pour le web
- Chargement plus rapide
- Utilisées en priorité dans le HTML

CONVENTIONS DE NOMMAGE
----------------------

- about-* : Images de la page "À propos"
- cuisine-* : Images de la cuisine
- hero-* : Images d'arrière-plan des sections hero
- retraite-* : Images des pages de retraites
- villa-* : Images de la villa
- sunset-* : Images de coucher de soleil (hero principal)

MISE À JOUR
-----------

Pour ajouter de nouvelles images :
1. Placer l'image dans le dossier approprié
2. Créer une version WebP optimisée dans webp/[dossier]
3. Mettre à jour les références dans le HTML si nécessaire

SCRIPTS D'AUTOMATISATION
-------------------------

optimize-images.sh - Organisation et optimisation
./optimize-images.sh organize  # Organiser les images
./optimize-images.sh optimize  # Créer des WebP
./optimize-images.sh stats     # Voir les statistiques
./optimize-images.sh all       # Tout faire

rename-images.sh - Renommage avec numérotation
./rename-images.sh rename  # Renommer les images
./rename-images.sh html    # Mettre à jour les références HTML
./rename-images.sh stats   # Voir les statistiques
./rename-images.sh report  # Créer un rapport
./rename-images.sh all     # Tout faire

FORMATS SUPPORTÉS
-----------------

- JPG : Photos et images complexes
- PNG : Images avec transparence
- WebP : Versions optimisées
- AVIF : Format moderne ultra-optimisé
- SVG : Icônes et graphiques vectoriels

EXEMPLES D'UTILISATION
----------------------

1. Ajouter une nouvelle image de cuisine :
   - Placer l'image dans cuisine/
   - Exécuter : ./optimize-images.sh optimize
   - Exécuter : ./rename-images.sh rename

2. Organiser des images mal placées :
   - Exécuter : ./optimize-images.sh organize

3. Voir l'état actuel :
   - Exécuter : ./optimize-images.sh stats
   - Exécuter : ./rename-images.sh stats

4. Créer un rapport complet :
   - Exécuter : ./rename-images.sh report

NOTES IMPORTANTES
-----------------

- Les scripts mettent automatiquement à jour les références HTML
- Les images sont renommées avec une numérotation séquentielle
- Les versions WebP sont créées automatiquement si cwebp est installé
- Tous les changements sont documentés dans des rapports

CONTACT
-------

Pour toute question sur l'organisation des images :
- Vérifier d'abord ce fichier README
- Consulter les rapports générés par les scripts
- Tester les scripts avec l'option "stats" avant modification 