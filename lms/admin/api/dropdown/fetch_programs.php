<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$database = "cutmlms";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch programs from database
$sql = "SELECT ProgramCode, ProgramName FROM programs";
$result = $conn->query($sql);

$programs = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $programs[] = $row;
    }
}

// Return programs as JSON
header('Content-Type: application/json');
echo json_encode($programs);

$conn->close();
?>
