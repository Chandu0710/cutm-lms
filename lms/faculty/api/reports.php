<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";

// Establish connection to the database
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch the UserID from the request
if (isset($_GET['UserID'])) {
    $UserID = $_GET['UserID'];
} else {
    echo json_encode(array("error" => "UserID not provided"));
    exit();
}

// Prepare and execute the SQL query to fetch the student data
$sql = "
SELECT s.*, u.Name AS UserName, u.Email, u.Address, u.Role, u.RegistrationNumber 
FROM registeredcourses rc 
JOIN users u ON rc.UserID = u.UserID 
JOIN student s ON u.RegistrationNumber = s.RegistrationNumber 
WHERE rc.CourseID IN (
    SELECT CourseID 
    FROM registeredcourses 
    WHERE UserID ='$UserID' AND role = 'faculty'
)";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    echo json_encode(array("error" => "Failed to prepare statement: " . $conn->error));
    exit();
}

// $stmt->bind_param("i", $UserID);
$stmt->execute();
$result = $stmt->get_result();

if (!$result) {
    echo json_encode(array("error" => "Database query failed"));
    exit();
}

// Store the fetched data in an array
$students = array();
while ($row = $result->fetch_assoc()) {
    $students[] = $row;
}

$stmt->close();
$conn->close();

// Return the student data as JSON
echo json_encode($students);
?>
