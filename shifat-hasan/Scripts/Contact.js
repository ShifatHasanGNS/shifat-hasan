// Contact.js
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

// Add this function to handle form validation
function validateForm() {
    // Get the actual client IDs of the controls
    var name = document.getElementById('<%= txtName.ClientID %>');
    var email = document.getElementById('<%= txtEmail.ClientID %>');
    var subject = document.getElementById('<%= txtSubject.ClientID %>');
    var message = document.getElementById('<%= txtMessage.ClientID %>');

    if (!name || !email || !subject || !message) {
        console.error("Form elements not found");
        return false;
    }

    var nameValue = name.value.trim();
    var emailValue = email.value.trim();
    var subjectValue = subject.value.trim();
    var messageValue = message.value.trim();

    // Clear previous error styles
    resetFormStyles();

    var hasError = false;

    if (!nameValue) {
        showFieldError(name.id, 'Name is required');
        hasError = true;
    }

    if (!emailValue) {
        showFieldError(email.id, 'Email is required');
        hasError = true;
    } else {
        // Basic email validation
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(emailValue)) {
            showFieldError(email.id, 'Please enter a valid email address');
            hasError = true;
        }
    }

    if (!subjectValue) {
        showFieldError(subject.id, 'Subject is required');
        hasError = true;
    }

    if (!messageValue) {
        showFieldError(message.id, 'Message is required');
        hasError = true;
    }

    if (hasError) {
        return false;
    }

    // Show loading state
    var submitButton = document.getElementById('<%= btnSubmit.ClientID %>');
    if (submitButton) {
        setLoadingState(submitButton, true);
    }

    return true;
}