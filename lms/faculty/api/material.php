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

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Handle file upload and creation of new materials
    if (isset($_FILES['file']) && $_FILES['file']['error'] == UPLOAD_ERR_OK) {
        $fileTmpPath = $_FILES['file']['tmp_name'];
        $fileName = $_FILES['file']['name'];
        $uploadFileDir = 'uploads/materials/';
        $dest_path = $uploadFileDir . $fileName;

        if (move_uploaded_file($fileTmpPath, $dest_path)) {
            $file_url = $dest_path;

            $material_name = $_POST['material_name'];
            $type_uploaded = $_POST['type_uploaded'];
            $uploaded_by = $_POST['uploaded_by'];
            $uploaded_time = $_POST['uploaded_time'];

            $stmt = $conn->prepare("INSERT INTO material (material_name, File, type_uploaded, uploaded_by, uploaded_time) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssss", $material_name, $file_url, $type_uploaded, $uploaded_by, $uploaded_time);

            if ($stmt->execute()) {
                echo json_encode([
                    'material_id' => $stmt->insert_id,
                    'material_name' => $material_name,
                    'File' => $file_url,
                    'type_uploaded' => $type_uploaded,
                    'uploaded_by' => $uploaded_by,
                    'uploaded_time' => $uploaded_time
                ]);
            } else {
                echo json_encode(['error' => $stmt->error]);
            }

            $stmt->close();
        } else {
            echo json_encode(['error' => 'Error moving the uploaded file.']);
        }
    } else {
        echo json_encode(['error' => 'Error uploading the file.']);
    }
} 

if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    // Handle updating existing materials
    parse_str(file_get_contents("php://input"), $put_vars);

    $material_id = $put_vars['material_id'];
    $material_name = $put_vars['material_name'];
    $type_uploaded = $put_vars['type_uploaded'];
    $uploaded_by = $put_vars['uploaded_by'];
    $uploaded_time = $put_vars['uploaded_time'];

    $stmt = $conn->prepare("UPDATE material SET material_name = ?, type_uploaded = ?, uploaded_by = ?, uploaded_time = ? WHERE material_id = ?");
    $stmt->bind_param("ssssi", $material_name, $type_uploaded, $uploaded_by, $uploaded_time, $material_id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => $stmt->error]);
    }

    $stmt->close();
}

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // Handle GET request to retrieve materials
    $sql = "SELECT material_id, material_name, File, type_uploaded, uploaded_by, uploaded_time FROM material";
    $result = $conn->query($sql);

    $materials = [];
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $materials[] = $row;
        }
    }

    echo json_encode($materials, JSON_UNESCAPED_SLASHES);
}

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    // Handle DELETE request to delete materials
    $material_id = $_GET['material_id'];

    // Retrieve file path from database based on material_id
    $stmt_select = $conn->prepare("SELECT File FROM material WHERE material_id = ?");
    $stmt_select->bind_param("i", $material_id);
    $stmt_select->execute();
    $stmt_select->store_result();

    if ($stmt_select->num_rows > 0) {
        $stmt_select->bind_result($file_path);
        $stmt_select->fetch();

        // Delete file from server
        if (unlink($file_path)) {
            // Delete entry from database
            $stmt_delete = $conn->prepare("DELETE FROM material WHERE material_id = ?");
            $stmt_delete->bind_param("i", $material_id);

            if ($stmt_delete->execute()) {
                echo json_encode(['success' => true]);
            } else {
                echo json_encode(['error' => 'Failed to delete material from database']);
            }

            $stmt_delete->close();
        } else {
            echo json_encode(['error' => 'Failed to delete file from server']);
        }
    } else {
        echo json_encode(['error' => 'Material not found']);
    }

    $stmt_select->close();
    $conn->close();
    exit(); // Exit to prevent further execution
}


$conn->close();
?>
