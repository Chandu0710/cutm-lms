<?php
header('Content-Type: application/json');

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // Get the posted data
        $data = json_decode(file_get_contents("php://input"), true);

        $id = $data['id'];
        $phoneNumber = $data["phoneNumber"];
        $address = $data["address"];
        $state = $data["state"];
        $zipCode = $data["zipCode"];
        $country = $data["country"];

        // Database connection
         // Database connection
         $servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";
        

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            throw new Exception("Connection failed: " . $conn->connect_error);
        }

        // Update user details in the database
        $sql = "UPDATE users SET phoneNumber='$phoneNumber', address='$address', state='$state', zipCode='$zipCode', country='$country' WHERE id=$id";

        if ($conn->query($sql) === TRUE) {
            echo json_encode(["status" => "success", "message" => "Profile updated successfully"]);
        } else {
            throw new Exception("Error updating profile: " . $conn->error);
        }

        $conn->close();
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
} elseif ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['id'])) {
    try {
        $id = $_GET['id'];

        // Database connection
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "starz";

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            throw new Exception("Connection failed: " . $conn->connect_error);
        }

        // Fetch user details from the database
        $sql = "SELECT * FROM users WHERE id=$id";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            echo json_encode([
                'status' => 'success',
                'data' => $row
            ]);
        } else {
            throw new Exception("No user found with the provided ID");
        }

        $conn->close();
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method or missing ID"]);
}
?>
