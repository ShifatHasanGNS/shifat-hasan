// Updated typewriter texts based on About.md suggestions
var texts = [
    "CSE Student at KUET",
    "Software Developer",
    "Tech Enthusiast",
    "Digital Creator",
    "Problem Solver",
    "Innovation Builder"
];
var textIndex = 0;
var charIndex = 0;
var isDeleting = false;
var typeSpeed = 100;

function typeWriter() {
    var currentText = texts[textIndex];
    var typewriterElement = document.getElementById('typewriter-text');

    if (!typewriterElement) {
        return; // Element not found, exit function
    }

    if (isDeleting) {
        typewriterElement.textContent = currentText.substring(0, charIndex - 1);
        charIndex--;
        typeSpeed = 70;
    } else {
        typewriterElement.textContent = currentText.substring(0, charIndex + 1);
        charIndex++;
        typeSpeed = 70;
    }

    if (!isDeleting && charIndex === currentText.length) {
        typeSpeed = 3000; // Pause at end
        isDeleting = true;
    } else if (isDeleting && charIndex === 0) {
        isDeleting = false;
        textIndex = (textIndex + 1) % texts.length;
    }

    setTimeout(typeWriter, typeSpeed);
}

// Initialize page functionality
function initializePage() {
    // Start typewriter effect
    setTimeout(typeWriter, 1000);

    // Setup smooth scrolling for CTA button
    var ctaButton = document.querySelector('.cta-button');
    if (ctaButton) {
        ctaButton.addEventListener('click', function(e) {
            e.preventDefault();
            var aboutSection = document.getElementById('about-section');
            if (aboutSection) {
                aboutSection.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    }
}

// Cross-browser DOM ready function
function domReady(fn) {
    if (document.readyState === 'complete' || document.readyState === 'interactive') {
        setTimeout(fn, 1);
    } else {
        document.addEventListener('DOMContentLoaded', fn);
    }
}

// Initialize when DOM is ready
domReady(initializePage);

// Fallback initialization for older browsers
if (window.addEventListener) {
    window.addEventListener('load', initializePage, false);
} else if (window.attachEvent) {
    window.attachEvent('onload', initializePage);
}

// Close modal with Escape key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeProjectModal();
    }
});

// Handle image loading errors
function handleImageError(img) {
    img.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjBmMGYwIi8+CiAgPHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPk5vIEltYWdlPC90ZXh0Pgo8L3N2Zz4=';
}

// Add event delegation for project cards
document.addEventListener('click', function(event) {
    const projectCard = event.target.closest('.project-card');
    if (projectCard && projectCard.dataset.projectId) {
        openProjectModal(projectCard.dataset.projectId);
    }
});

// Note: Make sure closeProjectModal and openProjectModal functions are defined
// either in this file or in the inline script section
function closeProjectModal() {
    // Add your modal closing logic here
    console.log('Closing project modal');
}

function openProjectModal(projectId) {
    // Add your modal opening logic here
    console.log('Opening project modal for ID:', projectId);
    // You can access the global projectsData array here since it's set by the inline script
}
