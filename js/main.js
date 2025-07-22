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
            e.preventDefault();
            dropdown.classList.toggle('active');
        }
        // Sur desktop, laisser la navigation normale
    });
});

// Modification du texte des sliders sur mobile
function adjustSliderText() {
    const heroSubtitles = document.querySelectorAll('.hero__subtitle');
    const isMobile = window.innerWidth <= 768;
    
    heroSubtitles.forEach(subtitle => {
        if (isMobile) {
            // Sur mobile : ajoute un saut de ligne après "rééquilibrer"
            subtitle.innerHTML = subtitle.innerHTML.replace(
                'rééquilibrer corps et esprit',
                'rééquilibrer<br>corps et esprit'
            );
        } else {
            // Sur desktop : remet le texte original
            subtitle.innerHTML = subtitle.innerHTML.replace(
                'rééquilibrer<br>corps et esprit',
                'rééquilibrer corps et esprit'
            );
        }
    });
}

// Applique les modifications au chargement et au redimensionnement
window.addEventListener('load', adjustSliderText);
window.addEventListener('resize', adjustSliderText);

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