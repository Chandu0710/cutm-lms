<?php
// Database connection
$host = 'localhost';
$dbname = 'cutmlms';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Fetch data from the assignments table
    $query = "SELECT * FROM assignments";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($result);
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
 