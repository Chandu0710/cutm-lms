<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms"; // Change this to your actual database name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

$email = $_POST['email'];
$password = $_POST['password'];

$sql = $conn->prepare("SELECT * FROM users WHERE Email = ? OR Name = ?");
$sql->bind_param("ss", $email, $email);
$sql->execute();
$result = $sql->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    if ($password === $user['PasswordHash']) {
        if ($user['Role'] === 'faculty') {
            $response = [
                "status" => "success",
                "user" => [
                    "UserID" => $user['UserID'],
                    "Name" => $user['Name'],
                    "Email" => $user['Email'],
                    "Address" => $user['Address'],
                    "Role" => $user['Role'],
                    "FacultyID" => $user['FacultyID'],
                    "ProfilePicture" => $user['ProfilePicture']
                ],
                "message" => "Welcome, Faculty!"
            ];
            echo json_encode($response);
        } else {
            echo json_encode(["status" => "error", "message" => "Access denied: Only Faculty are allowed"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid password"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "No user found with the provided email or username"]);
}

$conn->close();
?>
