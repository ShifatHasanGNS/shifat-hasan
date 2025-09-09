function showFieldError(fieldId, message) {
    var field = document.getElementById(fieldId);
    if (field) {
        field.style.borderColor = 'var(--accent-error) !important';
        field.style.boxShadow = '0 0 0 3px rgba(239, 68, 68, 0.1) !important';

        // Show error message
        var errorDiv = document.createElement('div');
        errorDiv.className = 'field-error';
        errorDiv.textContent = message;
        errorDiv.style.color = 'var(--accent-error)';
        errorDiv.style.fontSize = '0.875rem';
        errorDiv.style.marginTop = '0.5rem';

        // Remove existing error message
        var existingError = field.parentNode.querySelector('.field-error');
        if (existingError) {
            existingError.remove();
        }

        field.parentNode.appendChild(errorDiv);
    }
}

// Additional utility functions for contact form
function resetFormStyles() {
    var errorMessages = document.querySelectorAll('.field-error');
    errorMessages.forEach(function(error) {
        error.remove();
    });
}

function setLoadingState(button, isLoading) {
    if (button) {
        if (isLoading) {
            button.classList.add('loading');
            button.disabled = true;
            button.innerHTML = 'Sending...';
        } else {
            button.classList.remove('loading');
            button.disabled = false;
            button.innerHTML = 'Send Message';
        }
    }
}