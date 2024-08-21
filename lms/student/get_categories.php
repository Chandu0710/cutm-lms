<?php
// Assuming you have a database connection established
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

if(isset($_GET['courseType'])){ // Use GET request
    $courseType = $_GET['courseType'];
    
    $sql = "SELECT DISTINCT Category FROM courses WHERE CourseType = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $courseType);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $categories = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $categories[] = $row;
        }
    }
    echo json_encode($categories);
}
$conn->close();
?>
