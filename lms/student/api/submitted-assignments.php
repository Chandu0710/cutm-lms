<?php
header('Content-Type: application/json');

// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the request method is GET
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    // Fetch student registration number
    $registrationNumber = $_GET['RegistrationNumber']; // Match parameter name

    // SQL query to fetch assignment details
    $sql = "SELECT 
    a.assignment_id,
    a.CourseID,
    a.title,
    a.description,
    a.due_date,
    a.max_grade,
    a.file_location,
    a.created_at AS assignment_created_at,
    a.updated_at AS assignment_updated_at,
    f.Name AS faculty_name,
    sa.student_assignment_id,
    sa.submission_date,
    sa.grade,
    sa.status,
    sa.created_at AS student_assignment_created_at,
    sa.updated_at AS student_assignment_updated_at,
    sa.submission_path,
    sa.submissionon
FROM 
    student_assignments sa
JOIN 
    assignments a ON sa.assignment_id = a.assignment_id
JOIN 
    users s ON sa.Stud_reg_num = s.RegistrationNumber
JOIN 
    users f ON a.faculty_id = f.UserID
WHERE 
    s.RegistrationNumber = '$registrationNumber' && sa.status='Submitted';
";

    $result = $conn->query($sql);
    $assignments = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $assignments[] = $row;
        }
    }

    echo json_encode($assignments);
}

$conn->close();
?>
