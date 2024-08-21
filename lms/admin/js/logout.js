function logout() {
    sessionStorage.clear();
    window.location.href = "login.html";
}

// Check if the element with ID 'logoutLink' exists before adding event listener
var logoutLink = document.getElementById('logoutLink');
if (logoutLink) {
    logoutLink.addEventListener('click', function(event) {
        event.preventDefault(); // Prevent default link behavior
        logout(); 
    });
} else {
    console.error("Element with ID 'logoutLink' not found.");
}
