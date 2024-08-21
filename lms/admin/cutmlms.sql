-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2024 at 04:00 PM
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
  `CourseType` enum('BTech','BSc') NOT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `SyllabusLink` varchar(255) DEFAULT NULL,
  `TotalCredits` int(11) NOT NULL,
  `CreditDistribution` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`CourseID`, `CourseName`, `CourseType`, `CreatedBy`, `SyllabusLink`, `TotalCredits`, `CreditDistribution`) VALUES
(1, 'Introduction to Computer Science', 'BTech', 1, 'http://example.com/syllabus/cs101.pdf', 3, '2-1-0'),
(2, 'Advanced Mathematics', 'BTech', NULL, 'http://example.com/syllabus/am102.pdf', 4, '3-1-0'),
(3, 'Physics I', 'BTech', NULL, 'http://example.com/syllabus/phy103.pdf', 4, '3-0-1'),
(4, 'Introduction to Biology', 'BSc', 4, 'http://example.com/syllabus/bio104.pdf', 3, '2-1-0'),
(5, 'Organic Chemistry', 'BSc', 5, 'http://example.com/syllabus/chem105.pdf', 4, '3-1-0'),
(6, 'Data Structures', 'BTech', 1, 'http://example.com/syllabus/cs201.pdf', 3, '2-1-0'),
(7, 'Electromagnetism', 'BTech', NULL, 'http://example.com/syllabus/phy202.pdf', 4, '3-0-1'),
(8, 'Genetics', 'BSc', 4, 'http://example.com/syllabus/bio204.pdf', 3, '2-1-0'),
(9, 'Biochemistry', 'BSc', 5, 'http://example.com/syllabus/chem206.pdf', 4, '3-1-0'),
(10, 'Algorithms', 'BTech', 1, 'http://example.com/syllabus/cs301.pdf', 3, '2-1-0');

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
  `UserID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `fromdate` date NOT NULL,
  `todate` date NOT NULL,
  `status` enum('Passed','Failed','ongoing','withdrawn') NOT NULL,
  `createdon` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` enum('faculty','student','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `student_id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `submission_date` datetime DEFAULT NULL,
  `grade` decimal(5,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `submission_path` varchar(225) NOT NULL,
  `submissionon` datetime NOT NULL DEFAULT current_timestamp()
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
  `PasswordHash` varchar(255) NOT NULL,
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
(1, 'Henry Williams', 'henrrywilliams123@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', '45 st r coload ', 'student', 'S789845', NULL, '8.jpeg'),
(4, 'Diane Wright', 'diane.wright@example.com', '5ebe2294ecd0e0f08eab7690d2a6ee69', '321 Birch Lane, Springfield', 'admin', NULL, NULL, '1.png'),
(5, 'Edward Davis', 'edward.davis@example.com', '7c6a180b36896a0a8c02787eeafb0e4c', '654 Cedar Street, Springfield', 'faculty', NULL, 'F124', '6.png'),
(7, 'George King', 'george.king@example.com', '25f9e794323b453885f5181f1b624d0b', '147 Walnut Avenue, Springfield', 'faculty', NULL, 'F125', '7.png'),
(8, 'Hannah Scott', 'hannah.scott@example.com', '098f6bcd4621d373cade4e832627b4f6', '369 Aspen Drive, Springfield', 'student', 'S12348', NULL, '6.png'),
(9, 'Ian Walker', 'ian.walker@example.com', '5d41402abc4b2a76b9719d911017c592', '258 Cherry Lane, Springfield', 'admin', NULL, NULL, '6.png'),
(10, 'Jane Moore', 'jane.moore@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', '753 Fir Street, Springfield', 'faculty', NULL, 'F126', '5.png'),
(22, 'Tony Stark', 'tony@gmail.com', 'jhon@123', 'Marvel', 'student', 'S951753', NULL, 'student_7.png'),
(23, 'Natasha', 'Natasha@gmail.com', '2134568796', 'Marveick', 'faculty', NULL, 'F3579516842', 'faculty_4.png'),
(24, 'SuperAdmin', 'superr@gmail.com', '27468416387', 'Sabbavaram', 'admin', NULL, NULL, 'admin_5.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD KEY `CourseID` (`CourseID`);

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
  ADD KEY `CreatedBy` (`CreatedBy`);

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
  ADD KEY `CourseID` (`CourseID`);

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
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `assignment_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `CourseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- AUTO_INCREMENT for table `studentquizresults`
--
ALTER TABLE `studentquizresults`
  MODIFY `StudentQuizID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_assignments`
--
ALTER TABLE `student_assignments`
  MODIFY `student_assignment_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `assignments_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`);

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
