// Generic utility functions for login page
function showLoadingState(button) {
    if (button) {
        button.disabled = true;
        button.style.opacity = '0.7';
        const originalText = button.textContent;
        button.textContent = 'Signing In...';

        // Reset after timeout (failsafe)
        setTimeout(() => {
            button.disabled = false;
            button.style.opacity = '1';
            button.textContent = originalText;
        }, 10000);
    }
}

function validateLoginForm(adminId, password) {
    if (!adminId || adminId.trim() === '') {
        alert('Please enter Admin ID');
        return false;
    }

    if (!password || password.trim() === '') {
        alert('Please enter Password');
        return false;
    }

    return true;
}

// Add any other generic login-related functions here