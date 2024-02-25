/*
SQLyog Ultimate v11.25 (64 bit)
MySQL - 5.7.43 : Database - AUTH_API
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`AUTH_API` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `AUTH_API`;

/*Table structure for table `auth_access_info` */

DROP TABLE IF EXISTS `auth_access_info`;

CREATE TABLE `auth_access_info` (
  `id` bigint(8) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(8) NOT NULL,
  `auth_access` varchar(1) NOT NULL,
  `profile_access` varchar(1) NOT NULL,
  `timesheet_access` varchar(1) NOT NULL,
  `request_access` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Data for the table `auth_access_info` */

insert  into `auth_access_info`(`id`,`member_id`,`auth_access`,`profile_access`,`timesheet_access`,`request_access`) values (18,44,'Y','Y','Y','Y'),(19,45,'N','N','N','N'),(20,46,'N','N','N','N'),(21,47,'N','N','N','N'),(22,48,'N','N','N','N'),(23,49,'N','N','N','N'),(24,50,'N','N','N','N'),(25,51,'N','N','N','N'),(26,52,'N','N','N','N'),(27,53,'N','N','N','N');

/*Table structure for table `auth_info` */

DROP TABLE IF EXISTS `auth_info`;

CREATE TABLE `auth_info` (
  `id` bigint(8) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(8) NOT NULL,
  `account_num` varchar(100) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `termination` varchar(1) NOT NULL,
  `last_updated_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `auth_info` */

insert  into `auth_info`(`id`,`member_id`,`account_num`,`password`,`termination`,`last_updated_date`) values (16,44,'21020400','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(17,45,'21020401','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(18,46,'21020402','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(19,47,'21020403','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(20,48,'21020404','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(21,49,'21020405','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(22,50,'21020406','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(23,51,'21020407','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(24,52,'21020408','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08'),(25,53,'21020409','e1a7c4358706c6202e95d0356b9d7672','N','2023-11-08');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
