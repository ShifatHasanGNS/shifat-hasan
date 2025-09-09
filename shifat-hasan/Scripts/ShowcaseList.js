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

function showTab(tabName) {
    // Hide all tabs
    let tabs = document.querySelectorAll('.tab-content');
    tabs.forEach(function(tab) {
        tab.classList.remove('active');
    });

    // Remove active from all buttons
    let buttons = document.querySelectorAll('.tab-btn');
    buttons.forEach(function(btn) {
        btn.classList.remove('active');
    });

    // Show selected tab
    document.getElementById(tabName + 'Tab').classList.add('active');
    event.target.classList.add('active');

    // Hide message when switching tabs
    hideMessage();
}

function showLoadingOverlay(message) {
    const overlay = document.createElement('div');
    overlay.className = 'loading-overlay';
    overlay.id = 'loadingOverlay';
    overlay.innerHTML = message;
    document.body.appendChild(overlay);
}

function hideLoadingOverlay() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) {
        overlay.remove();
    }
}

function showEditModal() {
    document.getElementById('editFormModal').style.display = 'block';
}

function deleteProjectSafe(button) {
    var projectId = button.getAttribute('data-project-id');
    var projectTitle = button.getAttribute('data-project-title');
    deleteProject(projectId, projectTitle); // This function is defined inline
}

function showMessage(message, isSuccess) {
    let container = document.getElementById('messageContainer');
    container.innerHTML = message;
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
    document.getElementById('messageContainer').style.display = 'none';
}

function updateNoProjectsVisibility() {
    let projectCards = document.querySelectorAll('.project-card');
    let noProjectsMessage = document.getElementById('noProjectsMessage');

    if (projectCards.length === 0) {
        noProjectsMessage.style.display = 'block';
    } else {
        noProjectsMessage.style.display = 'none';
    }
}

// Handle image loading errors
function handleImageError(img) {
    img.parentElement.innerHTML = '<div class="no-image">📷 No Image</div>';
}

// Add event delegation for edit buttons
document.addEventListener('click', function(event) {
    if (event.target.classList.contains('edit-btn') && event.target.dataset.projectId) {
        editProject(event.target.dataset.projectId); // This function is defined inline
    }
});

// Keyboard shortcuts
document.addEventListener('keydown', function(e) {
    // Ctrl+N for new project
    if (e.ctrlKey && e.key === 'n') {
        e.preventDefault();
        showTab('add');
    }
    // Escape to cancel edit
    if (e.key === 'Escape') {
        let editForm = document.getElementById('editForm');
        if (editForm && editForm.style.display !== 'none') {
            cancelEdit(); // Make sure this function exists
        }
    }
});