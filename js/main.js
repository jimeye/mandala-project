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

// Modification du texte des sliders sur mobile
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
    overlay.innerHTML = '<span id="lightbox-close" style="position:absolute;top:30px;right:40px;font-size:3rem;color:white;cursor:pointer;z-index:10001">&times;</span><img id="lightbox-img" style="max-width:98vw;max-height:98vh;box-shadow:0 0 40px #000;border-radius:10px;z-index:10000;display:block;margin:0 auto;padding:0;background:none;">';
    overlay.style.position = 'fixed';
    overlay.style.top = 0;
    overlay.style.left = 0;
    overlay.style.width = '100vw';
    overlay.style.height = '100vh';
    overlay.style.background = 'rgba(0,0,0,0.85)';
    overlay.style.justifyContent = 'center';
    overlay.style.alignItems = 'center';
    overlay.style.zIndex = 10000;
    overlay.style.flexDirection = 'column';
    overlay.style.textAlign = 'center';
    overlay.style.padding = '0';
    overlay.style.margin = '0';
    document.body.appendChild(overlay);
    overlay.addEventListener('click', function(e) {
      if (e.target === overlay || e.target.id === 'lightbox-close') {
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
        img.style.cursor = 'zoom-in';
        img.addEventListener('click', function(e) {
          e.stopPropagation();
          const overlay = document.getElementById('lightbox-overlay');
          const lightboxImg = document.getElementById('lightbox-img');
          lightboxImg.src = img.src;
          overlay.style.display = 'flex';
        });
      }
    });
  });
}

document.addEventListener('DOMContentLoaded', function() {
  shuffleCarousels();
  setupLightbox();
}); 