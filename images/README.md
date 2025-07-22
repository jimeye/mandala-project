# Organisation des Images - Mandala Project

## 📁 Structure des dossiers

```
images/
├── about/           # Images de la page "À propos"
│   ├── about-1.jpg
│   └── about-2.jpg
├── cuisine/         # Images de la cuisine
│   ├── cuisine-1.jpg
│   ├── cuisine-2.jpg
│   └── cuisine-3.jpg
├── hero/            # Images d'arrière-plan des sections hero
│   └── hero-bg.jpg
├── retraites/       # Images des pages de retraites
│   ├── retraite-1.jpg
│   ├── retraite-2.jpg
│   └── retraite-3.jpg
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
```

## 🎯 Utilisation

### **Images JPG/PNG** (dossiers principaux)
- Utilisées pour les images de haute qualité
- Formats : JPG, PNG, AVIF

### **Images WebP** (dossier webp/)
- Versions optimisées pour le web
- Chargement plus rapide
- Utilisées en priorité dans le HTML

## 📝 Conventions de nommage

- **about-*** : Images de la page "À propos"
- **cuisine-*** : Images de la cuisine
- **hero-*** : Images d'arrière-plan des sections hero
- **retraite-*** : Images des pages de retraites
- **villa-*** : Images de la villa
- **sunset-*** : Images de coucher de soleil (hero principal)

## 🔄 Mise à jour

Pour ajouter de nouvelles images :
1. Placer l'image dans le dossier approprié
2. Créer une version WebP optimisée dans `webp/[dossier]`
3. Mettre à jour les références dans le HTML si nécessaire

## 🤖 Scripts d'automatisation

### **optimize-images.sh** - Organisation et optimisation
```bash
./optimize-images.sh organize  # Organiser les images
./optimize-images.sh optimize  # Créer des WebP
./optimize-images.sh stats     # Voir les statistiques
./optimize-images.sh all       # Tout faire
```

### **rename-images.sh** - Renommage avec numérotation
```bash
./rename-images.sh rename  # Renommer les images
./rename-images.sh html    # Mettre à jour les références HTML
./rename-images.sh stats   # Voir les statistiques
./rename-images.sh report  # Créer un rapport
./rename-images.sh all     # Tout faire
```

## 📊 Formats supportés

- **JPG** : Photos et images complexes
- **PNG** : Images avec transparence
- **WebP** : Versions optimisées
- **AVIF** : Format moderne ultra-optimisé
- **SVG** : Icônes et graphiques vectoriels 