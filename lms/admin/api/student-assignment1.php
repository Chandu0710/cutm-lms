<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$database = "cutmlms"; // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch data from student_assignments table
$query = "SELECT * FROM student_assignments";
$result = $conn->query($query);

// Check if query executed successfully
if ($result) {
    $data = array();
    // Fetch rows
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    // Return JSON encoded data
    echo json_encode($data);
} else {
    echo "Error: " . $conn->error;
}

// Close connection
$conn->close();
?>
