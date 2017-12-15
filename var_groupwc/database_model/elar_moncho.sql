-- MySQL dump 10.11
--
-- Host: localhost    Database: elar
-- ------------------------------------------------------
-- Server version	5.0.51a-24+lenny4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `actions` (
  `id_action` int(11) NOT NULL auto_increment,
  `id_rule` int(11) default NULL,
  `id_device` int(11) default NULL,
  `value` double default NULL,
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_action`),
  KEY `fk_actions_rules1` (`id_rule`),
  KEY `fk_actions_devices1` (`id_device`),
  CONSTRAINT `fk_actions_devices1` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id_device`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_actions_rules1` FOREIGN KEY (`id_rule`) REFERENCES `rules` (`id_rule`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `alerts` (
  `id_alert` int(11) NOT NULL auto_increment,
  `id_rule` int(11) default NULL,
  `notification_type` int(11) default NULL COMMENT '0 : SMS\n1 : Telephone\n2 : Mail\netc.\n\n(User defined)',
  `message` varchar(255) default NULL,
  `date` int(11) default NULL,
  `is_sent` tinyint(1) default NULL,
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_alert`),
  KEY `fk_alerts_rules1` (`id_rule`),
  CONSTRAINT `fk_alerts_rules1` FOREIGN KEY (`id_rule`) REFERENCES `rules` (`id_rule`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Alert types and definitions.';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `conditions` (
  `id_condition` int(11) NOT NULL auto_increment,
  `id_rule` int(11) default NULL,
  `id_device` int(11) default NULL,
  `operator` varchar(2) default NULL COMMENT 'Valid operators:\n==\n>=\n<=\n>\n<\n!=',
  `condition_type` tinyint(1) default NULL COMMENT '0 : Value condition\n1 : Time condition ',
  `value` double default NULL COMMENT 'Value of device\nor selected time\n\n(depends on condition type)',
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_condition`),
  KEY `fk_conditions_rules1` (`id_rule`),
  KEY `fk_conditions_devices1` (`id_device`),
  CONSTRAINT `fk_conditions_devices1` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id_device`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_conditions_rules1` FOREIGN KEY (`id_rule`) REFERENCES `rules` (`id_rule`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `configuration` (
  `id_configuration` int(11) NOT NULL auto_increment,
  `screen_width` int(11) NOT NULL,
  `screen_height` int(11) NOT NULL,
  PRIMARY KEY  (`id_configuration`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES (1,800,600);
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `devices` (
  `id_device` int(11) NOT NULL auto_increment,
  `id_mote` int(11) default NULL,
  `device_type` tinyint(1) default NULL COMMENT '0 : Sensor\n1 : Actuator',
  `io_type` tinyint(1) default NULL COMMENT '0 : Analog\n1 : Digital',
  `name` varchar(100) default NULL,
  `description` varchar(255) default NULL,
  `default_value` double default NULL,
  `min_value` double default NULL,
  `max_value` double default NULL,
  `is_recorded` tinyint(1) default NULL COMMENT '0 : write only to table volatile\n1 : write to volatile and records (for historial analysis)',
  `id_panel` int(11) default NULL,
  `read_order` int(11) default NULL COMMENT 'Order of received parameter from Squidbee\n1 : first\n2 : second\n3 : third',
  `measure_unit` varchar(50) default NULL COMMENT 'Unit for value measured by device (C, F, Lux, etc.)',
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_device`),
  KEY `fk_devices_motes` (`id_mote`),
  KEY `fk_devices_panels1` (`id_panel`),
  CONSTRAINT `fk_devices_motes` FOREIGN KEY (`id_mote`) REFERENCES `motes` (`id_mote`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_devices_panels1` FOREIGN KEY (`id_panel`) REFERENCES `panels` (`id_panel`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Identifies independent devices conected to motes';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,1,0,1,'Entrada Dixital','Luz Entrada',0,NULL,NULL,1,1,NULL,NULL,NULL,NULL),(2,1,1,1,'Saída Dixital','Luz Salón',0,NULL,NULL,1,1,NULL,NULL,NULL,NULL),(3,1,0,0,'Entrada Analóxica','Sensor de luz',145,NULL,NULL,1,2,1,NULL,NULL,NULL),(4,1,0,0,'Entrada Analóxica','Sensor Humedade',33.33,0,NULL,NULL,2,2,NULL,NULL,NULL),(5,1,0,0,'Entrada Analóxica','Sensor Temperatura',11.12,-20,150,1,2,3,'C',NULL,NULL),(6,1,1,0,'Saída Analóxica','Controlador do radiador',25,0,100,1,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `locations` (
  `id_location` int(11) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `description` varchar(255) default NULL,
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_location`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Identifies locations for motes and not grouped sensors';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Habitación Moncho','Temos varios tipos de sensores.',NULL,NULL);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motes`
--

DROP TABLE IF EXISTS `motes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `motes` (
  `id_mote` int(11) NOT NULL auto_increment,
  `description` varchar(255) default NULL,
  `mote_identifier` int(11) default NULL,
  `id_location` int(11) default NULL,
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_mote`),
  KEY `fk_motes_locations1` (`id_location`),
  CONSTRAINT `fk_motes_locations1` FOREIGN KEY (`id_location`) REFERENCES `locations` (`id_location`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Identifies motes (sensor groups in the system)';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `motes`
--

LOCK TABLES `motes` WRITE;
/*!40000 ALTER TABLE `motes` DISABLE KEYS */;
INSERT INTO `motes` VALUES (1,'Primeira mota de proba',NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `motes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `panels`
--

DROP TABLE IF EXISTS `panels`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `panels` (
  `id_panel` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `description` varchar(255) default NULL,
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_panel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Device agrupations to form a panel.';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `panels`
--

LOCK TABLES `panels` WRITE;
/*!40000 ALTER TABLE `panels` DISABLE KEYS */;
INSERT INTO `panels` VALUES (1,'Principal','Donde está todo',NULL,NULL),(2,'Secundario','Donde está o resto',NULL,NULL);
/*!40000 ALTER TABLE `panels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records`
--

DROP TABLE IF EXISTS `records`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `records` (
  `id_record` int(11) NOT NULL auto_increment,
  `id_device` int(11) default NULL,
  `date` int(11) default NULL,
  `value` double default NULL,
  PRIMARY KEY  (`id_record`),
  KEY `fk_records_devices1` (`id_device`),
  CONSTRAINT `fk_records_devices1` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id_device`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Record device values if devices.is_recorded=1';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `records`
--

LOCK TABLES `records` WRITE;
/*!40000 ALTER TABLE `records` DISABLE KEYS */;
/*!40000 ALTER TABLE `records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules`
--

DROP TABLE IF EXISTS `rules`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `rules` (
  `id_rule` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `description` varchar(255) default NULL,
  `is_critical` tinyint(1) default NULL COMMENT 'for alert trigger',
  `is_active` tinyint(1) default NULL,
  `is_deleted` tinyint(1) default NULL,
  PRIMARY KEY  (`id_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User defined rules connecting  actions and alerts.';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `rules`
--

LOCK TABLES `rules` WRITE;
/*!40000 ALTER TABLE `rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volatile`
--

DROP TABLE IF EXISTS `volatile`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `volatile` (
  `id_volatile` int(11) NOT NULL auto_increment,
  `id_device` int(11) default NULL,
  `date` int(11) default NULL,
  `value` double default NULL,
  PRIMARY KEY  (`id_volatile`),
  KEY `fk_volatile_devices1` (`id_device`),
  CONSTRAINT `fk_volatile_devices1` FOREIGN KEY (`id_device`) REFERENCES `devices` (`id_device`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Records from devices. Used to graph charts in real time.';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `volatile`
--

LOCK TABLES `volatile` WRITE;
/*!40000 ALTER TABLE `volatile` DISABLE KEYS */;
/*!40000 ALTER TABLE `volatile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-10-18 20:41:28
