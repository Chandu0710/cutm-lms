<?php
// Establish connection to your database
$servername = "localhost";
$Name = "root";
$password = "";
$dbname = "cutmlms";

$conn = new mysqli($servername, $Name, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Retrieve form data
  $userID = $_POST['userID'];
  $courseID = $_POST['courseID'];
  $fromDate = $_POST['fromdate'];
  $toDate = $_POST['todate'];
  $status = $_POST['status'];
  $role = $_POST['role'];

  // Prepare and bind SQL statement
  $stmt = $conn->prepare("INSERT INTO registeredcourses (UserID, CourseID, fromdate, todate, status, role) VALUES (?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("iissss", $userID, $courseID, $fromDate, $toDate, $status, $role);

  // Execute SQL statement
  if ($stmt->execute() === TRUE) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $stmt->error;
  }

  // Close statement
  $stmt->close();
}

// Fetch user list from the database
if ($_SERVER["REQUEST_METHOD"] == "GET") {
  // Fetch user data
  // $UserID = "3";
  $UserID = $_GET['UserID'];
  $sql = "SELECT registeredcourses.*, users.Name AS Name, courses.*  FROM registeredcourses 
          INNER JOIN users ON registeredcourses.UserID = users.UserID 
          INNER JOIN courses ON registeredcourses.CourseID = courses.CourseID 
          WHERE registeredcourses.UserID='$UserID'";
  $result = $conn->query($sql);
  $courses = array();

  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $courses[] = $row;
    }
  }

  echo json_encode($courses);
}

// Handle form submission for PUT
if ($_SERVER["REQUEST_METHOD"] == "PUT") {
  parse_str(file_get_contents("php://input"), $_PUT);

  $courseID = $_PUT['courseID'];
  $fromDate = $_PUT['fromdate'];
  $toDate = $_PUT['todate'];
  $status = $_PUT['status'];
  $role = $_PUT['role'];
  // $userID = $_PUT['userID']; // This line is not required, as we are updating based on courseID

  $sql = "UPDATE registeredcourses SET fromdate=?, todate=?, status=?, role=? WHERE CourseID=?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("ssssi", $fromDate, $toDate, $status, $role, $courseID); // Updated binding parameters

  if ($stmt->execute()) {
    echo "Record updated successfully";
  } else {
    echo "Error: " . $stmt->error;
  }

  $stmt->close();
}

// Handle form submission for DELETE
if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
  parse_str(file_get_contents("php://input"), $_DELETE);

  $courseID = $_DELETE['courseID']; // Corrected the variable name

  // Prepare and bind SQL statement
  $stmt = $conn->prepare("DELETE FROM registeredcourses WHERE CourseID=?"); // Updated the query to delete based on CourseID
  $stmt->bind_param("i", $courseID);

  // Execute SQL statement
  if ($stmt->execute()) {
    echo "Record deleted successfully";
  } else {
    echo "Error: " . $stmt->error;
  }

  // Close statement
  $stmt->close();
}

// Close connection
$conn->close();
?>
