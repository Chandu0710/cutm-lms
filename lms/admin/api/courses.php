<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cutmlms";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if it's a POST request to insert new course
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $courseName = $_POST['CourseName'];
    $program = $_POST['Program'];
    $domain = $_POST['Domain'];
    $createdBy = $_POST['CreatedBy'];
    $syllabusLink = $_POST['SyllabusLink'];
    $totalCredits = $_POST['TotalCredits'];
    $creditDistribution = $_POST['CreditDistribution'];

    $sql = "INSERT INTO courses (CourseName, Program, Domain, CreatedBy, SyllabusLink, TotalCredits, CreditDistribution) 
            VALUES ('$courseName', '$program', '$domain' , '$createdBy', '$syllabusLink', '$totalCredits', '$creditDistribution')";

    if ($conn->query($sql) === TRUE) {
        echo "New course created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

// Check if it's a GET request to fetch course list or a specific course
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    if (isset($_GET['CourseID'])) {
        $courseID = $_GET['CourseID'];
        $sql = "SELECT courses.*, users.name as CreatedByName FROM courses 
                LEFT JOIN users ON courses.CreatedBy = users.UserID 
                WHERE CourseID=$courseID";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $course = $result->fetch_assoc();
            echo json_encode($course);
        } else {
            echo "Course not found";
        }
    } else {
        $sql = "SELECT courses.*, users.name as CreatedByName FROM courses 
                LEFT JOIN users ON courses.CreatedBy = users.UserID";
        $result = $conn->query($sql);

        $courses = array();
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $courses[] = $row;
            }
        }

        echo json_encode($courses);
    }
}

// Check if it's a PUT request to update course details
if ($_SERVER["REQUEST_METHOD"] == "PUT") {
    parse_str(file_get_contents("php://input"), $putData);
    $courseID = $putData['CourseID'];
    $courseName = $putData['CourseName'];
    $program = $putData['Program'];
    $domain = $putData['Domain'];
    $createdBy = $putData['CreatedBy'];
    $syllabusLink = $putData['SyllabusLink'];
    $totalCredits = $putData['TotalCredits'];
    $creditDistribution = $putData['CreditDistribution'];

    $sql = "UPDATE courses SET CourseName='$courseName', Program='$program', Domain='$domain', CreatedBy='$createdBy', 
            SyllabusLink='$syllabusLink', TotalCredits='$totalCredits', 
            CreditDistribution='$creditDistribution' WHERE CourseID=$courseID";

    if ($conn->query($sql) === TRUE) {
        echo "Course updated successfully";
    } else {
        echo "Error updating course: " . $conn->error;
    }
}

// Check if it's a DELETE request to delete a course
if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
    parse_str(file_get_contents("php://input"), $deleteData);
    $courseID = $deleteData['CourseID'];

    $sql = "DELETE FROM courses WHERE CourseID=$courseID";

    if ($conn->query($sql) === TRUE) {
        echo "Course deleted successfully";
    } else {
        echo "Error deleting course: " . $conn->error;
    }
}

$conn->close();
?>
