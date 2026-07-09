-- MySQL dump 10.13  Distrib 9.6.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gameorbit
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '3b0ab64e-29d9-11f1-bbc1-0a0027000006:1-527';

--
-- Table structure for table `acquisto`
--

DROP TABLE IF EXISTS `acquisto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acquisto` (
  `Username_Account` varchar(50) NOT NULL,
  `Id_prodotto` int NOT NULL,
  `Data_acquisto` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Prezzo_pagato` decimal(10,2) NOT NULL,
  `Metodo_di_pagamento` varchar(50) DEFAULT NULL,
  `Id_key` int DEFAULT NULL,
  PRIMARY KEY (`Username_Account`,`Id_prodotto`,`Data_acquisto`),
  KEY `Id_prodotto` (`Id_prodotto`),
  KEY `fk_acquisto_key` (`Id_key`),
  CONSTRAINT `acquisto_ibfk_1` FOREIGN KEY (`Username_Account`) REFERENCES `utente` (`Username`),
  CONSTRAINT `acquisto_ibfk_2` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `fk_acquisto_key` FOREIGN KEY (`Id_key`) REFERENCES `product_keys` (`Id_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acquisto`
--

LOCK TABLES `acquisto` WRITE;
/*!40000 ALTER TABLE `acquisto` DISABLE KEYS */;
INSERT INTO `acquisto` VALUES ('Peter',7,'2026-06-29 00:00:00',0.00,'Saldo',61),('Peter',8,'2026-06-29 00:00:00',0.00,'Saldo',71);
/*!40000 ALTER TABLE `acquisto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appartiene_categoria`
--

DROP TABLE IF EXISTS `appartiene_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appartiene_categoria` (
  `Id_prodotto` int NOT NULL,
  `Nome_Categoria` varchar(50) NOT NULL,
  PRIMARY KEY (`Id_prodotto`,`Nome_Categoria`),
  KEY `Nome_Categoria` (`Nome_Categoria`),
  CONSTRAINT `appartiene_categoria_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `appartiene_categoria_ibfk_2` FOREIGN KEY (`Nome_Categoria`) REFERENCES `categoria` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appartiene_categoria`
--

LOCK TABLES `appartiene_categoria` WRITE;
/*!40000 ALTER TABLE `appartiene_categoria` DISABLE KEYS */;
INSERT INTO `appartiene_categoria` VALUES (2,'AAA'),(3,'AAA'),(4,'AAA'),(5,'AAA'),(6,'AAA'),(13,'AAA'),(8,'Casual'),(11,'Casual'),(6,'Co_op'),(12,'Co_op'),(7,'Esport'),(10,'Esport'),(13,'Esport'),(7,'Free_to_play'),(8,'Free_to_play'),(3,'Hardcore'),(4,'Hardcore'),(9,'Indie'),(12,'Indie'),(7,'Multiplayer'),(8,'Multiplayer'),(10,'Multiplayer'),(11,'Multiplayer'),(13,'Multiplayer'),(1,'Single_player'),(2,'Single_player'),(3,'Single_player'),(4,'Single_player'),(5,'Single_player');
/*!40000 ALTER TABLE `appartiene_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appartiene_genere`
--

DROP TABLE IF EXISTS `appartiene_genere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appartiene_genere` (
  `Id_prodotto` int NOT NULL,
  `Nome_Genere` varchar(50) NOT NULL,
  PRIMARY KEY (`Id_prodotto`,`Nome_Genere`),
  KEY `Nome_Genere` (`Nome_Genere`),
  CONSTRAINT `appartiene_genere_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `appartiene_genere_ibfk_2` FOREIGN KEY (`Nome_Genere`) REFERENCES `genere` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appartiene_genere`
--

LOCK TABLES `appartiene_genere` WRITE;
/*!40000 ALTER TABLE `appartiene_genere` DISABLE KEYS */;
INSERT INTO `appartiene_genere` VALUES (1,'Avventura'),(4,'Avventura'),(5,'Avventura'),(6,'Avventura'),(9,'Avventura'),(1,'Azione'),(2,'Azione'),(3,'Azione'),(4,'Azione'),(5,'Azione'),(6,'Azione'),(7,'Azione'),(9,'Azione'),(13,'Azione'),(3,'Horror'),(4,'Horror'),(12,'Horror'),(9,'Platform'),(6,'Puzzle'),(11,'Racing'),(1,'RPG'),(2,'RPG'),(3,'RPG'),(4,'RPG'),(5,'RPG'),(6,'RPG'),(10,'Simulazione'),(11,'Simulazione'),(7,'Sparatutto'),(13,'Sparatutto'),(10,'Sport'),(11,'Sport'),(8,'Strategia');
/*!40000 ALTER TABLE `appartiene_genere` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `Nome` varchar(50) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES ('AAA'),('Casual'),('Co_op'),('Esport'),('Free_to_play'),('Hardcore'),('Indie'),('MMO'),('Multiplayer'),('Single_player'),('VR');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disponibile_in`
--

DROP TABLE IF EXISTS `disponibile_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disponibile_in` (
  `Id_prodotto` int NOT NULL,
  `Nome_Regione` varchar(50) NOT NULL,
  PRIMARY KEY (`Id_prodotto`,`Nome_Regione`),
  KEY `Nome_Regione` (`Nome_Regione`),
  CONSTRAINT `disponibile_in_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `disponibile_in_ibfk_2` FOREIGN KEY (`Nome_Regione`) REFERENCES `regione` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibile_in`
--

LOCK TABLES `disponibile_in` WRITE;
/*!40000 ALTER TABLE `disponibile_in` DISABLE KEYS */;
INSERT INTO `disponibile_in` VALUES (3,'Europa'),(5,'Europa'),(10,'Europa'),(1,'Global'),(2,'Global'),(4,'Global'),(6,'Global'),(7,'Global'),(8,'Global'),(9,'Global'),(11,'Global'),(12,'Global'),(13,'Global');
/*!40000 ALTER TABLE `disponibile_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_parte_di`
--

DROP TABLE IF EXISTS `fa_parte_di`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fa_parte_di` (
  `Id_prodotto` int NOT NULL,
  `Titolo_Franchise` varchar(100) NOT NULL,
  PRIMARY KEY (`Id_prodotto`),
  KEY `Titolo_Franchise` (`Titolo_Franchise`),
  CONSTRAINT `fa_parte_di_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `fa_parte_di_ibfk_2` FOREIGN KEY (`Titolo_Franchise`) REFERENCES `franchise` (`Titolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_parte_di`
--

LOCK TABLES `fa_parte_di` WRITE;
/*!40000 ALTER TABLE `fa_parte_di` DISABLE KEYS */;
INSERT INTO `fa_parte_di` VALUES (5,'Assassin\'s Creed'),(6,'Baldur\'s Gate'),(8,'Clash'),(7,'Counter-Strike'),(3,'Dark Souls'),(10,'EA Sports FC'),(11,'Forza'),(9,'Hollow Knight'),(12,'Phasmophobia'),(1,'The Witcher');
/*!40000 ALTER TABLE `fa_parte_di` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `franchise`
--

DROP TABLE IF EXISTS `franchise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `franchise` (
  `Titolo` varchar(100) NOT NULL,
  PRIMARY KEY (`Titolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `franchise`
--

LOCK TABLES `franchise` WRITE;
/*!40000 ALTER TABLE `franchise` DISABLE KEYS */;
INSERT INTO `franchise` VALUES ('Assassin\'s Creed'),('Baldur\'s Gate'),('Clash'),('Counter-Strike'),('Dark Souls'),('EA Sports FC'),('Forza'),('Hollow Knight'),('Phasmophobia'),('The Witcher');
/*!40000 ALTER TABLE `franchise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genere`
--

DROP TABLE IF EXISTS `genere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genere` (
  `Nome` varchar(50) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genere`
--

LOCK TABLES `genere` WRITE;
/*!40000 ALTER TABLE `genere` DISABLE KEYS */;
INSERT INTO `genere` VALUES ('Avventura'),('Azione'),('Horror'),('Picchiaduro'),('Platform'),('Puzzle'),('Racing'),('RPG'),('Simulazione'),('Sparatutto'),('Sport'),('Strategia'),('Survival');
/*!40000 ALTER TABLE `genere` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impostazioni_utente`
--

DROP TABLE IF EXISTS `impostazioni_utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `impostazioni_utente` (
  `Username` varchar(30) NOT NULL,
  `Due_Fattori` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Username`),
  CONSTRAINT `impostazioni_utente_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `utente` (`Username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impostazioni_utente`
--

LOCK TABLES `impostazioni_utente` WRITE;
/*!40000 ALTER TABLE `impostazioni_utente` DISABLE KEYS */;
INSERT INTO `impostazioni_utente` VALUES ('averdi',0),('DaddyP',0),('dgallo',0),('ecosta',0),('fesposito',0),('gneri',0),('lbianchi',0),('mgreco',0),('mrossi',0),('Peter',1),('rferretti',0),('sconti',0);
/*!40000 ALTER TABLE `impostazioni_utente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lingua`
--

DROP TABLE IF EXISTS `lingua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lingua` (
  `Lingua` varchar(50) NOT NULL,
  PRIMARY KEY (`Lingua`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lingua`
--

LOCK TABLES `lingua` WRITE;
/*!40000 ALTER TABLE `lingua` DISABLE KEYS */;
INSERT INTO `lingua` VALUES ('Inglese'),('Italiano'),('Mandarino'),('Russo'),('Spagnolo');
/*!40000 ALTER TABLE `lingua` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodo_pagamento`
--

DROP TABLE IF EXISTS `metodo_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodo_pagamento` (
  `IdMetodo` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `TipoMetodo` enum('Da_configurare','Carta','Paypal','Bonifico','Apple_pay','Google_pay','Saldo') DEFAULT NULL,
  `Provider` varchar(30) DEFAULT NULL,
  `TokenPagamento` varchar(255) DEFAULT NULL,
  `Ultime4Cifre` char(4) DEFAULT NULL,
  `ScadenzaMese` tinyint DEFAULT NULL,
  `ScadenzaAnno` smallint DEFAULT NULL,
  `Predefinito` bit(1) NOT NULL DEFAULT b'1',
  `Attivo` bit(1) NOT NULL DEFAULT b'1',
  `DataCreazione` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMetodo`),
  KEY `FK_MetodoPagamento_Utente` (`Username`),
  CONSTRAINT `FK_MetodoPagamento_Utente` FOREIGN KEY (`Username`) REFERENCES `utente` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo_pagamento`
--

LOCK TABLES `metodo_pagamento` WRITE;
/*!40000 ALTER TABLE `metodo_pagamento` DISABLE KEYS */;
INSERT INTO `metodo_pagamento` VALUES (1,'averdi','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(2,'DaddyP','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(3,'dgallo','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(4,'ecosta','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(5,'fesposito','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(6,'gneri','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(7,'lbianchi','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(8,'mgreco','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(9,'mrossi','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(11,'rferretti','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(12,'sconti','Da_configurare',NULL,NULL,NULL,NULL,NULL,_binary '',_binary '','2026-06-25 23:42:32'),(13,'Peter','Carta','Mastercard','5333333333333333','1234',1,2030,_binary '\0',_binary '','2026-07-05 18:30:54');
/*!40000 ALTER TABLE `metodo_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piattaforma`
--

DROP TABLE IF EXISTS `piattaforma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `piattaforma` (
  `Nome` varchar(50) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piattaforma`
--

LOCK TABLES `piattaforma` WRITE;
/*!40000 ALTER TABLE `piattaforma` DISABLE KEYS */;
INSERT INTO `piattaforma` VALUES ('Nintendo_Switch'),('Nintendo_Switch_2'),('PC'),('PlayStation_4'),('PlayStation_5'),('Xbox');
/*!40000 ALTER TABLE `piattaforma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_keys`
--

DROP TABLE IF EXISTS `product_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_keys` (
  `Id_key` int NOT NULL AUTO_INCREMENT,
  `Id_prodotto` int NOT NULL,
  `chiave` varchar(64) DEFAULT NULL,
  `status` enum('Disponibile','Venduto') DEFAULT 'Disponibile',
  PRIMARY KEY (`Id_key`),
  UNIQUE KEY `chiave` (`chiave`),
  KEY `Id_prodotto` (`Id_prodotto`),
  CONSTRAINT `product_keys_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_keys`
--

LOCK TABLES `product_keys` WRITE;
/*!40000 ALTER TABLE `product_keys` DISABLE KEYS */;
INSERT INTO `product_keys` VALUES (1,1,'P1A1-B2C3-D4E5-F6G7','Venduto'),(2,1,'P1H8-I9J0-K1L2-M3N4','Disponibile'),(3,1,'P1O5-P6Q7-R8S9-T0U1','Disponibile'),(4,1,'P1V2-W3X4-Y5Z6-A7B8','Disponibile'),(5,1,'P1C9-D0E1-F2G3-H4I5','Disponibile'),(6,1,'P1J6-K7L8-M9N0-O1P2','Disponibile'),(7,1,'P1Q3-R4S5-T6U7-V8W9','Disponibile'),(8,1,'P1X0-Y1Z2-A3B4-C5D6','Disponibile'),(9,1,'P1E7-F8G9-H0I1-J2K3','Disponibile'),(10,1,'P1L4-M5N6-O7P8-Q9R0','Disponibile'),(11,2,'P2A1-B2C3-D4E5-F6G7','Disponibile'),(12,2,'P2H8-I9J0-K1L2-M3N4','Disponibile'),(13,2,'P2O5-P6Q7-R8S9-T0U1','Disponibile'),(14,2,'P2V2-W3X4-Y5Z6-A7B8','Disponibile'),(15,2,'P2C9-D0E1-F2G3-H4I5','Disponibile'),(16,2,'P2J6-K7L8-M9N0-O1P2','Disponibile'),(17,2,'P2Q3-R4S5-T6U7-V8W9','Disponibile'),(18,2,'P2X0-Y1Z2-A3B4-C5D6','Disponibile'),(19,2,'P2E7-F8G9-H0I1-J2K3','Disponibile'),(20,2,'P2L4-M5N6-O7P8-Q9R0','Disponibile'),(21,3,'P3A1-B2C3-D4E5-F6G7','Disponibile'),(22,3,'P3H8-I9J0-K1L2-M3N4','Disponibile'),(23,3,'P3O5-P6Q7-R8S9-T0U1','Disponibile'),(24,3,'P3V2-W3X4-Y5Z6-A7B8','Disponibile'),(25,3,'P3C9-D0E1-F2G3-H4I5','Disponibile'),(26,3,'P3J6-K7L8-M9N0-O1P2','Disponibile'),(27,3,'P3Q3-R4S5-T6U7-V8W9','Disponibile'),(28,3,'P3X0-Y1Z2-A3B4-C5D6','Disponibile'),(29,3,'P3E7-F8G9-H0I1-J2K3','Disponibile'),(30,3,'P3L4-M5N6-O7P8-Q9R0','Disponibile'),(31,4,'P4A1-B2C3-D4E5-F6G7','Disponibile'),(32,4,'P4H8-I9J0-K1L2-M3N4','Disponibile'),(33,4,'P4O5-P6Q7-R8S9-T0U1','Disponibile'),(34,4,'P4V2-W3X4-Y5Z6-A7B8','Disponibile'),(35,4,'P4C9-D0E1-F2G3-H4I5','Disponibile'),(36,4,'P4J6-K7L8-M9N0-O1P2','Disponibile'),(37,4,'P4Q3-R4S5-T6U7-V8W9','Disponibile'),(38,4,'P4X0-Y1Z2-A3B4-C5D6','Disponibile'),(39,4,'P4E7-F8G9-H0I1-J2K3','Disponibile'),(40,4,'P4L4-M5N6-O7P8-Q9R0','Disponibile'),(41,5,'P5A1-B2C3-D4E5-F6G7','Disponibile'),(42,5,'P5H8-I9J0-K1L2-M3N4','Disponibile'),(43,5,'P5O5-P6Q7-R8S9-T0U1','Disponibile'),(44,5,'P5V2-W3X4-Y5Z6-A7B8','Disponibile'),(45,5,'P5C9-D0E1-F2G3-H4I5','Disponibile'),(46,5,'P5J6-K7L8-M9N0-O1P2','Disponibile'),(47,5,'P5Q3-R4S5-T6U7-V8W9','Disponibile'),(48,5,'P5X0-Y1Z2-A3B4-C5D6','Disponibile'),(49,5,'P5E7-F8G9-H0I1-J2K3','Disponibile'),(50,5,'P5L4-M5N6-O7P8-Q9R0','Disponibile'),(51,6,'P6A1-B2C3-D4E5-F6G7','Disponibile'),(52,6,'P6H8-I9J0-K1L2-M3N4','Disponibile'),(53,6,'P6O5-P6Q7-R8S9-T0U1','Disponibile'),(54,6,'P6V2-W3X4-Y5Z6-A7B8','Disponibile'),(55,6,'P6C9-D0E1-F2G3-H4I5','Disponibile'),(56,6,'P6J6-K7L8-M9N0-O1P2','Disponibile'),(57,6,'P6Q3-R4S5-T6U7-V8W9','Disponibile'),(58,6,'P6X0-Y1Z2-A3B4-C5D6','Disponibile'),(59,6,'P6E7-F8G9-H0I1-J2K3','Disponibile'),(60,6,'P6L4-M5N6-O7P8-Q9R0','Disponibile'),(61,7,'P7A1-B2C3-D4E5-F6G7','Venduto'),(62,7,'P7H8-I9J0-K1L2-M3N4','Disponibile'),(63,7,'P7O5-P6Q7-R8S9-T0U1','Disponibile'),(64,7,'P7V2-W3X4-Y5Z6-A7B8','Disponibile'),(65,7,'P7C9-D0E1-F2G3-H4I5','Disponibile'),(66,7,'P7J6-K7L8-M9N0-O1P2','Disponibile'),(67,7,'P7Q3-R4S5-T6U7-V8W9','Disponibile'),(68,7,'P7X0-Y1Z2-A3B4-C5D6','Disponibile'),(69,7,'P7E7-F8G9-H0I1-J2K3','Disponibile'),(70,7,'P7L4-M5N6-O7P8-Q9R0','Disponibile'),(71,8,'P8A1-B2C3-D4E5-F6G7','Venduto'),(72,8,'P8H8-I9J0-K1L2-M3N4','Disponibile'),(73,8,'P8O5-P6Q7-R8S9-T0U1','Disponibile'),(74,8,'P8V2-W3X4-Y5Z6-A7B8','Disponibile'),(75,8,'P8C9-D0E1-F2G3-H4I5','Disponibile'),(76,8,'P8J6-K7L8-M9N0-O1P2','Disponibile'),(77,8,'P8Q3-R4S5-T6U7-V8W9','Disponibile'),(78,8,'P8X0-Y1Z2-A3B4-C5D6','Disponibile'),(79,8,'P8E7-F8G9-H0I1-J2K3','Disponibile'),(80,8,'P8L4-M5N6-O7P8-Q9R0','Disponibile'),(81,9,'P9A1-B2C3-D4E5-F6G7','Disponibile'),(82,9,'P9H8-I9J0-K1L2-M3N4','Disponibile'),(83,9,'P9O5-P6Q7-R8S9-T0U1','Disponibile'),(84,9,'P9V2-W3X4-Y5Z6-A7B8','Disponibile'),(85,9,'P9C9-D0E1-F2G3-H4I5','Disponibile'),(86,9,'P9J6-K7L8-M9N0-O1P2','Disponibile'),(87,9,'P9Q3-R4S5-T6U7-V8W9','Disponibile'),(88,9,'P9X0-Y1Z2-A3B4-C5D6','Disponibile'),(89,9,'P9E7-F8G9-H0I1-J2K3','Disponibile'),(90,9,'P9L4-M5N6-O7P8-Q9R0','Disponibile'),(91,10,'P10A-B2C3-D4E5-F6G7','Disponibile'),(92,10,'P10H-I9J0-K1L2-M3N4','Disponibile'),(93,10,'P10O-P6Q7-R8S9-T0U1','Disponibile'),(94,10,'P10V-W3X4-Y5Z6-A7B8','Disponibile'),(95,10,'P10C-D0E1-F2G3-H4I5','Disponibile'),(96,10,'P10J-K7L8-M9N0-O1P2','Disponibile'),(97,10,'P10Q-R4S5-T6U7-V8W9','Disponibile'),(98,10,'P10X-Y1Z2-A3B4-C5D6','Disponibile'),(99,10,'P10E-F8G9-H0I1-J2K3','Disponibile'),(100,10,'P10L-M5N6-O7P8-Q9R0','Disponibile'),(101,11,'P11A-B2C3-D4E5-F6G7','Disponibile'),(102,11,'P11H-I9J0-K1L2-M3N4','Disponibile'),(103,11,'P11O-P6Q7-R8S9-T0U1','Disponibile'),(104,11,'P11V-W3X4-Y5Z6-A7B8','Disponibile'),(105,11,'P11C-D0E1-F2G3-H4I5','Disponibile'),(106,11,'P11J-K7L8-M9N0-O1P2','Disponibile'),(107,11,'P11Q-R4S5-T6U7-V8W9','Disponibile'),(108,11,'P11X-Y1Z2-A3B4-C5D6','Disponibile'),(109,11,'P11E-F8G9-H0I1-J2K3','Disponibile'),(110,11,'P11L-M5N6-O7P8-Q9R0','Disponibile'),(111,12,'P12A-B2C3-D4E5-F6G7','Disponibile'),(112,12,'P12H-I9J0-K1L2-M3N4','Disponibile'),(113,12,'P12O-P6Q7-R8S9-T0U1','Disponibile'),(114,12,'P12V-W3X4-Y5Z6-A7B8','Disponibile'),(115,12,'P12C-D0E1-F2G3-H4I5','Disponibile'),(116,12,'P12J-K7L8-M9N0-O1P2','Disponibile'),(117,12,'P12Q-R4S5-T6U7-V8W9','Disponibile'),(118,12,'P12X-Y1Z2-A3B4-C5D6','Disponibile'),(119,12,'P12E-F8G9-H0I1-J2K3','Disponibile'),(120,12,'P12L-M5N6-O7P8-Q9R0','Disponibile'),(121,13,'P13A-B2C3-D4E5-F6G7','Disponibile'),(122,13,'P13H-I9J0-K1L2-M3N4','Disponibile'),(123,13,'P13O-P6Q7-R8S9-T0U1','Disponibile'),(124,13,'P13V-W3X4-Y5Z6-A7B8','Disponibile'),(125,13,'P13C-D0E1-F2G3-H4I5','Disponibile'),(126,13,'P13J-K7L8-M9N0-O1P2','Disponibile'),(127,13,'P13Q-R4S5-T6U7-V8W9','Disponibile'),(128,13,'P13X-Y1Z2-A3B4-C5D6','Disponibile'),(129,13,'P13E-F8G9-H0I1-J2K3','Disponibile'),(130,13,'P13L-M5N6-O7P8-Q9R0','Disponibile');
/*!40000 ALTER TABLE `product_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pubblicazione_gioco`
--

DROP TABLE IF EXISTS `pubblicazione_gioco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pubblicazione_gioco` (
  `Id_prodotto` int NOT NULL,
  `Nome_Publisher` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id_prodotto`),
  KEY `Nome_Publisher` (`Nome_Publisher`),
  CONSTRAINT `pubblicazione_gioco_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `pubblicazione_gioco_ibfk_2` FOREIGN KEY (`Nome_Publisher`) REFERENCES `publisher` (`Nome_SH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pubblicazione_gioco`
--

LOCK TABLES `pubblicazione_gioco` WRITE;
/*!40000 ALTER TABLE `pubblicazione_gioco` DISABLE KEYS */;
INSERT INTO `pubblicazione_gioco` VALUES (1,'CD Projekt Red'),(2,'CD Projekt Red'),(10,'EA Sports'),(13,'Extremely Normal'),(3,'FromSoftware'),(4,'FromSoftware'),(12,'Kinetic Games'),(6,'Larian Studios'),(8,'Supercell'),(9,'Team Cherry'),(5,'Ubisoft Montreal'),(7,'Valve'),(11,'Xbox Game Studios');
/*!40000 ALTER TABLE `pubblicazione_gioco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `Nome_SH` varchar(100) NOT NULL,
  `Budget_marketing_annuo` bigint NOT NULL,
  `Canale_distribuzione` varchar(50) NOT NULL,
  PRIMARY KEY (`Nome_SH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES ('CD Projekt Red',25000000,'Digitale'),('EA Sports',60000000,'Digitale/Fisico'),('Extremely Normal',90,'Digitale'),('FromSoftware',30000000,'Digitale/Fisico'),('Kinetic Games',200000,'Digitale'),('Larian Studios',15000000,'Digitale'),('Supercell',18000000,'Mobile'),('Team Cherry',500000,'Digitale'),('Ubisoft Montreal',45000000,'Digitale/Fisico'),('Valve',20000000,'Digitale'),('Xbox Game Studios',50000000,'Digitale/Fisico');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regione`
--

DROP TABLE IF EXISTS `regione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regione` (
  `Nome` varchar(50) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regione`
--

LOCK TABLES `regione` WRITE;
/*!40000 ALTER TABLE `regione` DISABLE KEYS */;
INSERT INTO `regione` VALUES ('Europa'),('Global'),('Italia'),('Turchia');
/*!40000 ALTER TABLE `regione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rilascio_su`
--

DROP TABLE IF EXISTS `rilascio_su`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rilascio_su` (
  `Id_prodotto` int NOT NULL,
  `Nome_Piattaforma` varchar(50) NOT NULL,
  PRIMARY KEY (`Id_prodotto`,`Nome_Piattaforma`),
  KEY `Nome_Piattaforma` (`Nome_Piattaforma`),
  CONSTRAINT `rilascio_su_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `rilascio_su_ibfk_2` FOREIGN KEY (`Nome_Piattaforma`) REFERENCES `piattaforma` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rilascio_su`
--

LOCK TABLES `rilascio_su` WRITE;
/*!40000 ALTER TABLE `rilascio_su` DISABLE KEYS */;
INSERT INTO `rilascio_su` VALUES (1,'Nintendo_Switch'),(9,'Nintendo_Switch'),(10,'Nintendo_Switch'),(12,'Nintendo_Switch'),(1,'Nintendo_Switch_2'),(2,'Nintendo_Switch_2'),(4,'Nintendo_Switch_2'),(10,'Nintendo_Switch_2'),(12,'Nintendo_Switch_2'),(1,'PC'),(2,'PC'),(3,'PC'),(4,'PC'),(5,'PC'),(6,'PC'),(7,'PC'),(8,'PC'),(9,'PC'),(10,'PC'),(11,'PC'),(12,'PC'),(13,'PC'),(1,'Playstation_4'),(3,'PlayStation_4'),(4,'Playstation_4'),(9,'Playstation_4'),(10,'Playstation_4'),(12,'Playstation_4'),(1,'PlayStation_5'),(2,'PlayStation_5'),(3,'Playstation_5'),(4,'PlayStation_5'),(5,'PlayStation_5'),(6,'PlayStation_5'),(9,'Playstation_5'),(10,'PlayStation_5'),(11,'Playstation_5'),(12,'Playstation_5'),(1,'Xbox'),(2,'Xbox'),(3,'Xbox'),(4,'Xbox'),(5,'Xbox'),(6,'Xbox'),(9,'Xbox'),(10,'Xbox'),(11,'Xbox'),(12,'Xbox');
/*!40000 ALTER TABLE `rilascio_su` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saldo_virtuale`
--

DROP TABLE IF EXISTS `saldo_virtuale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saldo_virtuale` (
  `Username_Account` varchar(50) NOT NULL,
  `Valuta` char(3) DEFAULT 'EUR',
  `Saldo` decimal(10,2) DEFAULT '0.00',
  `Stato` varchar(20) DEFAULT NULL,
  `Data_ultimo_aggiornamento` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Username_Account`),
  CONSTRAINT `saldo_virtuale_ibfk_1` FOREIGN KEY (`Username_Account`) REFERENCES `utente` (`Username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saldo_virtuale`
--

LOCK TABLES `saldo_virtuale` WRITE;
/*!40000 ALTER TABLE `saldo_virtuale` DISABLE KEYS */;
INSERT INTO `saldo_virtuale` VALUES ('averdi','USD',45.20,'Disponibile','2025-01-11 00:00:00'),('DaddyP','EUR',0.00,'Disponibile','2026-06-10 00:00:00'),('dgallo','EUR',0.00,'Sospeso','2026-04-12 00:00:00'),('ecosta','EUR',0.00,'Disponibile','2026-06-18 00:00:00'),('fesposito','EUR',250.00,'Disponibile','2025-01-08 00:00:00'),('gneri','GBP',15.80,'Sospeso','2025-01-09 00:00:00'),('lbianchi','EUR',30.00,'Disponibile','2025-01-12 00:00:00'),('mgreco','EUR',0.00,'Bloccato','2025-11-30 00:00:00'),('mrossi','EUR',120.50,'Disponibile','2025-01-10 00:00:00'),('Peter','EUR',5.03,'Disponibile','2026-06-29 01:30:38'),('rferretti','EUR',0.00,'Bloccato','2026-01-15 00:00:00'),('sconti','EUR',0.00,'Disponibile','2026-06-05 00:00:00');
/*!40000 ALTER TABLE `saldo_virtuale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_house`
--

DROP TABLE IF EXISTS `software_house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `software_house` (
  `Nome` varchar(100) NOT NULL,
  `Sede_legale` varchar(150) DEFAULT NULL,
  `Anno_di_fondazione` int DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_house`
--

LOCK TABLES `software_house` WRITE;
/*!40000 ALTER TABLE `software_house` DISABLE KEYS */;
INSERT INTO `software_house` VALUES ('CD Projekt Red','Varsavia',2002),('EA Sports','Vancouver',1991),('Extremely Normal','Napoli',2025),('FromSoftware','Tokyo',1986),('Kinetic Games','London',2020),('Larian Studios','Gent',1996),('Supercell','Helsinki',2010),('Team Cherry','Adelaide',2014),('Ubisoft Montreal','Montreal',1997),('Valve','Bellevue',1996),('Xbox Game Studios','Redmond',2000);
/*!40000 ALTER TABLE `software_house` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supporta`
--

DROP TABLE IF EXISTS `supporta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supporta` (
  `Id_prodotto` int NOT NULL,
  `Lingua` varchar(50) NOT NULL,
  PRIMARY KEY (`Id_prodotto`,`Lingua`),
  KEY `Lingua` (`Lingua`),
  CONSTRAINT `supporta_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `supporta_ibfk_2` FOREIGN KEY (`Lingua`) REFERENCES `lingua` (`Lingua`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supporta`
--

LOCK TABLES `supporta` WRITE;
/*!40000 ALTER TABLE `supporta` DISABLE KEYS */;
INSERT INTO `supporta` VALUES (1,'Inglese'),(2,'Inglese'),(3,'Inglese'),(4,'Inglese'),(5,'Inglese'),(6,'Inglese'),(7,'Inglese'),(8,'Inglese'),(9,'Inglese'),(11,'Inglese'),(12,'Inglese'),(13,'Inglese'),(1,'Italiano'),(2,'Italiano'),(4,'Italiano'),(5,'Italiano'),(6,'Italiano'),(9,'Italiano'),(10,'Italiano'),(12,'Italiano'),(13,'Russo'),(2,'Spagnolo');
/*!40000 ALTER TABLE `supporta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sviluppatori`
--

DROP TABLE IF EXISTS `sviluppatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sviluppatori` (
  `Nome_SH` varchar(100) NOT NULL,
  `N_Sviluppatori` int DEFAULT NULL,
  `Tipologia` varchar(50) DEFAULT NULL,
  `Motore_grafico` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Nome_SH`),
  CONSTRAINT `sviluppatori_ibfk_1` FOREIGN KEY (`Nome_SH`) REFERENCES `software_house` (`Nome`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sviluppatori`
--

LOCK TABLES `sviluppatori` WRITE;
/*!40000 ALTER TABLE `sviluppatori` DISABLE KEYS */;
INSERT INTO `sviluppatori` VALUES ('CD Projekt Red',500,'AAA','RED Engine'),('EA Sports',1500,'AAA','Frostbite'),('Extremely Normal',3,'Indie','Proprietario'),('FromSoftware',350,'AAA','Proprietario'),('Kinetic Games',15,'Indie','Unity'),('Larian Studios',500,'AAA','Divinity Engine'),('Supercell',400,'Mobile','Proprietario'),('Team Cherry',3,'Indie','Unity'),('Ubisoft Montreal',2000,'AAA','Anvil'),('Valve',1200,'AAA','Source 2'),('Xbox Game Studios',3000,'AAA','Various');
/*!40000 ALTER TABLE `sviluppatori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sviluppo_gioco`
--

DROP TABLE IF EXISTS `sviluppo_gioco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sviluppo_gioco` (
  `Id_prodotto` int NOT NULL,
  `Nome_SH` varchar(100) NOT NULL,
  PRIMARY KEY (`Id_prodotto`,`Nome_SH`),
  KEY `Nome_SH` (`Nome_SH`),
  CONSTRAINT `sviluppo_gioco_ibfk_1` FOREIGN KEY (`Id_prodotto`) REFERENCES `videogioco` (`Id_prodotto`),
  CONSTRAINT `sviluppo_gioco_ibfk_2` FOREIGN KEY (`Nome_SH`) REFERENCES `sviluppatori` (`Nome_SH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sviluppo_gioco`
--

LOCK TABLES `sviluppo_gioco` WRITE;
/*!40000 ALTER TABLE `sviluppo_gioco` DISABLE KEYS */;
INSERT INTO `sviluppo_gioco` VALUES (1,'CD Projekt Red'),(2,'CD Projekt Red'),(10,'EA Sports'),(13,'Extremely Normal'),(3,'FromSoftware'),(4,'FromSoftware'),(12,'Kinetic Games'),(6,'Larian Studios'),(8,'Supercell'),(9,'Team Cherry'),(5,'Ubisoft Montreal'),(7,'Valve'),(11,'Xbox Game Studios');
/*!40000 ALTER TABLE `sviluppo_gioco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `Id_Ticket` int NOT NULL AUTO_INCREMENT,
  `Username_Account` varchar(50) NOT NULL,
  `Id_prodotto_riguardato` int DEFAULT NULL,
  `Data_di_invio` datetime DEFAULT CURRENT_TIMESTAMP,
  `Motivazione` text,
  `Tipo_ticket` varchar(50) DEFAULT NULL,
  `Stato` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id_Ticket`),
  KEY `Username_Account` (`Username_Account`),
  KEY `Id_prodotto_riguardato` (`Id_prodotto_riguardato`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`Username_Account`) REFERENCES `utente` (`Username`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`Id_prodotto_riguardato`) REFERENCES `videogioco` (`Id_prodotto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,'mrossi',1,'2025-01-01 00:00:00','Codice non ricevuto','acquisto','Aperto'),(2,'lbianchi',7,'2025-01-03 00:00:00','Problema accesso account','Account','Chiuso'),(3,'averdi',6,'2025-01-04 00:00:00','Richiesta rimborso','acquisto','Aperto'),(4,'gneri',9,'2025-01-05 00:00:00','Informazioni generali','generico','Chiuso'),(5,'sconti',12,'2025-01-06 00:00:00','Problema download','acquisto','Aperto');
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_2fa`
--

DROP TABLE IF EXISTS `token_2fa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_2fa` (
  `Username` varchar(30) NOT NULL,
  `Token` varchar(100) NOT NULL,
  `Scadenza` timestamp NOT NULL,
  PRIMARY KEY (`Username`),
  UNIQUE KEY `Token` (`Token`),
  CONSTRAINT `token_2fa_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `utente` (`Username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_2fa`
--

LOCK TABLES `token_2fa` WRITE;
/*!40000 ALTER TABLE `token_2fa` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_2fa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `Username` varchar(50) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Cognome` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Data_di_nascita` date DEFAULT NULL,
  `Numero_di_telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Username`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES ('averdi','Anna','Verdi','anna@email.it','$2a$10$ho.rBl9vZyMg9kNNeckrTO4Hl8zJmf5njDKjxl05x7uHwVV9AJuTK','1997-03-01','3331111113'),('DaddyP','Padre','Pio','jegiwin517@icubik.com','$2a$10$4lGdTxPIc1vs4Q/.fBUhyO4F6lyuEZVYN1VErxqBnFL9uqkN674vu','2014-07-08','3713452348'),('dgallo','Davide','Gallo','davide@email.it','$2a$10$4l/BbsoZZtnrQBd6LSyhIOJJzwmXy9Ttd3IZGQxpsjXI0nNJUawYG','2000-07-30','3331111120'),('ecosta','Elena','Costa','elena@email.it','$2a$10$WtowQZceUmgMgrmlu4dc6.KbuwcZOR7wUkMc4BBb0hRdRgFST6Q4q','1993-12-02','3331111119'),('fesposito','Franco','Esposito','franco@email.it','$2a$10$uLe0iNFN0xhoakTb7v7t1emibgLHszeM33Cjl4VgrFHmdQeRoj5iW','1990-02-20','3331111115'),('gneri','Giulia','Neri','giulia@email.it','$2a$10$0Asfaoe5DemPK0Oor/SWIuD/QxA7l6iz5HhiZaElyLmMuXOfgX0t6','1999-11-18','3331111114'),('lbianchi','Luca','Bianchi','luca@email.it','$2a$10$wIIc877bXM60b8vSKSm1UuTSwLBvdx09d9gf6NIzF.wybSFKHy.Xm','1998-08-15','3331111112'),('mgreco','Marco','Greco','marco@email.it','$2a$10$Uvc7QwJ94Yll7f4QRKZqrubN/NYa1niOUELEcqzTn27cpHB7wD8jy','1996-01-11','3331111118'),('mrossi','Mario','Rossi','mario@email.it','$2a$10$qPeoUG3eY.QF66ABWls.XecfS/YxTMqCcO8NfgGlbxp9mRzScPkTO','1995-04-12','3331111111'),('Peter','Pietro','Fiore','fpietro187@gmail.com','$2a$10$NyRzmGMkPJnpSIrYggR.quUU4wZpmtgzLsEu34/Oio6plzWqfh05W','2004-08-27','3883587794'),('rferretti','Roberto','Ferretti','roberto@email.it','$2a$10$XZMwK6M.D4LEVvb9GGqTWecFTXPnGOxCwdTBaiUK2L4lrpTjCAjYm','1989-06-14','3331111117'),('sconti','Sara','Conti','sara@email.it','$2a$10$6FNBhW9082vSxcFOs0j.FOtNIy74QPP9EGYc2X3QA5qZ6XI19zEnS','1994-09-05','3331111116');
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videogioco`
--

DROP TABLE IF EXISTS `videogioco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videogioco` (
  `Id_prodotto` int NOT NULL,
  `Titolo` varchar(150) NOT NULL,
  `Prezzo` decimal(10,2) NOT NULL,
  `Data_rilascio` date DEFAULT NULL,
  `Descrizione_testuale` text,
  `immagine` varchar(255) DEFAULT 'default.png',
  PRIMARY KEY (`Id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videogioco`
--

LOCK TABLES `videogioco` WRITE;
/*!40000 ALTER TABLE `videogioco` DISABLE KEYS */;
INSERT INTO `videogioco` VALUES (1,'The Witcher 3',29.99,'2015-05-19','Un RPG open world in cui Geralt di Rivia affronta mostri, intrighi politici e antiche profezie.','tw3.jpeg'),(2,'Cyberpunk 2077',49.99,'2020-12-10','Un avventura futuristica ambientata a Night City, tra tecnologia avanzata e mercenari senza scrupoli.','cyberpunk.jpeg'),(3,'Dark Souls III',39.99,'2016-04-12','Un action RPG impegnativo caratterizzato da combattimenti strategici e ambientazioni oscure.','ds3.jpeg'),(4,'Elden Ring',59.99,'2022-02-25','Un vasto open world fantasy ricco di misteri, boss epici e libertà di esplorazione.','er.jpeg'),(5,'Assassin\'s Creed Mirage',44.99,'2023-10-05','Un ritorno alle origini della serie, con furtività e parkour nella Baghdad del IX secolo.','acm.jpeg'),(6,'Baldur\'s Gate 3',59.99,'2023-08-03','Un RPG basato su Dungeons & Dragons con scelte profonde e avventure cooperative.','bg3.jpeg'),(7,'Counter-Strike 2',0.00,'2023-09-27','Uno sparatutto tattico competitivo dove lavoro di squadra e precisione fanno la differenza.','cs2.jpeg'),(8,'Clash of Clans',0.00,'2012-08-02','Un gioco strategico per dispositivi mobili in cui costruisci villaggi e combatti altri clan.','coc.jpeg'),(9,'Hollow Knight',14.99,'2017-02-24','Un avventura metroidvania ambientata in un regno sotterraneo affascinante e pieno di segreti.','hk.jpeg'),(10,'EA Sports FC 25',69.99,'2024-09-27','Il simulatore calcistico con squadre ufficiali, modalità competitive e gameplay realistico.','fc25.jpeg'),(11,'Forza Horizon 5',49.99,'2021-11-09','Un gioco di guida open world ambientato in Messico, con centinaia di auto e sfide dinamiche.','fh5.jpeg'),(12,'Phasmophobia',19.99,'2020-09-18','Un horror cooperativo in cui investigare attività paranormali e identificare diversi tipi di fantasmi.','phasmophobia.jpeg'),(13,'Waifu Tactical Force',999.99,'2027-12-12','Un FPS multiplayer incentrato sul movimento con un estetica anime unica.','WTF.jpeg');
/*!40000 ALTER TABLE `videogioco` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-09 13:17:22
