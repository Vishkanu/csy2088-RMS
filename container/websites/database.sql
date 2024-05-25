-- MariaDB dump 10.19  Distrib 10.5.19-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: csy2088_as1
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB-1:11.2.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `csy2088_as1`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `csy2088_as1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `csy2088_as1`;

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignments` (
  `assignment_id` int(8) NOT NULL AUTO_INCREMENT,
  `assignment_name` varchar(255) DEFAULT NULL,
  `assignment_module` char(5) DEFAULT NULL,
  PRIMARY KEY (`assignment_id`),
  KEY `fk_ass_modules` (`assignment_module`),
  CONSTRAINT `fk_ass_modules` FOREIGN KEY (`assignment_module`) REFERENCES `modules` (`module_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40000003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
INSERT INTO `assignments` VALUES (40000001,'AS1 - Intro Project','C1001'),(40000002,'AS2 - Second Project','C1001');
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`student`@`%`*/ /*!50003 TRIGGER tr_assignment_grades
AFTER INSERT ON assignments
FOR EACH ROW
	INSERT INTO grades (assignment_id, student_id)
	SELECT NEW.assignment_id, student_id FROM students
	WHERE student_course = (SELECT course_id FROM course_modules WHERE module_id = NEW.assignment_module) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `attendance_id` int(8) NOT NULL AUTO_INCREMENT,
  `student_id` int(8) DEFAULT NULL,
  `lecture_id` int(8) DEFAULT NULL,
  `attendance_value` char(1) DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  UNIQUE KEY `student_id` (`student_id`,`lecture_id`),
  KEY `fk_att_lectures` (`lecture_id`),
  CONSTRAINT `fk_att_lectures` FOREIGN KEY (`lecture_id`) REFERENCES `lectures` (`lecture_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_att_students` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30000028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (30000000,22400001,10000001,NULL),(30000001,22400002,10000001,NULL),(30000002,22400003,10000001,NULL),(30000003,22400004,10000001,NULL),(30000004,22400005,10000001,NULL),(30000007,22400001,10000002,NULL),(30000008,22400002,10000002,NULL),(30000009,22400003,10000002,NULL),(30000010,22400004,10000002,NULL),(30000011,22400005,10000002,NULL),(30000014,22400001,10000003,NULL),(30000015,22400002,10000003,NULL),(30000016,22400003,10000003,NULL),(30000017,22400004,10000003,NULL),(30000018,22400005,10000003,NULL),(30000021,22400001,10000004,NULL),(30000022,22400002,10000004,NULL),(30000023,22400003,10000004,NULL),(30000024,22400004,10000004,NULL),(30000025,22400005,10000004,NULL);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boundaries`
--

DROP TABLE IF EXISTS `boundaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boundaries` (
  `boundaries_id` varchar(2) NOT NULL,
  `boundaries_range` varchar(6) NOT NULL,
  `boundaries_class` varchar(10) NOT NULL,
  PRIMARY KEY (`boundaries_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boundaries`
--

LOCK TABLES `boundaries` WRITE;
/*!40000 ALTER TABLE `boundaries` DISABLE KEYS */;
/*!40000 ALTER TABLE `boundaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_modules`
--

DROP TABLE IF EXISTS `course_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_modules` (
  `course_id` int(8) NOT NULL,
  `module_id` char(5) NOT NULL,
  PRIMARY KEY (`course_id`,`module_id`),
  KEY `fk_cm_modules` (`module_id`),
  CONSTRAINT `fk_cm_courses` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cm_modules` FOREIGN KEY (`module_id`) REFERENCES `modules` (`module_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_modules`
--

LOCK TABLES `course_modules` WRITE;
/*!40000 ALTER TABLE `course_modules` DISABLE KEYS */;
INSERT INTO `course_modules` VALUES (70000001,'C1001'),(70000001,'C1002'),(70000002,'C1003'),(70000001,'C2001'),(70000001,'C2002'),(70000001,'C3001'),(70000001,'C3002');
/*!40000 ALTER TABLE `course_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `course_id` int(8) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70000006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (70000001,'Computer Science'),(70000002,'Software Engineering'),(70000003,'Medicine'),(70000004,'Art'),(70000005,'English Language Studies');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diaries`
--

DROP TABLE IF EXISTS `diaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diaries` (
  `diary_id` int(8) NOT NULL AUTO_INCREMENT,
  `diary_author` int(8) DEFAULT NULL,
  `diary_date` datetime DEFAULT current_timestamp(),
  `diary_content` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`diary_id`),
  KEY `fk_di_staff` (`diary_author`),
  CONSTRAINT `fk_di_staff` FOREIGN KEY (`diary_author`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60000004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diaries`
--

LOCK TABLES `diaries` WRITE;
/*!40000 ALTER TABLE `diaries` DISABLE KEYS */;
INSERT INTO `diaries` VALUES (60000001,99100000,'2024-05-20 16:17:58','This is a diary entry'),(60000002,99100000,'2024-05-20 16:17:58','This is another diary entry'),(60000003,99100000,'2024-05-20 16:17:58','This is yet another diary entry');
/*!40000 ALTER TABLE `diaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades` (
  `grade_id` int(8) NOT NULL AUTO_INCREMENT,
  `assignment_id` int(8) DEFAULT NULL,
  `student_id` int(8) DEFAULT NULL,
  `grade_value` char(3) DEFAULT NULL,
  PRIMARY KEY (`grade_id`),
  KEY `fk_gr_assignments` (`assignment_id`),
  KEY `fk_gr_students` (`student_id`),
  CONSTRAINT `fk_gr_assignments` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`assignment_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_gr_students` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50000014 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (50000000,40000001,22400001,NULL),(50000001,40000001,22400002,NULL),(50000002,40000001,22400003,NULL),(50000003,40000001,22400004,NULL),(50000004,40000001,22400005,NULL),(50000007,40000002,22400001,NULL),(50000008,40000002,22400002,NULL),(50000009,40000002,22400003,NULL),(50000010,40000002,22400004,NULL),(50000011,40000002,22400005,NULL);
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lectures`
--

DROP TABLE IF EXISTS `lectures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures` (
  `lecture_id` int(8) NOT NULL AUTO_INCREMENT,
  `module_id` char(5) DEFAULT NULL,
  `module_week` int(2) DEFAULT NULL,
  `lecture_room` varchar(4) DEFAULT NULL,
  `lecture_datetime` datetime DEFAULT NULL,
  `lecture_duration` int(4) DEFAULT NULL,
  PRIMARY KEY (`lecture_id`),
  UNIQUE KEY `lecture_room` (`lecture_room`,`lecture_datetime`),
  KEY `fk_lec_modules` (`module_id`),
  CONSTRAINT `fk_lec_modules` FOREIGN KEY (`module_id`) REFERENCES `modules` (`module_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lec_rooms` FOREIGN KEY (`lecture_room`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10000005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lectures`
--

LOCK TABLES `lectures` WRITE;
/*!40000 ALTER TABLE `lectures` DISABLE KEYS */;
INSERT INTO `lectures` VALUES (10000001,'C1001',1,'C1','2024-05-08 10:00:00',180),(10000002,'C1002',1,'C2','2024-05-08 13:30:00',180),(10000003,'C2001',1,'C3','2024-05-08 10:00:00',180),(10000004,'C2002',1,'C3','2024-05-08 13:30:00',180);
/*!40000 ALTER TABLE `lectures` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`student`@`%`*/ /*!50003 TRIGGER tr_attendance_students
AFTER INSERT ON lectures
FOR EACH ROW
	INSERT INTO attendance (student_id, lecture_id)
	SELECT student_id, NEW.lecture_id FROM students
	WHERE student_course = (SELECT course_id FROM course_modules WHERE module_id = NEW.module_id) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `module_id` char(5) NOT NULL,
  `module_year` int(1) NOT NULL,
  `module_points` int(2) NOT NULL,
  `module_title` varchar(255) NOT NULL,
  `module_as1` int(3) DEFAULT NULL,
  `module_as2` int(3) DEFAULT NULL,
  `module_exam` int(3) DEFAULT NULL,
  `module_leader` int(8) DEFAULT NULL,
  PRIMARY KEY (`module_id`),
  KEY `fk_mod_staff` (`module_leader`),
  CONSTRAINT `fk_mod_staff` FOREIGN KEY (`module_leader`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES ('C1001',1,20,'Fundamentals of Computer Science',50,50,NULL,99100000),('C1002',1,20,'Fundamentals of Computer Science - Continued',50,NULL,50,99100000),('C1003',1,20,'Software Engineering Fundamentals',50,NULL,50,99100000),('C2001',1,20,'Bleeps and Bloops - An Introduction',NULL,50,50,99100000),('C2002',1,20,'Advanced Bleeps and Bloops',50,NULL,50,99100000),('C3001',1,20,'Internet of Things',NULL,NULL,100,99100000),('C3002',1,20,'Buzzword Engineering',NULL,NULL,100,99100000);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `room_id` varchar(4) NOT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  `room_capacity` int(3) DEFAULT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES ('C1','Computer Lab',30),('C2','Computer Lab',30),('C3','Computer Lab',30);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `staff_id` int(8) NOT NULL AUTO_INCREMENT,
  `staff_forename` varchar(255) DEFAULT NULL,
  `staff_middle_names` varchar(255) DEFAULT NULL,
  `staff_surname` varchar(255) DEFAULT NULL,
  `staff_role_cl` tinyint(1) DEFAULT NULL,
  `staff_role_ml` tinyint(1) DEFAULT NULL,
  `staff_role_pt` tinyint(1) DEFAULT NULL,
  `staff_address` varchar(255) DEFAULT NULL,
  `staff_telephone` varchar(255) DEFAULT NULL,
  `staff_email` varchar(255) DEFAULT NULL,
  `staff_password` varchar(255) DEFAULT NULL,
  `staff_status` char(1) DEFAULT 'L',
  `staff_status_reason` varchar(255) DEFAULT NULL,
  `staff_specialism` varchar(255) DEFAULT NULL,
  `staff_lastlogged` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `staff_email` (`staff_email`)
) ENGINE=InnoDB AUTO_INCREMENT=99100001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (99100000,'JOHN',NULL,'SMITH',NULL,NULL,1,'64 ZOO LANE',NULL,'JOHN@SMITH.COM','$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu','L',NULL,NULL,'2024-05-25 16:45:03');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `student_id` int(8) NOT NULL AUTO_INCREMENT,
  `student_forename` varchar(255) DEFAULT NULL,
  `student_middle_names` varchar(255) DEFAULT NULL,
  `student_surname` varchar(255) DEFAULT NULL,
  `student_term_address` varchar(255) DEFAULT NULL,
  `student_nonterm_address` varchar(255) DEFAULT NULL,
  `student_telephone` varchar(255) DEFAULT NULL,
  `student_email` varchar(255) DEFAULT NULL,
  `student_password` varchar(255) DEFAULT NULL,
  `student_status` char(1) DEFAULT 'L',
  `student_status_reason` varchar(255) DEFAULT NULL,
  `student_course` int(8) DEFAULT NULL,
  `student_entry_qualifications` varchar(255) DEFAULT NULL,
  `student_personal_tutor` int(8) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `fk_stu_courses` (`student_course`),
  KEY `fk_stu_staff` (`student_personal_tutor`),
  CONSTRAINT `fk_stu_courses` FOREIGN KEY (`student_course`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_stu_staff` FOREIGN KEY (`student_personal_tutor`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22400006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (22400000,'FOO',NULL,'BAR',NULL,NULL,NULL,'FOO@BAR.COM',NULL,'L',NULL,NULL,NULL,NULL),(22400001,'John','Long','Doe','89 Grange Park','90 Park Lane','07567901245','johndoe@gmail.com','$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu','L',NULL,70000001,'A A B',99100000),(22400002,'John','Long','Doe','89 Grange Park','90 Park Lane','07567901245','johndoe@gmail.com','$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu','L',NULL,70000001,'A A B',99100000),(22400003,'John','Long','Doe','89 Grange Park','90 Park Lane','07567901245','johndoe@gmail.com','$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu','L',NULL,70000001,'A A B',99100000),(22400004,'John','Long','Doe','89 Grange Park','90 Park Lane','07567901245','johndoe@gmail.com','$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu','L',NULL,70000001,'A A B',99100000),(22400005,'John','Long','Doe','89 Grange Park','90 Park Lane','07567901245','johndoe@gmail.com','$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu','L',NULL,70000001,'A A B',99100000);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'csy2088_as1'
--

--
-- Current Database: `ijdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ijdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `ijdb`;

--
-- Table structure for table `joke`
--

DROP TABLE IF EXISTS `joke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `joke` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `joketext` text DEFAULT NULL,
  `jokedate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `joke`
--

LOCK TABLES `joke` WRITE;
/*!40000 ALTER TABLE `joke` DISABLE KEYS */;
INSERT INTO `joke` VALUES (1,'A programmer was found dead in the shower. The instructions read: lather, rinse, repeat.','2023-12-04'),(2,'!false - it\'s funny because it\'s true','2023-01-08'),(3,'Why did the programmer quit his job? He didn\'t get arrays','2023-01-08'),(4,'A man walked into a bar. Ow.','2023-12-05');
/*!40000 ALTER TABLE `joke` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ijdb'
--

--
-- Current Database: `csy2089`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `csy2089` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `csy2089`;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `admin_id` int(5) NOT NULL AUTO_INCREMENT,
  `admin_username` varchar(30) NOT NULL,
  `admin_password` varchar(100) NOT NULL,
  `admin_name` varchar(50) NOT NULL,
  `admin_email` varchar(75) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_username` (`admin_username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'jroot123','$2y$10$sMXUMymB5Aj8UEfs78AZCOywnsIP3uyyDJbwrbzbmxZLdirh7JEwS','John Root','jroot123@example.com'),(2,'sjones456','$2y$10$mXnjLzMr8guLw.XuiBL2YOLyocn/l47nGoDSDQQHCnCUQvtEqYaFy','Sudo Jones','sjones456@example.com');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(5) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (3,'Computers'),(5,'Gaming'),(1,'None'),(4,'Phones'),(2,'TVs');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_questions`
--

DROP TABLE IF EXISTS `customer_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_questions` (
  `question_id` int(5) NOT NULL AUTO_INCREMENT,
  `product_id` int(5) NOT NULL,
  `customer_id` int(5) NOT NULL,
  `question` varchar(300) NOT NULL,
  `question_date` date DEFAULT curdate(),
  `answer` varchar(300) DEFAULT NULL,
  `answered_by` int(5) DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  UNIQUE KEY `cq_unique_pid_question` (`product_id`,`question`),
  KEY `fk_cq_admins` (`answered_by`),
  KEY `fk_cq_customers` (`customer_id`),
  CONSTRAINT `fk_cq_admins` FOREIGN KEY (`answered_by`) REFERENCES `admins` (`admin_id`),
  CONSTRAINT `fk_cq_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_cq_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `ck_answered` CHECK (`answer` is not null and `answered_by` is not null or `answer` is null and `answered_by` is null)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_questions`
--

LOCK TABLES `customer_questions` WRITE;
/*!40000 ALTER TABLE `customer_questions` DISABLE KEYS */;
INSERT INTO `customer_questions` VALUES (1,2,1,'Is water wet?','2024-01-28',NULL,NULL),(2,2,2,'Is Joe blogging?','2024-01-28',NULL,NULL),(3,2,3,'Is my question answered?','2024-01-28','Yes, yes it is.',1);
/*!40000 ALTER TABLE `customer_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customer_id` int(5) NOT NULL AUTO_INCREMENT,
  `customer_username` varchar(30) NOT NULL,
  `customer_password` varchar(100) NOT NULL,
  `customer_name` varchar(50) NOT NULL,
  `customer_email` varchar(75) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_username` (`customer_username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'jsmith123','$2y$10$sMXUMymB5Aj8UEfs78AZCOywnsIP3uyyDJbwrbzbmxZLdirh7JEwS','John Smith','jsmith123@example.com'),(2,'jbloggs456','$2y$10$sMXUMymB5Aj8UEfs78AZCOywnsIP3uyyDJbwrbzbmxZLdirh7JEwS','Joe Bloggs','jbloggs123@example.com'),(3,'andy_mca','$2y$10$sMXUMymB5Aj8UEfs78AZCOywnsIP3uyyDJbwrbzbmxZLdirh7JEwS','Andy McAnswered','andy_mca@example.com');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `product_id` int(5) NOT NULL AUTO_INCREMENT,
  `category` int(5) DEFAULT 1,
  `name` varchar(50) NOT NULL,
  `description` varchar(300) NOT NULL,
  `manufacturer` varchar(50) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `date_added` date DEFAULT curdate(),
  `photo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `name` (`name`),
  KEY `fk_p_categories` (`category`),
  CONSTRAINT `fk_p_categories` FOREIGN KEY (`category`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,2,'TeeVee Budget','A budget range television from TeeVee!','TeeVee',111.11,'2024-01-28',NULL),(2,2,'TeeVee Midrange','A mid-range television from TeeVee!','TeeVee',222.22,'2024-01-28','/uploads/png-smiling-face-smiley-png-3896.png'),(3,3,'Komputilo 13','13-inch laptop from award winning manufacturer Espera Tekniko!','Espera Tekniko',333.33,'2024-01-28',NULL),(4,3,'Komputilo 15','15-inch laptop from award winning manufacturer Espera Tekniko!','Espera Tekniko',444.44,'2024-01-28',NULL),(5,4,'PiPhone 10','The previous model PiPhone.','Pineapple',555.55,'2024-01-28',NULL),(6,4,'PiPhone 11','The latest model PiPhone. Has no new features compared to the previous model, yet somehow costs more...','Pineapple',666.66,'2024-01-28',NULL),(7,5,'Kolibri','A wartime mystery game where you play as famous detective and watchmaker John Kolibri','Irish Wristwatch Studios',77.77,'2024-01-28',NULL),(8,5,'RTX GTX MLG RNG 450Ti','Hey gamers!!!! Would you like the latest GPU from Nvoodya? Well too bad, the scalpers probably bought them all.','Nvoodya',888.88,'2024-01-28',NULL),(9,2,'TeleVisio 1','The first television made by TeleVisio','TeleVisio',123.45,'2024-01-23',NULL),(10,2,'TeleVisio 2','The second television made by TeleVisio','TeleVisio',123.45,'2024-01-22',NULL),(11,2,'TeleVisio 3','The third television made by TeleVisio','TeleVisio',123.45,'2024-01-21',NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unapproved_questions`
--

DROP TABLE IF EXISTS `unapproved_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unapproved_questions` (
  `question_id` int(5) NOT NULL AUTO_INCREMENT,
  `product_id` int(5) NOT NULL,
  `customer_id` int(5) NOT NULL,
  `question` varchar(300) NOT NULL,
  `question_date` date DEFAULT curdate(),
  PRIMARY KEY (`question_id`),
  UNIQUE KEY `uq_unique_pid_question` (`product_id`,`question`),
  KEY `fk_uq_customers` (`customer_id`),
  CONSTRAINT `fk_uq_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_uq_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unapproved_questions`
--

LOCK TABLES `unapproved_questions` WRITE;
/*!40000 ALTER TABLE `unapproved_questions` DISABLE KEYS */;
INSERT INTO `unapproved_questions` VALUES (1,2,1,'Is water dry?','2024-01-28'),(2,2,1,'How low can you go?','2024-01-28');
/*!40000 ALTER TABLE `unapproved_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'csy2089'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-25 16:11:43
