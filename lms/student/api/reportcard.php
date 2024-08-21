<?php
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

// Fetch the registration number from the request
$registrationNumber = $_GET['registrationNumber'];

// Prepare and execute the SQL query to fetch the student data
$sql = $conn->prepare("SELECT * FROM student WHERE RegistrationNumber = ?");
$sql->bind_param("s", $registrationNumber);
$sql->execute();
$result = $sql->get_result();

// Store the fetched data in an array
$student = array();
if ($result->num_rows > 0) {
    $student = $result->fetch_assoc();
}

$conn->close();

// Return the student data as JSON
echo json_encode($student);
?>
