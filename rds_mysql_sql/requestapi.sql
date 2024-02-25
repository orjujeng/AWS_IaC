/*
SQLyog Ultimate v11.25 (64 bit)
MySQL - 5.7.43 : Database - REQUEST_API
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`REQUEST_API` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `REQUEST_API`;

/*Table structure for table `request_info` */

DROP TABLE IF EXISTS `request_info`;

CREATE TABLE `request_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_num` varchar(8) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `member_name` varchar(200) NOT NULL,
  `request_type` varchar(200) NOT NULL,
  `request_date` date NOT NULL,
  `request_status` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `request_info` */

insert  into `request_info`(`id`,`account_num`,`member_id`,`member_name`,`request_type`,`request_date`,`request_status`) values (1,'21020402',46,'Lamborghini','Timesheet Backend Auth','2023-11-24','A'),(2,'21020402',46,'Lamborghini','Timesheet Backend Auth','2023-11-29','A'),(3,'21020403',47,'Ducati','Timesheet Backend Auth','2023-11-29','A');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
