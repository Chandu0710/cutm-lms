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

// Fetch domains based on selected program
$programCode = $_GET['programCode'];
$sql = "SELECT DomainID, DomainName FROM domains WHERE ProgramCode = '$programCode'";
$result = $conn->query($sql);

$domains = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $domains[] = $row;
    }
}

// Return domains as JSON
header('Content-Type: application/json');
echo json_encode($domains);

$conn->close();
?>
