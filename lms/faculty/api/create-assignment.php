<?php
// Database connection details
$host = 'localhost';
$dbname = 'cutmlms';
$username = 'root';
$password = '';

try {
    // Create a new PDO instance
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Check if the form is submitted
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Get the form data
        $course_id = $_POST['CourseID'];
        $title = $_POST['title'];
        $description = $_POST['description'];
        $due_date = $_POST['due_date'];
        $max_grade = $_POST['max_grade'];
        $file_location = $_FILES['file_location']['name'];
        $faculty_id = $_POST['faculty_id'];

        // Handle file upload
        if ($file_location) {
            $target_dir = "uploads/materials";
            $target_file = $target_dir . basename($_FILES['file_location']['name']);
            if (!move_uploaded_file($_FILES['file_location']['tmp_name'], $target_file)) {
                throw new Exception("File upload failed");
            }
        }

        // Prepare the SQL statement
        $sql = "INSERT INTO assignments (CourseID, title, description, due_date, max_grade, file_location, faculty_id) 
                VALUES (:CourseID, :title, :description, :due_date, :max_grade, :file_location, :faculty_id)";

        // Prepare the statement
        $stmt = $pdo->prepare($sql);

        // Bind the parameters
        $stmt->bindParam(':CourseID', $course_id, PDO::PARAM_INT);
        $stmt->bindParam(':title', $title, PDO::PARAM_STR);
        $stmt->bindParam(':description', $description, PDO::PARAM_STR);
        $stmt->bindParam(':due_date', $due_date, PDO::PARAM_STR);
        $stmt->bindParam(':max_grade', $max_grade, PDO::PARAM_STR);
        $stmt->bindParam(':file_location', $file_location, PDO::PARAM_STR);
        $stmt->bindParam(':faculty_id', $faculty_id, PDO::PARAM_INT);

        // Execute the statement
        if ($stmt->execute()) {
            echo "Assignment created successfully.";
        } else {
            echo "Failed to create assignment.";
        }
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
