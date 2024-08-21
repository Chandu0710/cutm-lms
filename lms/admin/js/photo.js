// profile.js

function getUserData() {
    const userDataString = sessionStorage.getItem('userData');
    if (!userDataString) {
        // If user data is not found, redirect to the login page
        window.location.href = 'login.html';
    } else {
        // If user data is found, return the parsed user data
        return JSON.parse(userDataString);
    }
}

function displayUserProfile(userData) {
    const ProfilePicture = userData.ProfilePicture;
    
    // Construct the full image URL
    const imageUrl = 'http://localhost/lms/admin/api/uploads/' + ProfilePicture;

    // Set the src attribute of the <img> tag
    const avatarElement = document.getElementById('user-avatar');
    if (avatarElement) {
        avatarElement.src = imageUrl;
    }
}

function updateUsername(name) {
    // Function to update the username in the UI, if needed
    const usernameElement = document.getElementById('username-display');
    if (usernameElement) {
        usernameElement.textContent = name;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const userData = getUserData();
    if (userData) {
        displayUserProfile(userData);
        updateUsername(userData.Name);
    }
});
