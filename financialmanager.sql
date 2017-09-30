/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.6.17 : Database - financialmanager
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`financialmanager` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `financialmanager`;

/*Table structure for table `city` */

DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
  `cityID` char(36) NOT NULL COMMENT '城市ID',
  `city` varchar(50) NOT NULL COMMENT '城市',
  `cityOtherID` char(2) NOT NULL COMMENT '城市的补充ID',
  PRIMARY KEY (`cityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `city` */

insert  into `city`(`cityID`,`city`,`cityOtherID`) values ('2d709c68-87da-11e7-b0f8-708bcd7b61ba','成都','01'),('d8a616e6-87da-11e7-b0f8-708bcd7b61ba','上海','02'),('dc2d387e-87da-11e7-b0f8-708bcd7b61ba','重庆','03'),('e17edb43-a422-11e7-9463-1cb72c2f3c53','厦门','13');

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `id` char(36) NOT NULL COMMENT '部门ID',
  `city` char(36) NOT NULL COMMENT '城市',
  `department` varchar(50) NOT NULL COMMENT '部门',
  PRIMARY KEY (`id`),
  KEY `fk_city_department` (`city`),
  CONSTRAINT `fk_city_department` FOREIGN KEY (`city`) REFERENCES `city` (`cityID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`id`,`city`,`department`) values ('01599550-87de-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba','车贷一部'),('b86b45ba-87de-11e7-b0f8-708bcd7b61ba','dc2d387e-87da-11e7-b0f8-708bcd7b61ba','房贷一部'),('c0d2cdbd-87de-11e7-b0f8-708bcd7b61ba','dc2d387e-87da-11e7-b0f8-708bcd7b61ba','房贷二部'),('c4b92431-87de-11e7-b0f8-708bcd7b61ba','dc2d387e-87da-11e7-b0f8-708bcd7b61ba','房贷三部'),('cba0a8d7-87de-11e7-b0f8-708bcd7b61ba','d8a616e6-87da-11e7-b0f8-708bcd7b61ba','房贷一部'),('ceec0a07-87de-11e7-b0f8-708bcd7b61ba','d8a616e6-87da-11e7-b0f8-708bcd7b61ba','房贷二部'),('e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba','技术部'),('e9b06ca1-a422-11e7-9463-1cb72c2f3c53','e17edb43-a422-11e7-9463-1cb72c2f3c53','技术部'),('ee9ff826-a422-11e7-9463-1cb72c2f3c53','e17edb43-a422-11e7-9463-1cb72c2f3c53','财务部'),('f0a8c045-87dd-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba','财务部');

/*Table structure for table `eq_borrow_log` */

DROP TABLE IF EXISTS `eq_borrow_log`;

CREATE TABLE `eq_borrow_log` (
  `borrow_id` char(36) NOT NULL COMMENT '设备借调ID',
  `eq_id` char(36) DEFAULT NULL COMMENT '设备ID',
  `state` char(36) DEFAULT NULL COMMENT '状态',
  `use_by` char(36) DEFAULT NULL COMMENT '使用人',
  `do_time` date DEFAULT NULL COMMENT '操作时间',
  `use_by_depart` char(36) DEFAULT NULL COMMENT '使用部门',
  `detail` char(255) DEFAULT NULL COMMENT '详细',
  PRIMARY KEY (`borrow_id`),
  KEY `eqState_eqBorrowLog` (`state`),
  KEY `eqBorrowLog_equipment` (`eq_id`),
  KEY `user_eqBorrowLog` (`use_by`),
  KEY `department_eqBorrowLog` (`use_by_depart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eq_borrow_log` */

/*Table structure for table `eq_fix_log` */

DROP TABLE IF EXISTS `eq_fix_log`;

CREATE TABLE `eq_fix_log` (
  `id` char(36) NOT NULL,
  `fixTime` date NOT NULL,
  `fixType` varchar(50) NOT NULL,
  `fixDetail` varchar(300) NOT NULL,
  `eqId` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `eqFixLog_equipment` (`eqId`),
  CONSTRAINT `eqFixLog_equipment` FOREIGN KEY (`eqId`) REFERENCES `equipment` (`eq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eq_fix_log` */

/*Table structure for table `eq_name` */

DROP TABLE IF EXISTS `eq_name`;

CREATE TABLE `eq_name` (
  `eq_name_id` char(36) NOT NULL COMMENT '设备名称ID',
  `eq_name` varchar(50) NOT NULL COMMENT '设备名称',
  `eq_type_id` char(36) NOT NULL COMMENT '设备类型',
  PRIMARY KEY (`eq_name_id`),
  KEY `eqName_eqType` (`eq_type_id`),
  CONSTRAINT `eqName_eqType` FOREIGN KEY (`eq_type_id`) REFERENCES `eq_type` (`eq_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eq_name` */

insert  into `eq_name`(`eq_name_id`,`eq_name`,`eq_type_id`) values ('52bfbe2f-87b3-11e7-b0f8-708bcd7b61ba','台式电脑','fb8ca8f8-86e7-11e7-afa6-708bcd7b61ba'),('69df5c8f-87b3-11e7-b0f8-708bcd7b61ba','打印机','fb8ca8f8-86e7-11e7-afa6-708bcd7b61ba'),('74234779-87b3-11e7-b0f8-708bcd7b61ba','路由器','f832f659-86e7-11e7-afa6-708bcd7b61ba'),('78abeb6d-87b3-11e7-b0f8-708bcd7b61ba','交换机','f832f659-86e7-11e7-afa6-708bcd7b61ba'),('7c8651a2-87b3-11e7-b0f8-708bcd7b61ba','服务器','f832f659-86e7-11e7-afa6-708bcd7b61ba'),('837525e6-87b3-11e7-b0f8-708bcd7b61ba','内存条','f292d64a-86e7-11e7-afa6-708bcd7b61ba'),('898f1aab-87b3-11e7-b0f8-708bcd7b61ba','硬盘','f292d64a-86e7-11e7-afa6-708bcd7b61ba'),('e9947697-87b3-11e7-b0f8-708bcd7b61ba','笔记本电脑','fb8ca8f8-86e7-11e7-afa6-708bcd7b61ba'),('ee0ce648-9f6a-11e7-baa9-1cb72c2f3c53','光驱','f292d64a-86e7-11e7-afa6-708bcd7b61ba');

/*Table structure for table `eq_starff` */

DROP TABLE IF EXISTS `eq_starff`;

CREATE TABLE `eq_starff` (
  `staff_eq_id` char(36) NOT NULL COMMENT '员工设备ID',
  `eq_id` char(36) NOT NULL COMMENT '设备ID',
  `staff_id` char(36) NOT NULL COMMENT '员工ID',
  PRIMARY KEY (`staff_eq_id`),
  KEY `eqStaff_staff` (`staff_id`),
  KEY `eqStaff_equipment` (`eq_id`),
  CONSTRAINT `eqStaff_equipment` FOREIGN KEY (`eq_id`) REFERENCES `equipment` (`eq_id`),
  CONSTRAINT `eqStaff_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eq_starff` */

/*Table structure for table `eq_state` */

DROP TABLE IF EXISTS `eq_state`;

CREATE TABLE `eq_state` (
  `eq_state_id` char(36) NOT NULL COMMENT '设备状态ID',
  `state` char(10) NOT NULL COMMENT '状态',
  PRIMARY KEY (`eq_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eq_state` */

insert  into `eq_state`(`eq_state_id`,`state`) values ('56b7c7a1-9dce-11e7-94cf-1cb72c2f3c53','报废'),('d5a39eff-9acf-11e7-94cf-1cb72c2f3c53','闲置'),('e3d81c22-9acf-11e7-94cf-1cb72c2f3c53','使用');

/*Table structure for table `eq_type` */

DROP TABLE IF EXISTS `eq_type`;

CREATE TABLE `eq_type` (
  `eq_type_id` char(36) NOT NULL COMMENT '设备类型ID',
  `eq_type_name` varchar(50) NOT NULL COMMENT '设备类型',
  `eq_type_other_id` char(36) NOT NULL COMMENT '设备别名ID',
  PRIMARY KEY (`eq_type_id`),
  UNIQUE KEY `eq_type_name` (`eq_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `eq_type` */

insert  into `eq_type`(`eq_type_id`,`eq_type_name`,`eq_type_other_id`) values ('f292d64a-86e7-11e7-afa6-708bcd7b61ba','配件','01'),('f832f659-86e7-11e7-afa6-708bcd7b61ba','机房设备','02'),('fb8ca8f8-86e7-11e7-afa6-708bcd7b61ba','办公设备','03');

/*Table structure for table `equipment` */

DROP TABLE IF EXISTS `equipment`;

CREATE TABLE `equipment` (
  `eq_id` char(36) NOT NULL COMMENT '设备ID',
  `eq_type` varchar(50) NOT NULL COMMENT '设备类型',
  `eq_name` varchar(50) NOT NULL COMMENT '设备名称',
  `brand_name` varchar(50) NOT NULL COMMENT '品牌名称',
  `purchas_depart` varchar(50) NOT NULL COMMENT '采购部门',
  `belong_depart` varchar(50) NOT NULL COMMENT '归属部门',
  `purchas_date` date NOT NULL COMMENT '采购时间',
  `supplier` char(36) NOT NULL COMMENT '供应商',
  `eq_state` char(36) NOT NULL COMMENT '设备状态',
  `purchas_price` double NOT NULL COMMENT '采购价格',
  `custom_message` varchar(1024) DEFAULT NULL COMMENT '自定义信息',
  `eq_other_id` char(36) NOT NULL COMMENT '设备别名ID',
  `city` char(36) NOT NULL COMMENT '城市ID',
  `buyCity` char(36) NOT NULL COMMENT '购买城市',
  PRIMARY KEY (`eq_id`),
  KEY `purchasDepartment_equipment` (`purchas_depart`),
  KEY `belongDepartment_equipment` (`belong_depart`),
  KEY `eqState_equipment` (`eq_state`),
  KEY `supplier_equipment` (`supplier`),
  KEY `eqName_equipment` (`eq_name`),
  KEY `eqType_equipment` (`eq_type`),
  KEY `city_eq_fk` (`city`),
  CONSTRAINT `city_eq_fk` FOREIGN KEY (`city`) REFERENCES `city` (`cityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `equipment` */

insert  into `equipment`(`eq_id`,`eq_type`,`eq_name`,`brand_name`,`purchas_depart`,`belong_depart`,`purchas_date`,`supplier`,`eq_state`,`purchas_price`,`custom_message`,`eq_other_id`,`city`,`buyCity`) values ('0b61f283-a353-11e7-9463-1cb72c2f3c53','配件','硬盘','三星 G5','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-09-28','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',299,'','01010018','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('1cee0a8e-a262-11e7-9463-1cb72c2f3c53','机房设备','服务器','HP高性能服务器','f0a8c045-87dd-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-09-30','盐市口联想直营中心','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',300000,'','01020005','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('5e6ecfc6-a263-11e7-9463-1cb72c2f3c53','办公设备','笔记本电脑','HP高性能电脑','01599550-87de-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-10-05','盐市口联想直营中心','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',6999,'','01030006','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('5e6f4cf7-a263-11e7-9463-1cb72c2f3c53','办公设备','笔记本电脑','HP高性能电脑','01599550-87de-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-10-05','盐市口联想直营中心','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',6999,'','01030007','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('61239edd-a263-11e7-9463-1cb72c2f3c53','办公设备','笔记本电脑','HP高性能电脑','01599550-87de-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-10-05','盐市口联想直营中心','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',6999,'','01030008','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('6123e1a9-a263-11e7-9463-1cb72c2f3c53','办公设备','笔记本电脑','HP高性能电脑','01599550-87de-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-10-05','盐市口联想直营中心','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',6999,'','01030009','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('78be93f4-9c39-11e7-94cf-1cb72c2f3c53','配件','内存条','骇客神条 8G','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-09-28','金士顿','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',299,'','01010001','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('83f84b94-a261-11e7-9463-1cb72c2f3c53','配件','光驱','日本进口光驱','66b6e22a-a258-11e7-9463-1cb72c2f3c53','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-09-24','金士顿','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',1999,'','01010004','2d709c68-87da-11e7-b0f8-708bcd7b61ba','b15a4782-a1dc-11e7-9463-1cb72c2f3c53'),('a5003049-9c39-11e7-94cf-1cb72c2f3c53','配件','硬盘','HyperX Fury 发烧级固态硬盘','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-09-28','金士顿','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',755,'','01010002','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('b9eb25ef-9c39-11e7-94cf-1cb72c2f3c53','办公设备','笔记本电脑','华硕笔记本 W550JK','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','2017-08-28','华硕','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',4299,'','01030003','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('d5185932-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020010','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('d51936b5-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020011','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('d519b402-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020012','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('d51a2e17-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020013','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('e362121a-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020014','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('e3627688-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020015','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('e362bb3f-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020016','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('e3634553-a263-11e7-9463-1cb72c2f3c53','机房设备','路由器','TP-Link 302','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','01599550-87de-11e7-b0f8-708bcd7b61ba','2017-10-04','小米','d5a39eff-9acf-11e7-94cf-1cb72c2f3c53',199,'','01020017','2d709c68-87da-11e7-b0f8-708bcd7b61ba','2d709c68-87da-11e7-b0f8-708bcd7b61ba');

/*Table structure for table `maxvalue` */

DROP TABLE IF EXISTS `maxvalue`;

CREATE TABLE `maxvalue` (
  `key` char(36) NOT NULL COMMENT 'key',
  `value` char(36) NOT NULL COMMENT 'value',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `maxvalue` */

insert  into `maxvalue`(`key`,`value`) values ('cityMax','13');

/*Table structure for table `res` */

DROP TABLE IF EXISTS `res`;

CREATE TABLE `res` (
  `res_id` char(36) NOT NULL,
  `res_url` varchar(2048) NOT NULL,
  `res_description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `res` */

insert  into `res`(`res_id`,`res_url`,`res_description`) values ('1664ccf8-7d91-11e7-8499-708bcd7b61ba','/user.jsp','这是普通用户和管理员才能够访问的页面'),('2299841d-9918-11e7-94cf-1cb72c2f3c53','/user/index','主界面'),('2b4718af-7d91-11e7-8499-708bcd7b61ba','/admin.jsp','这是管理员才能够访问的页面'),('3433fbb9-a42e-11e7-9463-1cb72c2f3c53','/equipment/fieldManagerPage','这是管理员才能访问的页面'),('84c67ba4-a42e-11e7-9463-1cb72c2f3c53','/department/systemFieldManager','这是管理员才能访问的页面'),('ae52e885-a42e-11e7-9463-1cb72c2f3c53','/user/user/query','这是管理员才能访问的页面');

/*Table structure for table `res_role` */

DROP TABLE IF EXISTS `res_role`;

CREATE TABLE `res_role` (
  `res_r_id` char(36) NOT NULL,
  `res_id` char(36) NOT NULL,
  `r_id` char(36) NOT NULL,
  PRIMARY KEY (`res_r_id`),
  KEY `res_role_foreikey_res_id` (`res_id`),
  KEY `res_role_foreikey_r_id` (`r_id`),
  CONSTRAINT `res_role_foreikey_res_id` FOREIGN KEY (`res_id`) REFERENCES `res` (`res_id`),
  CONSTRAINT `res_role_foreikey_r_id` FOREIGN KEY (`r_id`) REFERENCES `role` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `res_role` */

insert  into `res_role`(`res_r_id`,`res_id`,`r_id`) values ('021f83c3-a42f-11e7-9463-1cb72c2f3c53','ae52e885-a42e-11e7-9463-1cb72c2f3c53','d0a93949-7ce2-11e7-9bb7-708bcd7b61ba'),('0d3842b8-7d92-11e7-8499-708bcd7b61ba','1664ccf8-7d91-11e7-8499-708bcd7b61ba','d0a93949-7ce2-11e7-9bb7-708bcd7b61ba'),('1c08f2a2-7d92-11e7-8499-708bcd7b61ba','2b4718af-7d91-11e7-8499-708bcd7b61ba','d0a93949-7ce2-11e7-9bb7-708bcd7b61ba'),('4574debb-9918-11e7-94cf-1cb72c2f3c53','2299841d-9918-11e7-94cf-1cb72c2f3c53','967bafbc-7cda-11e7-9bb7-708bcd7b61ba'),('7b974d03-9918-11e7-94cf-1cb72c2f3c53','2299841d-9918-11e7-94cf-1cb72c2f3c53','d0a93949-7ce2-11e7-9bb7-708bcd7b61ba'),('ec3434ed-7d91-11e7-8499-708bcd7b61ba','1664ccf8-7d91-11e7-8499-708bcd7b61ba','967bafbc-7cda-11e7-9bb7-708bcd7b61ba'),('f3d8959f-a42e-11e7-9463-1cb72c2f3c53','3433fbb9-a42e-11e7-9463-1cb72c2f3c53','d0a93949-7ce2-11e7-9bb7-708bcd7b61ba'),('fd83357e-a42e-11e7-9463-1cb72c2f3c53','84c67ba4-a42e-11e7-9463-1cb72c2f3c53','d0a93949-7ce2-11e7-9bb7-708bcd7b61ba');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `rid` char(36) NOT NULL,
  `rname` varchar(40) NOT NULL COMMENT '角色名称',
  `rdescription` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`rid`,`rname`,`rdescription`) values ('967bafbc-7cda-11e7-9bb7-708bcd7b61ba','ROLE_USER','普通登录账户'),('d0a93949-7ce2-11e7-9bb7-708bcd7b61ba','ROLE_ADMIN','管理员账户');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `id` char(36) NOT NULL COMMENT '员工ID',
  `name` varchar(30) NOT NULL COMMENT '姓名',
  `department` char(36) NOT NULL COMMENT '部门',
  `position` varchar(50) NOT NULL COMMENT '岗位',
  `tel` char(11) NOT NULL COMMENT '联系电话',
  `entry_time` date NOT NULL COMMENT '入职时间',
  `custom_message` varchar(1024) DEFAULT NULL COMMENT '自定义信息',
  `city` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `staff` */

insert  into `staff`(`id`,`name`,`department`,`position`,`tel`,`entry_time`,`custom_message`,`city`) values ('54ed41d8-98f1-11e7-94cf-1cb72c2f3c53','小雷','c0d2cdbd-87de-11e7-b0f8-708bcd7b61ba','Java开发工程师','18382949078','2017-09-21','','dc2d387e-87da-11e7-b0f8-708bcd7b61ba'),('66002c6c-98f4-11e7-94cf-1cb72c2f3c53','Joy','e8a049e3-87dc-11e7-b0f8-708bcd7b61ba','安卓开发高级工程师','18280469370','2017-09-19','性别=女;','2d709c68-87da-11e7-b0f8-708bcd7b61ba');

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `id` char(36) NOT NULL COMMENT '供应商ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `adtitude` char(30) NOT NULL COMMENT '资质',
  `address` varchar(300) NOT NULL COMMENT '地址',
  `contact_name` char(20) NOT NULL COMMENT '联系人',
  `tel` char(11) NOT NULL COMMENT '联系电话',
  `business` varchar(300) NOT NULL COMMENT '主营业务',
  `contract_time` date NOT NULL COMMENT '签约时间',
  `custom_message` varchar(1024) DEFAULT NULL COMMENT '自定义信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `supplier` */

insert  into `supplier`(`id`,`name`,`adtitude`,`address`,`contact_name`,`tel`,`business`,`contract_time`,`custom_message`) values ('041ca1ee-9bb8-11e7-94cf-1cb72c2f3c53','华硕','上市公司','北京市武城区','华天','19625846536','专业高性能笔记本','2017-04-29',''),('5fd908ce-986b-11e7-94cf-1cb72c2f3c53','小米','上市','北京市','雷军','18382949075','卖手机','2017-09-14',''),('7564f680-9b51-11e7-94cf-1cb72c2f3c53','金士顿','上市','北京市内城','HyperX','18382909576','存储介质','2015-06-12',''),('e7fa854a-88ad-11e7-8254-708bcd7b61ba','盐市口联想直营中心','已上市','成都市锦江区大业路6号上普财富中心16F03室公司','李四','13822223333','联想电脑全系列产品','2017-05-09',NULL);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `username` varchar(40) NOT NULL COMMENT '用户名',
  `password` varchar(30) NOT NULL COMMENT '密码',
  `city` char(36) NOT NULL COMMENT '城市',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`username`,`password`,`city`) values ('Admin','123456',''),('MoonFollow','123456','2d709c68-87da-11e7-b0f8-708bcd7b61ba'),('xiamen','123456','e17edb43-a422-11e7-9463-1cb72c2f3c53');

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `urid` char(36) NOT NULL,
  `username` char(36) NOT NULL,
  `rid` char(36) NOT NULL,
  PRIMARY KEY (`urid`),
  KEY `user_role_foreikey_username` (`username`),
  KEY `user_role_foreikey_rid` (`rid`),
  CONSTRAINT `user_role_foreikey_rid` FOREIGN KEY (`rid`) REFERENCES `role` (`rid`),
  CONSTRAINT `user_role_foreikey_username` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_role` */

insert  into `user_role`(`urid`,`username`,`rid`) values ('09d079b7-7ce3-11e7-9bb7-708bcd7b61ba','Admin','d0a93949-7ce2-11e7-9bb7-708bcd7b61ba'),('3417eeaf-7ce2-11e7-9bb7-708bcd7b61ba','MoonFollow','967bafbc-7cda-11e7-9bb7-708bcd7b61ba');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
