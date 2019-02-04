CREATE DATABASE  IF NOT EXISTS `pos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `pos`;
-- MySQL dump 10.13  Distrib 8.0.14, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pos
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adresa`
--

DROP TABLE IF EXISTS `adresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `adresa` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID pravnog lica` int(10) unsigned NOT NULL,
  `Postanski broj` varchar(6) NOT NULL,
  `Grad` varchar(45) NOT NULL,
  `Ulica` varchar(45) NOT NULL,
  `Broj` varchar(5) NOT NULL,
  `Potpuna adresa` varchar(110) GENERATED ALWAYS AS (concat(`Postanski broj`,_utf8mb4' ',`Grad`,_utf8mb4', ',`Ulica`,_utf8mb4' ',`Broj`)) VIRTUAL,
  PRIMARY KEY (`ID`),
  KEY `Pravno lice FK_idx` (`ID pravnog lica`),
  CONSTRAINT `Pravno lice FK` FOREIGN KEY (`ID pravnog lica`) REFERENCES `lice` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adresa`
--

LOCK TABLES `adresa` WRITE;
/*!40000 ALTER TABLE `adresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `adresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artikal`
--

DROP TABLE IF EXISTS `artikal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `artikal` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(45) NOT NULL,
  `Lager` double unsigned NOT NULL,
  `Merna jedinica` varchar(10) NOT NULL DEFAULT 'kom',
  `Ulazna cena` double unsigned NOT NULL,
  `Marza procenat` int(10) unsigned NOT NULL,
  `Cena sa marzom` double GENERATED ALWAYS AS ((`Ulazna cena` + (`Ulazna cena` * (`Marza procenat` / 100)))) STORED,
  `Porez procenat` int(10) unsigned NOT NULL,
  `Izlazna cena` double GENERATED ALWAYS AS ((`Cena sa marzom` + (`Cena sa marzom` * (`Porez procenat` / 100)))) STORED,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Naziv_UNIQUE` (`Naziv`),
  KEY `Merna jedinica_idx` (`Merna jedinica`),
  CONSTRAINT `Merna jedinica` FOREIGN KEY (`Merna jedinica`) REFERENCES `jedinice` (`naziv jedinice`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artikal`
--

LOCK TABLES `artikal` WRITE;
/*!40000 ALTER TABLE `artikal` DISABLE KEYS */;
INSERT INTO `artikal` (`ID`, `Naziv`, `Lager`, `Merna jedinica`, `Ulazna cena`, `Marza procenat`, `Porez procenat`) VALUES (2,'Plazam',100,'kom',100,25,10),(3,'Pljuge',20,'kom',250,10,17),(4,'Kafa',500,'g',20,35,20);
/*!40000 ALTER TABLE `artikal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jedinice`
--

DROP TABLE IF EXISTS `jedinice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `jedinice` (
  `Naziv jedinice` varchar(10) NOT NULL,
  PRIMARY KEY (`Naziv jedinice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jedinice`
--

LOCK TABLES `jedinice` WRITE;
/*!40000 ALTER TABLE `jedinice` DISABLE KEYS */;
INSERT INTO `jedinice` VALUES ('g'),('Kg'),('kom'),('l');
/*!40000 ALTER TABLE `jedinice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lice`
--

DROP TABLE IF EXISTS `lice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lice` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `JIB` varchar(12) NOT NULL,
  `PIB` varchar(11) NOT NULL,
  `Naziv` varchar(45) DEFAULT NULL,
  `Tel` varchar(45) DEFAULT NULL,
  `Fax` varchar(45) DEFAULT NULL,
  `e-mail` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JIB_UNIQUE` (`JIB`),
  UNIQUE KEY `PIB_UNIQUE` (`PIB`),
  UNIQUE KEY `Naziv_UNIQUE` (`Naziv`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lice`
--

LOCK TABLES `lice` WRITE;
/*!40000 ALTER TABLE `lice` DISABLE KEYS */;
/*!40000 ALTER TABLE `lice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racun`
--

DROP TABLE IF EXISTS `racun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `racun` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Datum izdavanja` datetime NOT NULL,
  `Datum valute` datetime DEFAULT NULL,
  `Lice` int(10) unsigned DEFAULT NULL,
  `Total` double unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `PravnoLice_idx` (`Lice`),
  CONSTRAINT `PravnoLice` FOREIGN KEY (`Lice`) REFERENCES `lice` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racun`
--

LOCK TABLES `racun` WRITE;
/*!40000 ALTER TABLE `racun` DISABLE KEYS */;
INSERT INTO `racun` VALUES (3,'2011-01-01 00:00:00',NULL,NULL,459.25),(4,'2002-01-01 00:00:00',NULL,NULL,459.25),(5,'2019-04-02 00:00:00',NULL,NULL,169.9);
/*!40000 ALTER TABLE `racun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racun_artikal`
--

DROP TABLE IF EXISTS `racun_artikal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `racun_artikal` (
  `ID racuna` int(10) unsigned NOT NULL,
  `ID artikla` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID racuna`,`ID artikla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racun_artikal`
--

LOCK TABLES `racun_artikal` WRITE;
/*!40000 ALTER TABLE `racun_artikal` DISABLE KEYS */;
INSERT INTO `racun_artikal` VALUES (3,1),(3,2),(3,3),(4,2),(4,3),(5,2),(5,4);
/*!40000 ALTER TABLE `racun_artikal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`rechie`@`%`*/ /*!50003 TRIGGER `racun_artikal_AFTER_INSERT` AFTER INSERT ON `racun_artikal` FOR EACH ROW BEGIN
	SELECT SUM(a.`Izlazna cena`) 
		FROM artikal a
		INNER JOIN racun_artikal ar ON a.ID = ar.`ID artikla`
		WHERE `ID racuna` = new.`ID racuna`
		INTO @totalZaRacun;
    
		UPDATE racun 
		SET Total = @totalZaRacun
		WHERE ID = new.`ID racuna`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'pos'
--

--
-- Dumping routines for database 'pos'
--
/*!50003 DROP PROCEDURE IF EXISTS `dajArtikleProdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rechie`@`%` PROCEDURE `dajArtikleProdate`(IN IDracuna INT)
BEGIN

IF (IDRacuna > 0) THEN
	SELECT a.Naziv
		FROM artikal a
		INNER JOIN racun_artikal ra ON ra.`ID artikla` = a.ID
		WHERE ra.`ID racuna` = IDracuna;
ELSE 
	SELECT DISTINCT a.Naziv
		FROM artikal a
		INNER JOIN racun_artikal ra ON ra.`ID artikla` = a.ID;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `totalZaRacun` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rechie`@`%` PROCEDURE `totalZaRacun`(IN IDrac INT)
BEGIN
SELECT SUM(a.`Izlazna cena`) 
	FROM artikal a
	INNER JOIN racun_artikal ar ON a.ID = ar.`ID artikla`
	WHERE `ID racuna` = IDrac;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-04 11:48:13
