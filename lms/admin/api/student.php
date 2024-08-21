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

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Process form data from users table
  $name = $_POST["name"];
  $email = $_POST["email"];
  $password = $_POST["password"];
  $address = $_POST["address"];
  $role = $_POST["role"];
  $registrationNumber = $_POST["RegistrationNumber"];
  $profilePicture = $_FILES["profilePicture"]["name"];

  // Upload profile picture
  $target_dir = "api/uploads/";
  $target_file = $target_dir."student_" . basename($_FILES["profilePicture"]["name"]);
  move_uploaded_file($_FILES["profilePicture"]["tmp_name"], $target_file);

  // Insert data into users table
  $sql_users = "INSERT INTO users (Name, Email, PasswordHash, Address, Role, RegistrationNumber, ProfilePicture) 
                VALUES ('$name', '$email', '$password', '$address', '$role', '$registrationNumber', '$profilePicture')";

  if ($conn->query($sql_users) === TRUE) {
      // Process form data from student table
      $program = $_POST["Program"];
      $domain = $_POST["Domain"];
      $cgpa = $_POST["CGPA"];
      $sgpa = $_POST["SGPA"];
      $joiningDate = $_POST["JoiningDate"];
      $currentYearofStudy = $_POST["CurrentYearofStudy"];

      // Insert data into student table
      $sql_student = "INSERT INTO student (RegistrationNumber, Program, Domain, CGPA, SGPA, JoiningDate, CurrentYearofStudy) 
                      VALUES ('$registrationNumber', '$program', '$domain', '$cgpa', '$sgpa', '$joiningDate', '$currentYearofStudy')";

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

// Fetch user list from the database
if ($_SERVER["REQUEST_METHOD"] == "GET") {
  // Fetch user data
  $sql = "SELECT * FROM users WHERE Role = 'student'";
  $result = $conn->query($sql);
  $users = array();

  if ($result->num_rows > 0) {
    // Output data of each row
    while ($row = $result->fetch_assoc()) {
      // Append image path to the row
      $row['ProfilePicture'] = 'api/uploads/' . $row['ProfilePicture'];
      $users[] = $row;
    }
    echo json_encode($users, JSON_UNESCAPED_SLASHES);
  } else {
    echo "0 results";
  }
}

// Handle form submission for PUT
if ($_SERVER["REQUEST_METHOD"] == "PUT") {
  parse_str(file_get_contents("php://input"), $_PUT);

  $userID = $_PUT['userID'];
  $name = $_PUT['name'];
  $email = $_PUT['email'];
  $address = $_PUT['address'];
  $registrationNumber = $_PUT['registrationNumber'];

  $sql = "UPDATE users SET Name=?, Email=?, Address=?, RegistrationNumber=? WHERE UserID=?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("ssssi", $name, $email, $address, $registrationNumber, $userID);

  if ($stmt->execute()) {
    echo "Record updated successfully";
  } else {
    echo "Error: " . $stmt->error;
  }

  $stmt->close();
  $conn->close();
}

// Handle form submission for DELETE
if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
  parse_str(file_get_contents("php://input"), $_DELETE);

  $userID = $_DELETE['userID'];

  // Fetch the filename of the profile picture to be deleted
  $filename_query = $conn->prepare("SELECT ProfilePicture FROM users WHERE UserID=?");
  $filename_query->bind_param("i", $userID);
  $filename_query->execute();
  $filename_query->store_result();

  // Check if the user exists
  if ($filename_query->num_rows > 0) {
    $filename_query->bind_result($profilePicture);
    $filename_query->fetch();

    // Delete the user record
    $delete_sql = "DELETE FROM users WHERE UserID=?";
    $delete_stmt = $conn->prepare($delete_sql);
    $delete_stmt->bind_param("i", $userID);

    // Delete the image file if it exists
    if (file_exists('uploads/' . $profilePicture)) {
      unlink('uploads/' . $profilePicture);
    }

    // Execute the delete statement
    if ($delete_stmt->execute()) {
      echo "Record deleted successfully";
    } else {
      echo "Error: " . $delete_stmt->error;
    }

    $delete_stmt->close();
  } else {
    echo "User not found";
  }

  $filename_query->close();
  $conn->close();
}
?>
