CREATE DATABASE  IF NOT EXISTS `Team24_smartview` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `Team24_smartview`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: Team24_smartview
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidents` (
  `incident_id` int NOT NULL,
  `incident_description` varchar(250) DEFAULT NULL,
  `incident_type` varchar(50) NOT NULL,
  `cam_id` int NOT NULL,
  `incident_time` datetime NOT NULL,
  `incident_media` blob,
  `assignee` varchar(100) NOT NULL,
  `priority_level` varchar(45) NOT NULL,
  `incident_status` varchar(45) NOT NULL,
  `officer_notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  KEY `username_idx` (`assignee`),
  KEY `cam_idx` (`cam_id`),
  CONSTRAINT `cam` FOREIGN KEY (`cam_id`) REFERENCES `cctv` (`cctv_id`),
  CONSTRAINT `username` FOREIGN KEY (`assignee`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents`
--

LOCK TABLES `incidents` WRITE;
/*!40000 ALTER TABLE `incidents` DISABLE KEYS */;
INSERT INTO `incidents` VALUES (1,'Fighting detected between two men','Fight',1,'2022-12-31 11:11:11',NULL,'kbpoh98','medium','ongoing',''),(2,'Illegal Parking (SJK 2042P Silver Car)','Congestion',3,'2022-12-29 11:11:11',NULL,'kbpoh98','high','completed',''),(3,'2 men in black detected loitering','Loitering',2,'2022-12-28 11:11:11',NULL,'kbpoh98','low','ongoing',''),(4,'Fire detected','Fire',4,'2023-01-17 08:09:23',NULL,'kbpoh98','high','ongoing','');
/*!40000 ALTER TABLE `incidents` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-23 18:06:09
