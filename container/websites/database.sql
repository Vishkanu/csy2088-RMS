-- MariaDB dump 10.19  Distrib 10.5.19-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: csy2089
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-22 12:15:56
