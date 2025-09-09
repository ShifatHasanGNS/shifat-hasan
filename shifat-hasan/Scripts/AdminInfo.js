function toggleAdminMobileMenu(event) {
    event.preventDefault();
    event.stopPropagation();

    const mobileNav = document.getElementById('adminMobileNav');
    const toggle = document.querySelector('.admin-mobile-menu-toggle');

    if (!mobileNav || !toggle) {
        console.error('Mobile navigation elements not found');
        return;
    }

    if (mobileNav.classList.contains('active')) {
        mobileNav.classList.remove('active');
        toggle.classList.remove('active');
    } else {
        mobileNav.classList.add('active');
        toggle.classList.add('active');
    }
}

// Close mobile menu when clicking outside
document.addEventListener('click', function(event) {
    const mobileNav = document.getElementById('adminMobileNav');
    const toggle = document.querySelector('.admin-mobile-menu-toggle');

    if (mobileNav && mobileNav.classList.contains('active') &&
        !mobileNav.contains(event.target) &&
        !toggle.contains(event.target)) {
        mobileNav.classList.remove('active');
        toggle.classList.remove('active');
    }
});

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

function confirmSignOut() {
    return confirm('Are you sure you want to sign out? This will end your current session.');
}

function showMessage(message, isSuccess) {
    let container = document.getElementById('messageContainer');
    let messageElement = container.querySelector('span') || container;

    messageElement.textContent = message;
    container.className = 'message-container ' + (isSuccess ? 'success' : 'error');
    container.style.display = 'block';

    // Auto-hide success messages
    if (isSuccess) {
        setTimeout(function() {
            hideMessage();
        }, 3000);
    }
}

function hideMessage() {
    let container = document.getElementById('messageContainer');
    container.style.display = 'none';
}