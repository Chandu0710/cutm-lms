<?php
header('Content-Type: application/json');

// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the request method is GET
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    // Fetch student registration number
    $UserID = $_GET['UserID']; // Match parameter name

    // SQL query to fetch assignment details
    $sql = "SELECT 
    assignment_id,
    CourseID,
    title,
    description,
    due_date,
    max_grade,
    file_location,
    created_at,
    updated_at
FROM 
    assignments
WHERE 
    faculty_id = '$UserID'";


    $result = $conn->query($sql);
    $assignments = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $assignments[] = $row;
        }
    }

    echo json_encode($assignments);
}

$conn->close();
?>
