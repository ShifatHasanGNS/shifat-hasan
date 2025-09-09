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
document.addEventListener('click', function (event) {
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
window.addEventListener('resize', function () {
    if (window.innerWidth > 768) {
        const mobileNav = document.getElementById('adminMobileNav');
        const toggle = document.querySelector('.admin-mobile-menu-toggle');

        if (mobileNav && toggle) {
            mobileNav.classList.remove('active');
            toggle.classList.remove('active');
        }
    }
});

function toggleFeedback(headerElement) {
    const card = headerElement.closest('.feedback-card');
    const isExpanded = card.classList.contains('expanded');

    // Close all other expanded cards
    document.querySelectorAll('.feedback-card.expanded').forEach(function (expandedCard) {
        if (expandedCard !== card) {
            expandedCard.classList.remove('expanded');
        }
    });

    // Toggle current card
    if (isExpanded) {
        card.classList.remove('expanded');
    } else {
        card.classList.add('expanded');
    }
}

// Add loading state for buttons
document.addEventListener('DOMContentLoaded', function () {
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(button => {
        button.addEventListener('click', function (e) {
            if (this.type === 'submit') {
                this.style.opacity = '0.7';
                this.style.pointerEvents = 'none';
                const originalText = this.textContent;
                this.textContent = 'Processing...';

                setTimeout(() => {
                    this.textContent = originalText;
                    this.style.opacity = '1';
                    this.style.pointerEvents = 'auto';
                }, 3000);
            }
        });
    });
});