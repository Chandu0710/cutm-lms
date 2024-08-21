document.addEventListener('DOMContentLoaded', function () {
    // Retrieve userData from sessionStorage
    const userDataString = sessionStorage.getItem('userData');

    if (!userDataString) {
        console.error("User data not found in session storage.");
        return;
    }

    // Parse the userData JSON string
    const userData = JSON.parse(userDataString);

    // Retrieve the username from userData
    const username = userData.username;

    // Display the username
    const usernameElements = document.querySelectorAll('.username');
    usernameElements.forEach(element => {
        element.textContent = username;
    });
});