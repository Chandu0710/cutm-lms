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

// Check if courseName is set for filtering
if(isset($_GET['courseName'])){
    $courseName = $_GET['courseName'];
    
    $sql = "SELECT * FROM assignments WHERE CourseID IN (SELECT CourseID FROM courses WHERE CourseName = ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $courseName);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $assignments = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $assignments[] = $row;
        }
    }
    echo json_encode($assignments);
} else {
    // If courseName is not set, fetch all assignments
    $sql = "SELECT * FROM assignments";
    $result = $conn->query($sql);

    $assignments = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $assignments[] = $row;
        }
    }
    echo json_encode($assignments);
}

$conn->close();
?>
