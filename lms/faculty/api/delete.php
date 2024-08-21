<?php
session_start(); // Start session if not already started

// Assuming you have already established a database connection
// You might need to replace these placeholders with your actual database connection details
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Perform deletion operation
    if (isset($_SESSION['UserID'])) {
        $userId = $_SESSION['UserID']; // Assuming you're using session for authentication
        
        // Prepare and bind SQL statement
        $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
        $stmt->bind_param("i", $userId);
        
        // Execute statement
        if ($stmt->execute()) {
            // Deletion successful
            echo 'success';
        } else {
            // Deletion failed
            echo 'error';
        }
    } else {
        // User not authenticated
        echo 'not authenticated';
    }
} else {
    // Invalid request method
    echo 'invalid request';
}

// Close connection
$conn->close();
?>
