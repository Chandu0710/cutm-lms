-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2024 at 04:38 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cutmlms`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `assignment_id` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `max_grade` decimal(5,2) DEFAULT NULL,
  `file_location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `faculty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`assignment_id`, `CourseID`, `title`, `description`, `due_date`, `max_grade`, `file_location`, `created_at`, `updated_at`, `faculty_id`) VALUES
(1, 1, 'Assignment 1', 'Description for assignment 1', '2024-06-01 23:59:59', 100.00, 'assignment1.pdf', '2024-04-30 23:00:00', '2024-05-30 18:40:02', 4),
(2, 3, 'Assignment 2', 'Description for assignment 2', '2024-06-10 23:59:59', 100.00, 'assignment2.pdf', '2024-05-01 23:00:00', '2024-05-31 08:04:46', 16),
(3, 5, 'Assignment 3', 'Description for assignment 3', '2024-06-15 23:59:59', 100.00, 'assignment3.pdf', '2024-05-02 23:00:00', '2024-05-30 18:40:35', 4);

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `CertificateID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `IssuedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courseparts`
--

CREATE TABLE `courseparts` (
  `PartID` int(11) NOT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `PartName` varchar(255) NOT NULL,
  `Content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `CourseID` int(11) NOT NULL,
  `CourseName` varchar(255) NOT NULL,
  `CourseCode` varchar(20) NOT NULL,
  `Program` enum('BTECH','BSC','BBA','BCA','BARCH') NOT NULL,
  `Domain` varchar(100) NOT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `SyllabusLink` varchar(255) DEFAULT NULL,
  `TotalCredits` int(11) NOT NULL,
  `CreditDistribution` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`CourseID`, `CourseName`, `CourseCode`, `Program`, `Domain`, `CreatedBy`, `SyllabusLink`, `TotalCredits`, `CreditDistribution`) VALUES
(1, 'Course Name 1', 'COURSECODE1', 'BTECH', 'Computer Science', 1, 'link-to-syllabus1.pdf', 4, '3-1-0'),
(2, 'Course Name 2', 'COURSECODE2', 'BSC', 'Physics', 2, 'link-to-syllabus2.pdf', 3, '2-1-0'),
(3, 'Organic Chemistry', 'OC1524', 'BBA', 'Finance', 3, 'https://example.com/os_syllabus', 10, '3-4-3'),
(4, 'Introduction to Computer Science', 'CS101', 'BTECH', 'Computer Science', 1, 'cs101-syllabus.pdf', 4, '3-1-0'),
(5, 'Advanced Physics', 'PH201', 'BSC', 'Physics', 2, 'ph201-syllabus.pdf', 3, '2-1-0'),
(6, 'Marketing Principles', 'MK101', 'BBA', 'Marketing', 3, 'mk101-syllabus.pdf', 3, '2-1-0'),
(7, 'Web Development Basics', 'WD101', 'BCA', 'Web Development', 4, 'wd101-syllabus.pdf', 4, '3-1-0'),
(8, 'Architectural Design I', 'AD101', 'BARCH', 'Architectural Design', 5, 'ad101-syllabus.pdf', 5, '3-2-0'),
(9, 'Data Structures and Algorithms', 'CS102', 'BTECH', 'Computer Science', 1, 'cs102-syllabus.pdf', 4, '3-1-0'),
(10, 'Organic Chemistry', 'CH201', 'BSC', 'Chemistry', 2, 'ch201-syllabus.pdf', 3, '2-1-0'),
(11, 'Financial Accounting', 'FA101', 'BBA', 'Finance', 3, 'fa101-syllabus.pdf', 3, '2-1-0'),
(12, 'Database Management Systems', 'DB101', 'BCA', 'Database Management', 4, 'db101-syllabus.pdf', 4, '3-1-0'),
(13, 'Urban Planning Principles', 'UP101', 'BARCH', 'Urban Planning', 5, 'up101-syllabus.pdf', 4, '3-1-0'),
(14, 'Electric Circuits', 'EE101', 'BTECH', 'Electrical Engineering', 1, 'ee101-syllabus.pdf', 4, '3-1-0'),
(15, 'Calculus I', 'MA101', 'BSC', 'Mathematics', 2, 'ma101-syllabus.pdf', 3, '3-0-0'),
(16, 'Human Resource Management', 'HR101', 'BBA', 'Human Resource Management', 3, 'hr101-syllabus.pdf', 3, '2-1-0'),
(17, 'Introduction to Networking', 'NW101', 'BCA', 'Networking', 4, 'nw101-syllabus.pdf', 4, '3-1-0'),
(18, 'Building Materials', 'BM101', 'BARCH', 'Building Materials and Construction', 5, 'bm101-syllabus.pdf', 4, '3-1-0'),
(19, 'Mechanics', 'ME101', 'BTECH', 'Mechanical Engineering', 1, 'me101-syllabus.pdf', 4, '3-1-0'),
(20, 'Environmental Science', 'ES101', 'BSC', 'Environmental Science', 2, 'es101-syllabus.pdf', 3, '2-1-0'),
(21, 'Operations Management', 'OM101', 'BBA', 'Operations Management', 3, 'om101-syllabus.pdf', 3, '2-1-0'),
(22, 'Programming in Java', 'PJ101', 'BCA', 'Programming', 4, 'pj101-syllabus.pdf', 4, '3-1-0'),
(23, 'History of Architecture', 'HA101', 'BARCH', 'History of Architecture', 5, 'ha101-syllabus.pdf', 3, '2-1-0');

-- --------------------------------------------------------

--
-- Table structure for table `course_material`
--

CREATE TABLE `course_material` (
  `course_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_material`
--

INSERT INTO `course_material` (`course_id`, `material_id`) VALUES
(5, 7),
(11, 6),
(12, 5),
(15, 7);

-- --------------------------------------------------------

--
-- Table structure for table `course_topic`
--

CREATE TABLE `course_topic` (
  `course_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE `domains` (
  `DomainID` int(11) NOT NULL,
  `ProgramCode` varchar(10) DEFAULT NULL,
  `DomainName` varchar(50) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `CreatedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `domains`
--

INSERT INTO `domains` (`DomainID`, `ProgramCode`, `DomainName`, `Description`, `CreatedDate`) VALUES
(1, 'BTECH', 'Computer Science', 'Study of computers and computational systems', '2024-05-28'),
(2, 'BTECH', 'Electrical Engineering', 'Study of electrical systems and electronics', '2024-05-28'),
(3, 'BTECH', 'Mechanical Engineering', 'Study of machines and mechanical systems', '2024-05-28'),
(4, 'BTECH', 'Civil Engineering', 'Study of construction and infrastructure', '2024-05-28'),
(5, 'BTECH', 'Biotechnology', 'Study of biological systems and organisms', '2024-05-28'),
(6, 'BSC', 'Physics', 'Study of matter and energy', '2024-05-28'),
(7, 'BSC', 'Chemistry', 'Study of substances, their properties, and reactions', '2024-05-28'),
(8, 'BSC', 'Mathematics', 'Study of numbers, quantities, and shapes', '2024-05-28'),
(9, 'BSC', 'Biology', 'Study of living organisms', '2024-05-28'),
(10, 'BSC', 'Environmental Science', 'Study of the environment and its components', '2024-05-28'),
(11, 'BBA', 'Marketing', 'Study of promoting and selling products or services', '2024-05-28'),
(12, 'BBA', 'Finance', 'Study of managing money and investments', '2024-05-28'),
(13, 'BBA', 'Human Resource Management', 'Study of managing personnel within an organization', '2024-05-28'),
(14, 'BBA', 'Operations Management', 'Study of managing processes to produce goods or services', '2024-05-28'),
(15, 'BBA', 'Entrepreneurship', 'Study of starting and managing businesses', '2024-05-28'),
(16, 'BCA', 'Web Development', 'Study of creating websites and web applications', '2024-05-28'),
(17, 'BCA', 'Database Management', 'Study of organizing and managing data', '2024-05-28'),
(18, 'BCA', 'Programming', 'Study of writing computer programs', '2024-05-28'),
(19, 'BCA', 'Networking', 'Study of connecting computers and devices', '2024-05-28'),
(20, 'BCA', 'Software Engineering', 'Study of developing software systems', '2024-05-28'),
(21, 'BARCH', 'Architectural Design', 'Study of designing buildings and structures', '2024-05-28'),
(22, 'BARCH', 'Urban Planning', 'Study of planning and designing cities and communities', '2024-05-28'),
(23, 'BARCH', 'Building Materials and Construction', 'Study of materials and techniques used in construction', '2024-05-28'),
(24, 'BARCH', 'History of Architecture', 'Study of architectural styles and traditions throughout history', '2024-05-28'),
(25, 'BARCH', 'Environmental Design', 'Study of designing environments to be sustainable and functional', '2024-05-28');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `FacultyID` varchar(20) NOT NULL,
  `Program` varchar(50) NOT NULL,
  `Domain` varchar(100) NOT NULL,
  `HighestQualification` varchar(100) NOT NULL,
  `Publications` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`FacultyID`, `Program`, `Domain`, `HighestQualification`, `Publications`) VALUES
('F001', 'BSc', 'Forensic', 'P.hd', 2),
('F002', 'B.Tech', 'CN', 'P.hd', 1),
('F003', 'B.Tech', 'AIML', 'M.Tech', 1),
('F004', 'B.Tech', 'DS', 'M.Tech', 1),
('F005', 'BSc', 'Optometry', 'P.hd', 2),
('F007', 'B.Tech', 'AWS', 'M.Tech', 1),
('F008', 'BSc', 'Anesthesia', 'P.hd', 1);

-- --------------------------------------------------------

--
-- Table structure for table `material`
--

CREATE TABLE `material` (
  `material_id` int(11) NOT NULL,
  `material_name` varchar(255) NOT NULL,
  `File` varchar(255) NOT NULL,
  `type_uploaded` varchar(50) NOT NULL,
  `uploaded_by` varchar(255) NOT NULL,
  `uploaded_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `material`
--

INSERT INTO `material` (`material_id`, `material_name`, `File`, `type_uploaded`, `uploaded_by`, `uploaded_time`) VALUES
(5, 'Django', 'uploads/materials/Research-Data-Management-in-the-Canadian-Context-1705500780.pdf', 'PDF', 'F154632', '2024-05-28 12:16:00'),
(6, 'UI/UX', 'uploads/materials/978-1-4842-4932-1.pdf', 'PDF', 'F8616841', '2024-05-28 12:22:06'),
(7, 'Node Advanced Topics', 'uploads/materials/Node [Autosaved].pptx', 'PDF', 'F48318764', '2024-05-28 12:45:52');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `ProgramCode` varchar(10) NOT NULL,
  `ProgramName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`ProgramCode`, `ProgramName`) VALUES
('BARCH', 'Bachelor of Architecture'),
('BBA', 'Bachelor of Business Administration'),
('BCA', 'Bachelor of Computer Applications'),
('BSC', 'Bachelor of Science'),
('BTECH', 'Bachelor of Technology');

-- --------------------------------------------------------

--
-- Table structure for table `quizresults`
--

CREATE TABLE `quizresults` (
  `ResultID` int(11) NOT NULL,
  `QuizID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Score` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `QuizID` int(11) NOT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `QuizContent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recommendedcourses`
--

CREATE TABLE `recommendedcourses` (
  `RecommendationID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `CourseID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registeredcourses`
--

CREATE TABLE `registeredcourses` (
  `regCoursesID` int(32) NOT NULL,
  `UserID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `fromdate` date NOT NULL,
  `todate` date NOT NULL,
  `status` enum('Registered','Failed','Ongoing','Withdrawn') NOT NULL,
  `createdon` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` enum('faculty','student') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registeredcourses`
--

INSERT INTO `registeredcourses` (`regCoursesID`, `UserID`, `CourseID`, `fromdate`, `todate`, `status`, `createdon`, `role`) VALUES
(14, 3, 5, '2024-05-31', '2024-05-31', 'Ongoing', '2024-05-30 19:09:38', 'student'),
(15, 5, 3, '2024-05-31', '2024-05-31', 'Withdrawn', '2024-05-30 19:09:55', 'student'),
(16, 6, 7, '2024-05-31', '2024-05-31', 'Failed', '2024-05-30 19:10:06', 'faculty'),
(13, 10, 2, '2024-05-31', '2024-05-31', 'Registered', '2024-05-30 19:08:42', 'student'),
(17, 16, 5, '2024-04-29', '2024-06-08', 'Registered', '2024-05-30 19:14:46', 'faculty');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `RegistrationNumber` varchar(50) NOT NULL,
  `Program` varchar(100) NOT NULL,
  `Domain` varchar(100) NOT NULL,
  `CGPA` float NOT NULL,
  `SGPA` double NOT NULL,
  `JoiningDate` datetime NOT NULL,
  `CurrentYearofStudy` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`RegistrationNumber`, `Program`, `Domain`, `CGPA`, `SGPA`, `JoiningDate`, `CurrentYearofStudy`) VALUES
('211801350002', 'B.Tech', 'CN', 8.5, 9.7, '2022-05-11 02:11:31', 3),
('211801350007', 'B.Tech', 'CN', 8.3, 8.8, '2022-05-05 02:11:39', 3),
('211801350011', 'B.Tech', 'CN', 7.7, 8.6, '2023-05-02 02:11:46', 3),
('211801350020', 'B.Tech', 'CN', 8.8, 9.6, '2022-03-04 02:11:52', 3),
('211801370077', 'BSc', 'Optometry', 7.8, 8.1, '2022-04-14 02:12:02', 2),
('211801380029', 'B.Tech', 'DS', 8.8, 9.1, '2021-05-13 02:12:09', 4),
('211801381042', 'BSc', 'Anesthesia', 8.8, 8.8, '2022-05-07 02:12:16', 1),
('211801381043', 'BSc', 'Anesthesia', 8.5, 8.5, '2024-05-01 02:12:21', 1);

-- --------------------------------------------------------

--
-- Table structure for table `studentquizresults`
--

CREATE TABLE `studentquizresults` (
  `StudentQuizID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `QuizID` int(11) DEFAULT NULL,
  `Score` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_assignments`
--

CREATE TABLE `student_assignments` (
  `student_assignment_id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `submission_date` datetime DEFAULT NULL,
  `grade` decimal(5,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `submission_path` varchar(255) DEFAULT NULL,
  `submissionon` datetime DEFAULT NULL,
  `Stud_reg_num` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_assignments`
--

INSERT INTO `student_assignments` (`student_assignment_id`, `assignment_id`, `submission_date`, `grade`, `status`, `created_at`, `updated_at`, `submission_path`, `submissionon`, `Stud_reg_num`) VALUES
(1, 1, '2024-06-01 12:00:00', 85.00, 'Submitted', '2024-05-30 01:00:00', '2024-05-30 17:30:02', 'submissions/assignment1/student1.pdf', '2024-05-30 12:00:00', '211801350020'),
(2, 2, '2024-06-10 15:30:00', 90.00, 'Graded', '2024-06-05 04:30:00', '2024-05-30 17:30:24', 'submissions/assignment2/student2.pdf', '2024-06-05 15:30:00', '211801350011'),
(3, 1, '2024-06-01 13:00:00', 88.00, 'Submitted', '2024-05-30 02:00:00', '2024-05-30 17:30:28', 'submissions/assignment1/student3.pdf', '2024-05-30 13:00:00', '211801350020'),
(4, 3, '2024-06-15 14:00:00', 95.00, 'Graded', '2024-06-10 03:00:00', '2024-05-30 17:30:36', 'submissions/assignment3/student1.pdf', '2024-06-10 14:00:00', '211801350011'),
(5, 2, '2024-06-10 12:00:00', 80.00, 'Submitted', '2024-06-05 01:00:00', '2024-05-31 05:54:28', 'submissions/assignment2/student3.pdf', '2024-06-05 12:00:00', '211801350011'),
(6, 3, '2024-06-15 11:30:00', 92.00, 'Graded', '2024-06-10 00:30:00', '2024-06-15 03:00:00', 'submissions/assignment3/student2.pdf', '2024-06-10 11:30:00', ''),
(7, 1, '2024-06-01 09:00:00', 85.00, 'Submitted', '2024-05-29 22:00:00', '2024-05-29 22:00:00', 'submissions/assignment1/student2.pdf', '2024-05-30 09:00:00', ''),
(8, 2, '2024-06-10 08:30:00', 89.00, 'Submitted', '2024-06-04 21:30:00', '2024-06-04 21:30:00', 'submissions/assignment2/student1.pdf', '2024-06-05 08:30:00', ''),
(9, 3, '2024-06-15 10:30:00', 94.00, 'Graded', '2024-06-09 23:30:00', '2024-06-15 01:00:00', 'submissions/assignment3/student3.pdf', '2024-06-10 10:30:00', ''),
(10, 1, '2024-06-01 10:00:00', 86.00, 'Submitted', '2024-05-29 23:00:00', '2024-05-29 23:00:00', 'submissions/assignment1/student4.pdf', '2024-05-30 10:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `topic`
--

CREATE TABLE `topic` (
  `topic_id` int(11) NOT NULL,
  `topic_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `topic_material`
--

CREATE TABLE `topic_material` (
  `topic_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uploadedmaterials`
--

CREATE TABLE `uploadedmaterials` (
  `MaterialID` int(11) NOT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `MaterialType` enum('lecture','note') DEFAULT NULL,
  `Content` text DEFAULT NULL,
  `UploadedBy` int(11) DEFAULT NULL,
  `createdon` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userjwt`
--

CREATE TABLE `userjwt` (
  `JWTID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Token` varchar(512) NOT NULL,
  `Expiration` datetime NOT NULL,
  `IssuedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL DEFAULT 'cutmap@123',
  `Address` text DEFAULT NULL,
  `Role` enum('student','faculty','admin') NOT NULL,
  `RegistrationNumber` varchar(50) DEFAULT NULL,
  `FacultyID` varchar(50) DEFAULT NULL,
  `ProfilePicture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Name`, `Email`, `PasswordHash`, `Address`, `Role`, `RegistrationNumber`, `FacultyID`, `ProfilePicture`) VALUES
(1, 'Vyshnavi Adari', '211801350020@cutmap.ac.in', 'cutmap@123', 'Kancharapalem, Vizag', 'student', '211801350020', NULL, '211801350020.jpg'),
(2, 'Jogi naidu', 'joginaidu@cutmap.ac.in', 'cutmap@123', 'Vizianagaram', 'faculty', NULL, 'F001', 'F001.jpg'),
(3, 'Nithin Padavala', '211801350011@cutmap.ac.in', 'cutmap@123', 'Marripalem, Vizag', 'student', '211801350011', NULL, '211801350011.jpg'),
(4, 'Sunny Dayal', 'sunnydayal@cutmap.ac.in', 'cutmap@123', 'Vizianagaram', 'faculty', NULL, 'F002', 'F002.jpg'),
(5, 'Snigdha Bodepudi', '211801380029@cutmap.ac.in', 'cutmap@123', 'R&B, Vizag', 'student', '211801380029', NULL, '211801380029.jpg'),
(6, 'Subrath', 'jane.moore@example.com', 'cutmap@123', 'Vizianagaram', 'faculty', NULL, 'F003', 'F003.jpg'),
(7, 'Tony Stark', 'tony@gmail.com', 'cutmap@123', '10880 Malibu Point, 90265', 'admin', NULL, NULL, 'A001.jpg'),
(8, 'Sammy Mande', '211801370077@cutmap.ac.in', 'cutmap@123', 'P M Palem, Vizag', 'student', '211801370077', NULL, '211801370077.jpg'),
(9, 'Sravani', 'sravani@cutmap.ac.in', 'cutmap@123', 'Sabbavaram', 'faculty', NULL, 'F008', 'F004.jpg'),
(10, 'Praneeth Siriki', '211801381043@cutmap.ac.in', 'cutmap@123', 'Alamanda', 'student', '211801381043', NULL, '211801381043.jpg'),
(11, 'Deepak', 'deepak@cutmap.ac.in', 'cutmap@123', 'vizag', 'faculty', NULL, 'F005', 'F005.jpg'),
(12, 'Vinith', 'vinithbylapudi123@gmail.com', 'cutmap@123', 'vizag', 'admin', NULL, NULL, 'A002.jpg'),
(13, 'Lokesh Vinayak', '211801350007@cutmap.ac.in', 'cutmap@123', 'Birla, Vizag', 'student', '211801350007', NULL, '211801350007.jpg'),
(14, 'Acharyulu', 'acharyulu@cutmap.ac.in', 'cutmap@123', 'Isukathota, Vizag', 'faculty', NULL, 'F006', 'F006.jpg'),
(15, 'Hemachandh', '211801381042@cutmap.ac.in', 'cutmap@123', 'K L Puram, Vizianagaram', 'student', '211801381042', NULL, '211801381042.jpg'),
(16, 'Pushpalatha', 'pushpalatha@cutmap.ac.in', 'cutmap@123', 'Vizianagaram', 'faculty', NULL, 'F007', 'F007.jpg'),
(17, 'Akhil', '211801350002@cutmap.ac.in', 'cutmap@123', 'L N Puram, Vizianagaram', 'student', '211801350002', NULL, '211801350002.jpg'),
(18, 'Prasanta Mohanty', 'adminvc@cutmap.ac.in', 'cutmap@123', 'Vizianagaram', 'admin', NULL, NULL, 'A003.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`CertificateID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `courseparts`
--
ALTER TABLE `courseparts`
  ADD PRIMARY KEY (`PartID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`CourseID`),
  ADD UNIQUE KEY `CourseCode` (`CourseCode`),
  ADD KEY `CreatedBy` (`CreatedBy`);

--
-- Indexes for table `course_material`
--
ALTER TABLE `course_material`
  ADD PRIMARY KEY (`course_id`,`material_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indexes for table `course_topic`
--
ALTER TABLE `course_topic`
  ADD PRIMARY KEY (`course_id`,`topic_id`),
  ADD KEY `topic_id` (`topic_id`);

--
-- Indexes for table `domains`
--
ALTER TABLE `domains`
  ADD PRIMARY KEY (`DomainID`),
  ADD KEY `ProgramCode` (`ProgramCode`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`FacultyID`);

--
-- Indexes for table `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`material_id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`ProgramCode`);

--
-- Indexes for table `quizresults`
--
ALTER TABLE `quizresults`
  ADD PRIMARY KEY (`ResultID`),
  ADD KEY `QuizID` (`QuizID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`QuizID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `recommendedcourses`
--
ALTER TABLE `recommendedcourses`
  ADD PRIMARY KEY (`RecommendationID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `registeredcourses`
--
ALTER TABLE `registeredcourses`
  ADD PRIMARY KEY (`UserID`,`CourseID`),
  ADD UNIQUE KEY `regCoursesID` (`regCoursesID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`RegistrationNumber`);

--
-- Indexes for table `studentquizresults`
--
ALTER TABLE `studentquizresults`
  ADD PRIMARY KEY (`StudentQuizID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `QuizID` (`QuizID`);

--
-- Indexes for table `student_assignments`
--
ALTER TABLE `student_assignments`
  ADD PRIMARY KEY (`student_assignment_id`),
  ADD KEY `assignment_id` (`assignment_id`);

--
-- Indexes for table `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`topic_id`);

--
-- Indexes for table `topic_material`
--
ALTER TABLE `topic_material`
  ADD PRIMARY KEY (`topic_id`,`material_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indexes for table `uploadedmaterials`
--
ALTER TABLE `uploadedmaterials`
  ADD PRIMARY KEY (`MaterialID`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `UploadedBy` (`UploadedBy`);

--
-- Indexes for table `userjwt`
--
ALTER TABLE `userjwt`
  ADD PRIMARY KEY (`JWTID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `RegitratonNumber` (`RegistrationNumber`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `assignment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `CertificateID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courseparts`
--
ALTER TABLE `courseparts`
  MODIFY `PartID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `CourseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `domains`
--
ALTER TABLE `domains`
  MODIFY `DomainID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `material`
--
ALTER TABLE `material`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `quizresults`
--
ALTER TABLE `quizresults`
  MODIFY `ResultID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `QuizID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recommendedcourses`
--
ALTER TABLE `recommendedcourses`
  MODIFY `RecommendationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registeredcourses`
--
ALTER TABLE `registeredcourses`
  MODIFY `regCoursesID` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `studentquizresults`
--
ALTER TABLE `studentquizresults`
  MODIFY `StudentQuizID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_assignments`
--
ALTER TABLE `student_assignments`
  MODIFY `student_assignment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `uploadedmaterials`
--
ALTER TABLE `uploadedmaterials`
  MODIFY `MaterialID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userjwt`
--
ALTER TABLE `userjwt`
  MODIFY `JWTID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `assignments_ibfk_3` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`),
  ADD CONSTRAINT `assignments_ibfk_4` FOREIGN KEY (`faculty_id`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `certificates_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`);

--
-- Constraints for table `courseparts`
--
ALTER TABLE `courseparts`
  ADD CONSTRAINT `courseparts_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `FK_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`UserID`) ON DELETE SET NULL,
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `course_material`
--
ALTER TABLE `course_material`
  ADD CONSTRAINT `course_material_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`CourseID`),
  ADD CONSTRAINT `course_material_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `material` (`material_id`);

--
-- Constraints for table `course_topic`
--
ALTER TABLE `course_topic`
  ADD CONSTRAINT `course_topic_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`CourseID`),
  ADD CONSTRAINT `course_topic_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`topic_id`);

--
-- Constraints for table `domains`
--
ALTER TABLE `domains`
  ADD CONSTRAINT `domains_ibfk_1` FOREIGN KEY (`ProgramCode`) REFERENCES `programs` (`ProgramCode`);

--
-- Constraints for table `quizresults`
--
ALTER TABLE `quizresults`
  ADD CONSTRAINT `quizresults_ibfk_1` FOREIGN KEY (`QuizID`) REFERENCES `quizzes` (`QuizID`),
  ADD CONSTRAINT `quizresults_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`);

--
-- Constraints for table `recommendedcourses`
--
ALTER TABLE `recommendedcourses`
  ADD CONSTRAINT `recommendedcourses_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `recommendedcourses_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`);

--
-- Constraints for table `registeredcourses`
--
ALTER TABLE `registeredcourses`
  ADD CONSTRAINT `registeredcourses_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `registeredcourses_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`);

--
-- Constraints for table `studentquizresults`
--
ALTER TABLE `studentquizresults`
  ADD CONSTRAINT `studentquizresults_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `studentquizresults_ibfk_2` FOREIGN KEY (`QuizID`) REFERENCES `quizzes` (`QuizID`);

--
-- Constraints for table `student_assignments`
--
ALTER TABLE `student_assignments`
  ADD CONSTRAINT `student_assignments_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`assignment_id`);

--
-- Constraints for table `topic_material`
--
ALTER TABLE `topic_material`
  ADD CONSTRAINT `topic_material_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`topic_id`),
  ADD CONSTRAINT `topic_material_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `material` (`material_id`);

--
-- Constraints for table `uploadedmaterials`
--
ALTER TABLE `uploadedmaterials`
  ADD CONSTRAINT `uploadedmaterials_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`),
  ADD CONSTRAINT `uploadedmaterials_ibfk_2` FOREIGN KEY (`UploadedBy`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `userjwt`
--
ALTER TABLE `userjwt`
  ADD CONSTRAINT `userjwt_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
