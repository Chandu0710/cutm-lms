<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = $_POST['name'];
  $email = $_POST['email'];
  $password = $_POST['password'];
  $address = $_POST['address'];
  $role = $_POST['role'];
  $facultyID = $_POST['facultyID'];
  $profilePicture = $_FILES['profilePicture']['name'];

  $check_email_stmt = $conn->prepare("SELECT UserID FROM users WHERE Email = ?");
  $check_email_stmt->bind_param("s", $email);
  $check_email_stmt->execute();
  $check_email_stmt->store_result();

  if ($check_email_stmt->num_rows > 0) {
    echo json_encode(['error' => 'Email already exists.']);
  } else {
    $target_dir = "uploads/";
    $imageFileType = strtolower(pathinfo($profilePicture, PATHINFO_EXTENSION));
    $newFileName = 'faculty_' . basename($profilePicture, ".$imageFileType") . '.' . $imageFileType; // Generate a new filename
    $newFilePath = $target_dir . $newFileName;

    if (move_uploaded_file($_FILES["profilePicture"]["tmp_name"], $newFilePath)) {
      $stmt = $conn->prepare("INSERT INTO users (Name, Email, PasswordHash, Address, Role, FacultyID, ProfilePicture) VALUES (?, ?, ?, ?, ?, ?, ?)");
      $stmt->bind_param("sssssss", $name, $email, $password, $address, $role, $facultyID, $newFileName);

      if ($stmt->execute()) {
        echo json_encode(['success' => 'New record created successfully']);
      } else {
        echo json_encode(['error' => 'Database error: ' . $stmt->error]);
      }
      $stmt->close();
    } else {
      echo json_encode(['error' => 'File upload error']);
    }
  }
  $check_email_stmt->close();
  $conn->close();
}

if ($_SERVER["REQUEST_METHOD"] == "GET") {
  $sql = "SELECT * FROM users WHERE Role = 'faculty'";
  $result = $conn->query($sql);
  $users = [];

  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $row['ProfilePicture'] = '' . $row['ProfilePicture'];
      $users[] = $row;
    }
    echo json_encode($users, JSON_UNESCAPED_SLASHES);
  } else {
    echo json_encode(['error' => 'No results found']);
  }
}

if ($_SERVER["REQUEST_METHOD"] == "PUT") {
  parse_str(file_get_contents("php://input"), $_PUT);

  $userID = $_PUT['userID'];
  $name = $_PUT['name'];
  $email = $_PUT['email'];
  $address = $_PUT['address'];
  $facultyID = $_PUT['facultyID'];

  $sql = "UPDATE users SET Name=?, Email=?, Address=?, FacultyID=? WHERE UserID=?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("ssssi", $name, $email, $address, $facultyID, $userID);

  if ($stmt->execute()) {
    echo json_encode(['success' => 'Record updated successfully']);
  } else {
    echo json_encode(['error' => 'Database error: ' . $stmt->error]);
  }
  $stmt->close();
  $conn->close();
}

if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
  parse_str(file_get_contents("php://input"), $_DELETE);

  $userID = $_DELETE['userID'];
  $filename_query = $conn->prepare("SELECT ProfilePicture FROM users WHERE UserID=?");
  $filename_query->bind_param("i", $userID);
  $filename_query->execute();
  $filename_query->store_result();

  if ($filename_query->num_rows > 0) {
    $filename_query->bind_result($profilePicture);
    $filename_query->fetch();

    $delete_sql = "DELETE FROM users WHERE UserID=?";
    $delete_stmt = $conn->prepare($delete_sql);
    $delete_stmt->bind_param("i", $userID);

    if (file_exists('uploads/' . $profilePicture)) {
      unlink('uploads/' . $profilePicture);
    }

    if ($delete_stmt->execute()) {
      echo json_encode(['success' => 'Record deleted successfully']);
    } else {
      echo json_encode(['error' => 'Database error: ' . $delete_stmt->error]);
    }
    $delete_stmt->close();
  } else {
    echo json_encode(['error' => 'User not found']);
  }
  $filename_query->close();
  $conn->close();
}
?>
