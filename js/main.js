// Navigation mobile
const navToggle = document.querySelector('.nav__toggle');
const navMenu = document.querySelector('.nav__menu');

navToggle.addEventListener('click', () => {
    navToggle.classList.toggle('active');
    navMenu.classList.toggle('active');
});

// Fermer le menu quand on clique sur un lien
document.querySelectorAll('.nav__link, .nav__submenu-link').forEach(link => {
    link.addEventListener('click', () => {
        navToggle.classList.remove('active');
        navMenu.classList.remove('active');
    });
});

// Gestion des sous-menus au clic - CORRIGÉ pour permettre la navigation
document.querySelectorAll('.nav__dropdown').forEach(dropdown => {
    const dropdownLink = dropdown.querySelector('.nav__link');
    const submenu = dropdown.querySelector('.nav__submenu');
    
    // Gestion du hover pour desktop
    dropdown.addEventListener('mouseenter', () => {
        if (window.innerWidth > 768) {
            submenu.style.opacity = '1';
            submenu.style.visibility = 'visible';
            submenu.style.transform = 'translateY(0)';
        }
    });
    
    dropdown.addEventListener('mouseleave', () => {
        if (window.innerWidth > 768) {
            submenu.style.opacity = '0';
            submenu.style.visibility = 'hidden';
            submenu.style.transform = 'translateY(-10px)';
        }
    });
    
    // Gestion du clic pour mobile
    dropdownLink.addEventListener('click', (e) => {
        if (window.innerWidth <= 768) {
            // Permettre la navigation vers la page principale
            // Le sous-menu s'ouvrira au clic sur mobile
            const dropdownLi = dropdown.closest('li');
            dropdownLi.classList.toggle('active');
        }
        // Sur desktop, laisser la navigation normale
    });
});

// Test simple pour vérifier que le JavaScript fonctionne
console.log('JavaScript chargé !');

// Modification du texte des sliders sur mobile - DÉSACTIVÉ pour permettre la personnalisation
/*
function adjustSliderText() {
    const heroSubtitles = document.querySelectorAll('.hero__subtitle');
    const isMobile = window.innerWidth <= 768;
    
    console.log('adjustSliderText appelé, isMobile:', isMobile, 'heroSubtitles:', heroSubtitles.length);
    
    heroSubtitles.forEach(subtitle => {
        console.log('Texte original:', subtitle.innerHTML);
        
        if (isMobile) {
            // Sur mobile : format sur 3 lignes
            subtitle.innerHTML = 'Une retraite holistique à Ibiza<br>en Inde,<br>une parenthèse précieuse<br>pour rééquilibrer corps et esprit';
        } else {
            // Sur desktop : remet le texte original
            subtitle.innerHTML = 'Une retraite holistique à Ibiza et en Inde, une parenthèse précieuse pour rééquilibrer corps et esprit';
        }
        
        console.log('Texte modifié:', subtitle.innerHTML);
    });
}

// Applique les modifications au chargement et au redimensionnement
window.addEventListener('load', adjustSliderText);
window.addEventListener('resize', adjustSliderText);

// Appel immédiat si le DOM est déjà prêt
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', adjustSliderText);
} else {
    adjustSliderText();
}

// Force l'exécution après un délai pour s'assurer que tout est chargé
setTimeout(adjustSliderText, 100);
setTimeout(adjustSliderText, 500);
setTimeout(adjustSliderText, 1000);
*/

// Header qui disparaît au scroll et logo qui disparaît au scroll
let lastScrollTop = 0;
const header = document.querySelector('.header');
const navLogo = document.querySelector('.nav__logo');

window.addEventListener('scroll', () => {
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
    
    // Masquer le logo au scroll
    if (scrollTop > 50) {
        navLogo.classList.add('hidden');
    } else {
        navLogo.classList.remove('hidden');
    }
    
    if (scrollTop > lastScrollTop && scrollTop > 100) {
        // Scroll vers le bas - cacher le header
        header.style.transform = 'translateY(-100%)';
    } else {
        // Scroll vers le haut - montrer le header
        header.style.transform = 'translateY(0)';
    }
    
    lastScrollTop = scrollTop;
});

// Animation au scroll
document.addEventListener('DOMContentLoaded', () => {
    const sections = document.querySelectorAll('section');
    
    const observerOptions = {
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, observerOptions);

    sections.forEach(section => {
        observer.observe(section);
    });

    // Gestion du formulaire de contact
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Récupération des données du formulaire
            const formData = new FormData(this);
            const name = formData.get('name');
            const email = formData.get('email');
            const message = formData.get('message');
            
            // Validation basique
            if (!name || !email || !message) {
                alert('Veuillez remplir tous les champs.');
                return;
            }
            
            // Simulation d'envoi (remplacer par votre logique d'envoi)
            alert('Merci pour votre message ! Nous vous répondrons bientôt.');
            this.reset();
        });
    }
});

// Scroll to top button
const scrollTopBtn = document.getElementById('scrollTopBtn');

window.addEventListener('scroll', () => {
    if (window.pageYOffset > 300) {
        scrollTopBtn.style.display = 'block';
    } else {
        scrollTopBtn.style.display = 'none';
    }
});

scrollTopBtn.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}); 

// Mélange aléatoire des images dans tous les carrousels
function shuffleCarousels() {
  document.querySelectorAll('[class*="carousel"]').forEach(function(carousel) {
    let lines = Array.from(carousel.children);
    lines.forEach(function(line) {
      let photos = Array.from(line.children);
      for (let i = photos.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [photos[i], photos[j]] = [photos[j], photos[i]];
      }
      photos.forEach(function(photo) {
        line.appendChild(photo);
      });
    });
  });
}

// Lightbox universelle pour toutes les images de carrousel, sauf sliders
function setupLightbox() {
  // Crée l'overlay si pas déjà présent
  let overlay = document.getElementById('lightbox-overlay');
  if (!overlay) {
    overlay = document.createElement('div');
    overlay.id = 'lightbox-overlay';
    overlay.style.display = 'none';
    
    // Taille différente selon l'appareil
    const isMobile = window.innerWidth <= 768;
    const containerWidth = isMobile ? '50vw' : '40vw';
    const containerHeight = isMobile ? '50vh' : '40vh';
    
    overlay.innerHTML = '<div id="lightbox-container" style="position:relative;width:' + containerWidth + ';height:' + containerHeight + ';display:flex;justify-content:center;align-items:center;"><span style="display:inline-block;position:relative;"><img id="lightbox-img" style="max-width:100%;max-height:100%;object-fit:contain;border-radius:48px;box-shadow:none;border:6px solid rgba(0,0,0,0.7);background:none;padding:0;margin:0;transition:box-shadow 0.3s, border-radius 0.3s, border-color 0.3s;display:block;"><button id="lightbox-close" aria-label="Fermer" style="position:absolute;bottom:16px;right:16px;background:none;border:none;cursor:pointer;padding:0;z-index:2;"><svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg"><line x1="10" y1="10" x2="26" y2="26" stroke="#E8B4B8" stroke-width="3" stroke-linecap="round"/><line x1="26" y1="10" x2="10" y2="26" stroke="#E8B4B8" stroke-width="3" stroke-linecap="round"/></svg></button></span></div>';
    overlay.style.position = 'fixed';
    overlay.style.top = 0;
    overlay.style.left = 0;
    overlay.style.width = '100vw';
    overlay.style.height = '100vh';
    overlay.style.background = 'transparent';
    overlay.style.justifyContent = 'center';
    overlay.style.alignItems = 'center';
    overlay.style.zIndex = 10000;
    overlay.style.flexDirection = 'column';
    overlay.style.textAlign = 'center';
    overlay.style.padding = '0';
    overlay.style.margin = '0';
    document.body.appendChild(overlay);
    overlay.addEventListener('click', function(e) {
      if (e.target === overlay) {
        overlay.style.display = 'none';
      }
    });
  } else {
    overlay.style.display = 'none';
  }
  
  // Ajoute l'événement UNIQUEMENT sur les images enfants d'un carrousel, mais PAS dans un slider principal
  document.querySelectorAll('[class*="carousel"]').forEach(function(carousel) {
    carousel.querySelectorAll('img').forEach(function(img) {
      let parent = img.closest('.hero, .hero__slider, .slider, section.hero');
      if (!parent) {
        img.addEventListener('click', function(e) {
          e.stopPropagation();
          const overlay = document.getElementById('lightbox-overlay');
          const lightboxImg = document.getElementById('lightbox-img');
          lightboxImg.src = img.src;
          
          // Détermine le curseur selon le type de carrousel
          let cursorUrl = '';
          if (img.style.cursor && img.style.cursor.includes('url')) {
            // Si l'image a déjà un curseur défini, on le copie
            cursorUrl = img.style.cursor;
          } else {
            // Sinon on détermine le curseur selon le type de carrousel
            if (carousel.classList.contains('retraite-old-carousel')) {
              if (img.src.includes('retraites-inde')) {
                cursorUrl = 'url(../images/icons/om-cursor-rose.png), pointer';
              } else if (img.src.includes('retraites-ibiza')) {
                cursorUrl = 'url(../images/icons/ibiza-cursor-rose.png), pointer';
              }
            } else if (carousel.classList.contains('cuisine-carousel')) {
              cursorUrl = 'url(../images/icons/cuisine-cursor-rose.png), pointer';
            }
          }
          
          if (cursorUrl) {
            lightboxImg.style.cursor = cursorUrl;
          }
          
          overlay.style.display = 'flex';
        });
      }
    });
  });
  
  // Ajoute l'événement de fermeture sur l'image du lightbox
  const lightboxImg = document.getElementById('lightbox-img');
  if (lightboxImg) {
    lightboxImg.addEventListener('click', function() {
      overlay.style.display = 'none';
    });
  }
  // Ajoute l'événement de fermeture sur la croix
  const closeBtn = document.getElementById('lightbox-close');
  if (closeBtn) {
    closeBtn.addEventListener('click', function(e) {
      e.stopPropagation();
      overlay.style.display = 'none';
    });
  }
}

document.addEventListener('DOMContentLoaded', function() {
  shuffleCarousels();
  setupLightbox();
}); 

// Défilement automatique horizontal infini pour tous les carrousels/sliders horizontaux
(function() {
  const carousels = document.querySelectorAll('.retraite-old-carousel, .cuisine-carousel, .carousel, .slider, .about-carousel, .gallery-carousel, .photo-carousel, .villa-carousel, .retreat-carousel, .team-carousel, .hero__slider');
  carousels.forEach(carousel => {
    let scrollAmount = 0;
    let isPaused = false;
    const speed = 0.4; // pixels par frame (lent)
    // Dupliquer le contenu pour effet infini
    const inner = carousel.firstElementChild;
    if (inner) {
      const clone = inner.cloneNode(true);
      carousel.appendChild(clone);
    }
    function autoScroll() {
      if (!isPaused) {
        scrollAmount += speed;
        if (scrollAmount >= inner.scrollWidth) {
          scrollAmount = 0;
        }
        carousel.scrollLeft = scrollAmount;
      }
      requestAnimationFrame(autoScroll);
    }
    carousel.addEventListener('mouseenter', function() { isPaused = true; });
    carousel.addEventListener('mouseleave', function() { isPaused = false; });
    autoScroll();
  });
})(); 