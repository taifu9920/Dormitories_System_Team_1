CREATE DATABASE  IF NOT EXISTS `dormitories_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dormitories_system`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dormitories_system
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `C_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `S_ID` varchar(10) NOT NULL,
  `Content` varchar(300) NOT NULL,
  `When` datetime NOT NULL,
  PRIMARY KEY (`C_ID`),
  UNIQUE KEY `C_ID_UNIQUE` (`C_ID`),
  KEY `S_ID_idx` (`S_ID`),
  CONSTRAINT `S_ID` FOREIGN KEY (`S_ID`) REFERENCES `students` (`S_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configs`
--

DROP TABLE IF EXISTS `configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configs` (
  `SC_Tag` varchar(30) NOT NULL,
  `Value` varchar(500) NOT NULL,
  PRIMARY KEY (`SC_Tag`),
  UNIQUE KEY `SC_Tag_UNIQUE` (`SC_Tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configs`
--

LOCK TABLES `configs` WRITE;
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` VALUES ('Announcement','Content'),('owner_account','admin'),('owner_password','12345');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dormitories`
--

DROP TABLE IF EXISTS `dormitories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dormitories` (
  `D_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`D_ID`),
  UNIQUE KEY `D_ID_UNIQUE` (`D_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dormitories`
--

LOCK TABLES `dormitories` WRITE;
/*!40000 ALTER TABLE `dormitories` DISABLE KEYS */;
/*!40000 ALTER TABLE `dormitories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `M_ID` varchar(10) NOT NULL,
  `Name` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`M_ID`),
  UNIQUE KEY `M_ID_UNIQUE` (`M_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES (' ',' ','a@a.a',' ',' '),('M1234567','黃舍監','test@mail.nuk.edu.tw','0902345678','aaa123');
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `MR_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `M_ID` varchar(10) NOT NULL,
  `D_ID` int unsigned NOT NULL,
  PRIMARY KEY (`MR_ID`),
  UNIQUE KEY `R_ID_UNIQUE` (`MR_ID`),
  KEY `M_ID_idx` (`M_ID`),
  KEY `D_ID_idx` (`D_ID`),
  CONSTRAINT `D_ID2` FOREIGN KEY (`D_ID`) REFERENCES `dormitories` (`D_ID`),
  CONSTRAINT `M_ID` FOREIGN KEY (`M_ID`) REFERENCES `managers` (`M_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registers`
--

DROP TABLE IF EXISTS `registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registers` (
  `Reg_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `S_ID` varchar(10) NOT NULL,
  `Year` int unsigned NOT NULL,
  `Term` int unsigned NOT NULL,
  `When` datetime NOT NULL,
  `Approved` int unsigned NOT NULL,
  `Payment` int unsigned NOT NULL,
  PRIMARY KEY (`Reg_ID`),
  KEY `S_ID_idx` (`S_ID`),
  CONSTRAINT `S_ID2` FOREIGN KEY (`S_ID`) REFERENCES `students` (`S_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registers`
--

LOCK TABLES `registers` WRITE;
/*!40000 ALTER TABLE `registers` DISABLE KEYS */;
/*!40000 ALTER TABLE `registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_contents`
--

DROP TABLE IF EXISTS `room_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_contents` (
  `RC_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `R_ID` int unsigned NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Amount` int unsigned NOT NULL,
  PRIMARY KEY (`RC_ID`),
  UNIQUE KEY `RC_ID_UNIQUE` (`RC_ID`),
  KEY `R_ID_idx` (`R_ID`),
  CONSTRAINT `R_ID2` FOREIGN KEY (`R_ID`) REFERENCES `rooms` (`R_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_contents`
--

LOCK TABLES `room_contents` WRITE;
/*!40000 ALTER TABLE `room_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `R_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `D_ID` int unsigned NOT NULL,
  `Peoples` int unsigned NOT NULL,
  `Costs` int unsigned NOT NULL,
  PRIMARY KEY (`R_ID`),
  UNIQUE KEY `R_ID_UNIQUE` (`R_ID`),
  KEY `D_ID_idx` (`D_ID`),
  CONSTRAINT `D_ID` FOREIGN KEY (`D_ID`) REFERENCES `dormitories` (`D_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `S_ID` varchar(10) NOT NULL,
  `Name` varchar(48) NOT NULL,
  `Year` int unsigned NOT NULL,
  `Dept_Name` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Sex` tinyint unsigned NOT NULL,
  `R_ID` int unsigned DEFAULT NULL COMMENT 'RoomID',
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`S_ID`),
  UNIQUE KEY `S_ID_UNIQUE` (`S_ID`),
  KEY `R_ID_idx` (`R_ID`),
  CONSTRAINT `R_ID` FOREIGN KEY (`R_ID`) REFERENCES `rooms` (`R_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES ('A1095512','林敬寶',109,'資訊工程系','a1095512@mail.nuk.edu.tw','0908850282',0,NULL,'a1095512');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `violation_records`
--

DROP TABLE IF EXISTS `violation_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `violation_records` (
  `V_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `S_ID` varchar(10) NOT NULL,
  `Content` varchar(300) NOT NULL,
  `When` datetime NOT NULL,
  PRIMARY KEY (`V_ID`),
  UNIQUE KEY `V_ID_UNIQUE` (`V_ID`),
  KEY `S_ID_idx` (`S_ID`),
  CONSTRAINT `S_ID3` FOREIGN KEY (`S_ID`) REFERENCES `students` (`S_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `violation_records`
--

LOCK TABLES `violation_records` WRITE;
/*!40000 ALTER TABLE `violation_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `violation_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-25  0:23:20
