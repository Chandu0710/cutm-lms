<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Process form data from users table
  $name = $_POST["name"];
  $email = $_POST["email"];
  $password = $_POST["password"];
  $address = $_POST["address"];
  $role = $_POST["role"];
  $facultyID = $_POST["FacultyID"];
  $profilePicture = $_FILES["profilePicture"]["name"];

  // Upload profile picture
  $target_dir = "api/uploads/";
  $target_file = $target_dir."student_" . basename($_FILES["profilePicture"]["name"]);
  move_uploaded_file($_FILES["profilePicture"]["tmp_name"], $target_file);

  // Insert data into users table
  $sql_users = "INSERT INTO users (Name, Email, PasswordHash, Address, Role, FacultyID, ProfilePicture) 
                VALUES ('$name', '$email', '$password', '$address', '$role', '$facultyID', '$profilePicture')";

  if ($conn->query($sql_users) === TRUE) {
      // Process form data from student table
      $domain = $_POST["Domain"];
      $highestqualification = $_POST["HighestQualification"];
      $publications = $_POST["Publications"];
      $department = $_POST["Program"];

      // Insert data into student table
      $sql_student = "INSERT INTO student (FacultyID, Domain, HighestQualification, Publications, Program ) 
                      VALUES ('$facultyID', '$domain', '$highestqualification', '$publications', '$program')";

      if ($conn->query($sql_student) === TRUE) {
          echo "New records inserted successfully";
      } else {
          echo "Error: " . $sql_student . "<br>" . $conn->error;
      }
  } else {
      echo "Error: " . $sql_users . "<br>" . $conn->error;
  }

  // Close connection
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
