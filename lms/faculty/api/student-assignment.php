<?php
// Establish connection to your database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Handle form submission for POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Retrieve form data
  $student_id = $_POST['student_id'];
  $assignment_id = $_POST['assignment_id'];
  $submission_date = $_POST['submission_date'];
  $grade = $_POST['grade'];
  $status = $_POST['status'];
  $submission_path = $_POST['submission_path'];
  
  // Prepare and bind SQL statement
  $stmt = $conn->prepare("INSERT INTO student_assignments (student_id, assignment_id, submission_date, grade, status, submission_path) VALUES (?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("iisdss", $student_id, $assignment_id, $submission_date, $grade, $status, $submission_path);

  // Execute SQL statement
  if ($stmt->execute() === TRUE) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $stmt->error;
  }

  // Close statement
  $stmt->close();
}

// Fetch assignment list from the database
if ($_SERVER["REQUEST_METHOD"] == "GET") {
  $sql = "SELECT sa.*, s.Branch AS Branch, a.title AS AssignmentTitle 
          FROM student_assignments sa
          INNER JOIN student s ON sa.student_id = s.StudentID
          INNER JOIN assignments a ON sa.assignment_id = a.assignment_id";
  $result = $conn->query($sql);
  $assignments = array();

  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $assignments[] = $row;
    }
  }

  echo json_encode($assignments);
}

// Handle form submission for PUT
if ($_SERVER["REQUEST_METHOD"] == "PUT") {
  parse_str(file_get_contents("php://input"), $_PUT);

  $student_assignment_id = $_PUT['student_assignment_id'];
  $submission_date = $_PUT['submission_date'];
  $grade = $_PUT['grade'];
  $status = $_PUT['status'];
  $submission_path = $_PUT['submission_path'];

  $sql = "UPDATE student_assignments SET submission_date=?, grade=?, status=?, submission_path=? WHERE student_assignment_id=?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("sdssi", $submission_date, $grade, $status, $submission_path, $student_assignment_id);

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

  $student_assignment_id = $_DELETE['student_assignment_id'];

  // Prepare and bind SQL statement
  $stmt = $conn->prepare("DELETE FROM student_assignments WHERE student_assignment_id=?");
  $stmt->bind_param("i", $student_assignment_id);

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
