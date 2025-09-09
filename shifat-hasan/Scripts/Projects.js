// Close mobile menu when window is resized to desktop
window.addEventListener('resize', function() {
    if (window.innerWidth > 768) {
        const mobileNav = document.getElementById('adminMobileNav');
        const toggle = document.querySelector('.admin-mobile-menu-toggle');

        if (mobileNav && toggle) {
            mobileNav.classList.remove('active');
            toggle.classList.remove('active');
        }
    }
});

// Handle image loading errors
function handleImageError(img) {
    img.parentElement.innerHTML = '<div class="no-image">📷 No Image</div>';
}