/*
SQLyog Ultimate v11.25 (64 bit)
MySQL - 5.7.43 : Database - PROFILE_API
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`PROFILE_API` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `PROFILE_API`;

/*Table structure for table `binding_info` */

DROP TABLE IF EXISTS `binding_info`;

CREATE TABLE `binding_info` (
  `id` bigint(8) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(8) NOT NULL,
  `account_num` varchar(8) NOT NULL,
  `project_code` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `expire_date` date NOT NULL,
  `proportion` bigint(3) NOT NULL,
  `last_update_date` date NOT NULL,
  `changed_by` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;

/*Data for the table `binding_info` */

insert  into `binding_info`(`id`,`member_id`,`account_num`,`project_code`,`start_date`,`expire_date`,`proportion`,`last_update_date`,`changed_by`) values (26,45,'21020401','P-0001','2023-11-08','2024-12-01',100,'2023-11-08','21020400'),(27,46,'21020402','P-0001','2023-11-08','2024-12-01',100,'2023-11-08','21020400'),(30,49,'21020405','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400'),(31,50,'21020406','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400'),(32,51,'21020407','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400'),(33,52,'21020408','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400'),(34,53,'21020409','P-0003','2023-11-08','2024-12-01',100,'2023-11-08','21020400'),(59,47,'21020403','P-0001','2023-11-12','2024-11-12',100,'2023-11-12','21020401'),(60,48,'21020404','P-0001','2023-11-27','2025-11-27',50,'2023-11-27','21020400'),(61,48,'21020404','P-0002','2023-11-27','2025-11-27',50,'2023-11-27','21020400');

/*Table structure for table `binding_info_log` */

DROP TABLE IF EXISTS `binding_info_log`;

CREATE TABLE `binding_info_log` (
  `seq_id` bigint(8) NOT NULL AUTO_INCREMENT,
  `id` bigint(8) NOT NULL,
  `member_id` bigint(8) NOT NULL,
  `account_num` varchar(8) NOT NULL,
  `project_code` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `proportion` bigint(3) DEFAULT NULL,
  `last_update_date` date NOT NULL,
  `changed_by` varchar(100) NOT NULL,
  `action` varchar(100) NOT NULL,
  PRIMARY KEY (`seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=latin1;

/*Data for the table `binding_info_log` */

insert  into `binding_info_log`(`seq_id`,`id`,`member_id`,`account_num`,`project_code`,`start_date`,`expire_date`,`proportion`,`last_update_date`,`changed_by`,`action`) values (67,26,45,'21020401','P-0001','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(68,27,46,'21020402','P-0001','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(69,28,47,'21020403','P-0001','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(70,29,48,'21020404','P-0001','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(71,30,49,'21020405','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(72,31,50,'21020406','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(73,32,51,'21020407','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(74,33,52,'21020408','P-0002','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(75,34,53,'21020409','P-0003','2023-11-08','2024-12-01',100,'2023-11-08','21020400','Insert'),(76,35,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(77,36,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(78,37,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(79,38,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(80,39,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(81,40,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(82,41,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(83,42,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(84,43,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(85,44,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(86,45,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(87,46,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(88,47,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(89,48,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(90,49,48,'21020404','P-0001','2023-11-11','2024-11-11',50,'2023-11-11','21020400','Insert'),(91,50,48,'21020404','P-0002','2023-11-11','2024-11-11',50,'2023-11-11','21020400','Insert'),(92,51,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(93,52,48,'21020404','P-0001','2023-11-11','2024-11-11',50,'2023-11-11','21020400','Insert'),(94,53,48,'21020404','P-0005','2023-11-11','2024-11-11',50,'2023-11-11','21020400','Insert'),(95,54,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(96,55,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(97,56,48,'21020404','P-0001','2023-11-11','2024-11-11',50,'2023-11-11','21020400','Insert'),(98,57,48,'21020404','P-0002','2023-11-11','2024-11-11',50,'2023-11-11','21020400','Insert'),(99,58,48,'21020404','P-0001','2023-11-11','2024-11-11',100,'2023-11-11','21020400','Insert'),(100,59,54,'21020410','P-0001','2023-11-08','2024-12-01',100,'2023-11-11','21020400','Insert'),(101,60,55,'21020410','P-0001','2023-11-08','2024-12-01',100,'2023-11-11','21020400','Insert'),(102,59,47,'21020403','P-0001','2023-11-12','2024-11-12',100,'2023-11-12','21020401','Insert'),(103,60,48,'21020404','P-0001','2023-11-27','2025-11-27',50,'2023-11-27','21020400','Insert'),(104,61,48,'21020404','P-0002','2023-11-27','2025-11-27',50,'2023-11-27','21020400','Insert');

/*Table structure for table `member_info` */

DROP TABLE IF EXISTS `member_info`;

CREATE TABLE `member_info` (
  `id` bigint(8) NOT NULL AUTO_INCREMENT,
  `name_zh` varchar(100) NOT NULL,
  `name_cn` varchar(100) NOT NULL,
  `account_num` varchar(8) NOT NULL,
  `manager_id` varchar(8) DEFAULT NULL,
  `perm` varchar(1) NOT NULL,
  `join_date` date DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `last_updated_date` date DEFAULT NULL,
  `auth_of_backend` varchar(1) NOT NULL,
  `delete_flag` varchar(1) NOT NULL,
  `email_address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_zh` (`name_zh`),
  UNIQUE KEY `name_cn` (`name_cn`),
  UNIQUE KEY `account_num` (`account_num`),
  UNIQUE KEY `email_address` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

/*Data for the table `member_info` */

insert  into `member_info`(`id`,`name_zh`,`name_cn`,`account_num`,`manager_id`,`perm`,`join_date`,`expired_date`,`last_updated_date`,`auth_of_backend`,`delete_flag`,`email_address`) values (44,'Admin','Admin','21020400',NULL,'Y','2023-11-08','2099-01-01','2023-11-08','Y','N','orjujeng@hotmail.com'),(45,'Audi','Audi','21020401','null','Y','2023-11-08','2024-12-01','2023-11-22','Y','N','orjujeng@gmail.com'),(46,'Lamborghini','Lamborghini','21020402','45','Y','2023-11-08','2024-12-01','2023-11-29','N','N',NULL),(47,'Ducati','Ducati','21020403','45','Y','2023-11-12','2024-12-01','2023-11-12','Y','N',NULL),(48,'Jetta','Jetta','21020404','null','Y','2023-11-11','2025-11-11','2023-11-25','Y','N',NULL),(49,'Volvo','Volvo','21020405','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','N',NULL),(50,'Daimler','Daimler','21020406','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','N',NULL),(51,'Mercedes Benz','Mercedes Benz','21020407','50','Y','2023-11-08','2024-12-01','2023-11-08','N','N',NULL),(52,'Mercedes Maybach','Mercedes Maybach','21020408','50','Y','2023-11-08','2024-12-01','2023-11-08','N','N',NULL),(53,'Subaru','Subaru','21020409','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','N',NULL);

/*Table structure for table `member_info_log` */

DROP TABLE IF EXISTS `member_info_log`;

CREATE TABLE `member_info_log` (
  `seq_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` bigint(8) NOT NULL,
  `account_num` varchar(8) NOT NULL,
  `name_zh` varchar(100) DEFAULT NULL,
  `name_cn` varchar(100) DEFAULT NULL,
  `manager_id` varchar(100) DEFAULT NULL,
  `perm` varchar(1) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `last_updated_date` date DEFAULT NULL,
  `auth_of_backend` varchar(1) DEFAULT NULL,
  `update_by` varchar(100) NOT NULL,
  `action` varchar(100) NOT NULL,
  `delete_flag` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=latin1;

/*Data for the table `member_info_log` */

insert  into `member_info_log`(`seq_id`,`id`,`account_num`,`name_zh`,`name_cn`,`manager_id`,`perm`,`join_date`,`expired_date`,`last_updated_date`,`auth_of_backend`,`update_by`,`action`,`delete_flag`) values (115,45,'21020401','Audi','Audi','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','Profile Api','Insert','N'),(116,46,'21020402','Lamborghini','Lamborghini','45','Y','2023-11-08','2024-12-01','2023-11-08','N','Profile Api','Insert','N'),(117,47,'21020403','Ducati','Ducati','45','Y','2023-11-08','2024-12-01','2023-11-08','N','Profile Api','Insert','N'),(118,48,'21020404','Jetta','Jetta','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','Profile Api','Insert','N'),(119,49,'21020405','Volvo','Volvo','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','Profile Api','Insert','N'),(120,50,'21020406','Daimler','Daimler','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','Profile Api','Insert','N'),(121,51,'21020407','Mercedes Benz','Mercedes Benz','50','Y','2023-11-08','2024-12-01','2023-11-08','N','Profile Api','Insert','N'),(122,52,'21020408','Mercedes Maybach','Mercedes Maybach','50','Y','2023-11-08','2024-12-01','2023-11-08','N','Profile Api','Insert','N'),(123,53,'21020409','Subaru','Subaru','null','Y','2023-11-08','2024-12-01','2023-11-08','Y','Profile Api','Insert','N'),(124,48,'21020404',NULL,NULL,NULL,'N',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(125,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(126,48,'21020404',NULL,NULL,NULL,'','2023-11-11',NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(127,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(128,48,'21020404',NULL,NULL,NULL,NULL,NULL,'2025-11-11','2023-11-11',NULL,'Profile Api','Update','N'),(129,48,'21020404',NULL,NULL,NULL,'',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(130,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(131,48,'21020404',NULL,NULL,NULL,'',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(132,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(133,48,'21020404',NULL,NULL,NULL,'',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(134,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(135,48,'21020404',NULL,NULL,NULL,'N',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(136,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(137,48,'21020404',NULL,NULL,NULL,'N',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(138,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(139,54,'21020410','testing','testing','null','Y','2023-11-08','2024-12-01','2023-11-11','Y','Profile Api','Insert','N'),(140,55,'21020410','Loyal,Ju','chuankunJu','null','Y','2023-11-06','2024-12-01','2023-11-11','Y','Profile Api','Insert','N'),(141,48,'21020404',NULL,NULL,NULL,'N',NULL,NULL,'2023-11-11',NULL,'Profile Api','Update','N'),(142,47,'21020403',NULL,NULL,NULL,'N',NULL,NULL,'2023-11-12',NULL,'Profile Api','Update','N'),(143,47,'21020403',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-12',NULL,'Profile Api','Update','N'),(144,47,'21020403',NULL,NULL,NULL,NULL,'2023-11-12',NULL,'2023-11-12',NULL,'Profile Api','Update','N'),(145,45,'21020401',NULL,NULL,NULL,NULL,NULL,'2023-11-21','2023-11-22',NULL,'Profile Api','Update','N'),(146,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-25','N','Profile Api','Update','N'),(147,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-25','Y','Profile Api','Update','N'),(148,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-25','N','Profile Api','Update','N'),(149,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-25','Y','Profile Api','Update','N'),(150,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-25','N','Profile Api','Update','N'),(151,48,'21020404',NULL,NULL,NULL,'Y',NULL,NULL,'2023-11-25',NULL,'Profile Api','Update','N'),(152,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-29','N','Profile Api','Update','N'),(153,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-29','Y','Profile Api','Update','N'),(154,46,'21020402',NULL,NULL,NULL,NULL,NULL,NULL,'2023-11-29','N','Profile Api','Update','N');

/*Table structure for table `project_info` */

DROP TABLE IF EXISTS `project_info`;

CREATE TABLE `project_info` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `project_code` varchar(100) NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `last_updated_date` date NOT NULL,
  `expire_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_code` (`project_code`),
  UNIQUE KEY `project_name` (`project_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `project_info` */

insert  into `project_info`(`id`,`project_code`,`project_name`,`last_updated_date`,`expire_date`) values (10,'P-0001','Volkswagen','2023-11-08','2025-01-01'),(11,'P-0002','Geely','2023-11-08','2025-01-01'),(12,'P-0003','Toyota','2023-11-08','2025-01-01');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
