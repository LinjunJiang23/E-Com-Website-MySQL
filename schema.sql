-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: E_COM
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

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

--
-- Table structure for table `Billing_Address`
--

DROP TABLE IF EXISTS `Billing_Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Billing_Address` (
  `billing_address_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `fname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `address_line_1` varchar(50) DEFAULT NULL,
  `address_line_2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `postal_code` varchar(5) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  PRIMARY KEY (`billing_address_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Billing_Address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Coupon`
--

DROP TABLE IF EXISTS `Coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Coupon` (
  `coupon_code` varchar(20) NOT NULL,
  `usage_limit` int DEFAULT NULL,
  `total_usage` bigint DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`coupon_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `salt` varchar(32) DEFAULT NULL,
  `hashed_password` varchar(255) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `billing_address_id` int DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `customer_status` enum('active','inactive','suspended','closed') DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `newsletter_subscription` tinyint(1) DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `notification_preferences` json DEFAULT NULL,
  `security_question_1_index` int DEFAULT NULL,
  `security_question_1_answer` varchar(255) DEFAULT NULL,
  `security_question_2_index` int DEFAULT NULL,
  `Security_question_2_answer` varchar(255) DEFAULT NULL,
  `membership_level` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `billing_address_id` (`billing_address_id`),
  CONSTRAINT `Customer_ibfk_1` FOREIGN KEY (`billing_address_id`) REFERENCES `Billing_Address` (`billing_address_id`),
  CONSTRAINT `Customer_ibfk_2` FOREIGN KEY (`billing_address_id`) REFERENCES `Billing_Address` (`billing_address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Discount`
--

DROP TABLE IF EXISTS `Discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Discount` (
  `discount_id` int NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(20) DEFAULT NULL,
  `dis_type` varchar(20) DEFAULT NULL,
  `dis_amount` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `usage_time` int DEFAULT NULL,
  `discount_status` enum('active','suspended','used','inactive','archived','expired') DEFAULT NULL,
  `applicable_rules` text,
  `restrictions` text,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`discount_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Discount_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Dispute`
--

DROP TABLE IF EXISTS `Dispute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dispute` (
  `dispute_id` int NOT NULL AUTO_INCREMENT,
  `dispute_status` enum('open','resolved','closed') DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `priority` enum('high','low','medium') DEFAULT NULL,
  `resolution` text,
  `comment` text,
  `assigned_to` varchar(50) DEFAULT NULL,
  `type` enum('product return','refund request','service complaint') DEFAULT NULL,
  `resolution_method` enum('refund issued','replacement sent','discount offered') DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `review_id` int DEFAULT NULL,
  PRIMARY KEY (`dispute_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  KEY `payment_id` (`payment_id`),
  KEY `review_id` (`review_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `Dispute_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`),
  CONSTRAINT `Dispute_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
  CONSTRAINT `Dispute_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `Payment` (`payment_id`),
  CONSTRAINT `Dispute_ibfk_4` FOREIGN KEY (`order_id`) REFERENCES `Shopping_Order` (`order_id`),
  CONSTRAINT `Dispute_ibfk_5` FOREIGN KEY (`review_id`) REFERENCES `Review` (`review_id`),
  CONSTRAINT `Dispute_ibfk_6` FOREIGN KEY (`order_id`) REFERENCES `Shopping_Order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `emply_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `salt` varchar(32) DEFAULT NULL,
  `hashed_password` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `position` varchar(20) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `employee_status` enum('Active','Inactive','Full-Time','Part-Time','Intern') DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `emply_num` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`emply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Order_Item`
--

DROP TABLE IF EXISTS `Order_Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_Item` (
  `order_product_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `per_price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `dispute_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `review_id` int DEFAULT NULL,
  `discount_code` varchar(255) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `item_status` enum('shipped','returned','refuned','canceled','completed','pending_return','pending_refund','in_transit') DEFAULT NULL,
  PRIMARY KEY (`order_product_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  KEY `variant_id` (`variant_id`),
  KEY `review_id` (`review_id`),
  KEY `dispute_id` (`dispute_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `Order_Item_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`),
  CONSTRAINT `Order_Item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
  CONSTRAINT `Order_Item_ibfk_3` FOREIGN KEY (`variant_id`) REFERENCES `Product_Variant` (`variant_id`),
  CONSTRAINT `Order_Item_ibfk_4` FOREIGN KEY (`review_id`) REFERENCES `Review` (`review_id`),
  CONSTRAINT `Order_Item_ibfk_5` FOREIGN KEY (`dispute_id`) REFERENCES `Dispute` (`dispute_id`),
  CONSTRAINT `Order_Item_ibfk_6` FOREIGN KEY (`order_id`) REFERENCES `Shopping_Order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `payment_token` varchar(50) DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_status` enum('pending','paid','failed') DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Shopping_Order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `product_name` varchar(75) DEFAULT NULL,
  `product_id` int NOT NULL AUTO_INCREMENT,
  `img_url` text,
  `total_sales` bigint DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT NULL,
  `description` text,
  `brand` varchar(30) DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  `product_added_date` date DEFAULT NULL,
  `product_status` enum('active','inactive','out of stock') DEFAULT NULL,
  `weight` decimal(8,2) DEFAULT NULL,
  `length` decimal(8,2) DEFAULT NULL,
  `width` decimal(8,2) DEFAULT NULL,
  `height` decimal(8,2) DEFAULT NULL,
  `meta_description` text,
  `keywords` varchar(255) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Product_Variant`
--

DROP TABLE IF EXISTS `Product_Variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product_Variant` (
  `variant_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `size` varchar(5) DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  `variant_sku` varchar(13) DEFAULT NULL,
  `material` varchar(50) DEFAULT NULL,
  `pattern` varchar(50) DEFAULT NULL,
  `style` varchar(50) DEFAULT NULL,
  `variant_status` varchar(20) DEFAULT NULL,
  `variant_added_date` date DEFAULT NULL,
  `variant_meta_description` text,
  `variant_keywords` varchar(255) DEFAULT NULL,
  `variant_meta_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`variant_id`),
  UNIQUE KEY `variant_sku` (`variant_sku`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Product_Variant_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT NULL,
  `review` text,
  `review_date` date DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`),
  CONSTRAINT `Review_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SFL_item`
--

DROP TABLE IF EXISTS `SFL_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SFL_item` (
  `sfl_product_id` int NOT NULL AUTO_INCREMENT,
  `sfl_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `per_price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `discount_code` varchar(255) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `date_added` date DEFAULT NULL,
  PRIMARY KEY (`sfl_product_id`),
  KEY `product_id` (`product_id`),
  KEY `variant_id` (`variant_id`),
  KEY `sfl_id` (`sfl_id`),
  CONSTRAINT `SFL_item_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
  CONSTRAINT `SFL_item_ibfk_2` FOREIGN KEY (`variant_id`) REFERENCES `Product_Variant` (`variant_id`),
  CONSTRAINT `SFL_item_ibfk_3` FOREIGN KEY (`sfl_id`) REFERENCES `Save_For_Later` (`sfl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Save_For_Later`
--

DROP TABLE IF EXISTS `Save_For_Later`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Save_For_Later` (
  `sfl_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `date_saved` date DEFAULT NULL,
  PRIMARY KEY (`sfl_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Save_For_Later_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Section`
--

DROP TABLE IF EXISTS `Section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Section` (
  `section_id` int NOT NULL AUTO_INCREMENT,
  `section_name` varchar(255) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SectionItem`
--

DROP TABLE IF EXISTS `SectionItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SectionItem` (
  `section_item_id` int NOT NULL AUTO_INCREMENT,
  `section_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `section_name` varchar(255) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`section_item_id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `SectionItem_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `Section` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Security_Question`
--

DROP TABLE IF EXISTS `Security_Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Security_Question` (
  `question_id` int NOT NULL,
  `question` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Shipping`
--

DROP TABLE IF EXISTS `Shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shipping` (
  `shipping_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `recipient_name` varchar(70) DEFAULT NULL,
  `address_line_1` varchar(50) DEFAULT NULL,
  `address_line_2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `postal_code` varchar(5) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  PRIMARY KEY (`shipping_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Shipping_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Shopping_Cart`
--

DROP TABLE IF EXISTS `Shopping_Cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shopping_Cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `date_added` date DEFAULT NULL,
  `discount_code` varchar(255) DEFAULT NULL,
  `cart_status` enum('checked out','expired','pending payment','archived','active') DEFAULT NULL,
  `cart_total` decimal(10,2) DEFAULT NULL,
  `session_id` int DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `tax_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Shopping_Cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Shopping_Cart_Item`
--

DROP TABLE IF EXISTS `Shopping_Cart_Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shopping_Cart_Item` (
  `cart_product_id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `per_price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `discount_code` varchar(255) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `date_added` date DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`cart_product_id`),
  KEY `variant_id` (`variant_id`),
  KEY `cart_id` (`cart_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Shopping_Cart_Item_ibfk_1` FOREIGN KEY (`variant_id`) REFERENCES `Product_Variant` (`variant_id`),
  CONSTRAINT `Shopping_Cart_Item_ibfk_2` FOREIGN KEY (`cart_id`) REFERENCES `Shopping_Cart` (`cart_id`),
  CONSTRAINT `Shopping_Cart_Item_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Shopping_Order`
--

DROP TABLE IF EXISTS `Shopping_Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shopping_Order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `order_status` enum('placed','shipped','delivered','canceled') DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `order_total` decimal(10,2) DEFAULT NULL,
  `shipping_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `delivery_method` varchar(20) DEFAULT NULL,
  `delivery_tracking` varchar(50) DEFAULT NULL,
  `order_note` text,
  `discount_codes` varchar(50) DEFAULT NULL,
  `billing_address_id` int DEFAULT NULL,
  `dispute_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `billing_address_id` (`billing_address_id`),
  KEY `shipping_id` (`shipping_id`),
  KEY `payment_id` (`payment_id`),
  KEY `user_id` (`user_id`),
  KEY `dispute_id` (`dispute_id`),
  CONSTRAINT `Shopping_Order_ibfk_1` FOREIGN KEY (`billing_address_id`) REFERENCES `Billing_Address` (`billing_address_id`),
  CONSTRAINT `Shopping_Order_ibfk_2` FOREIGN KEY (`shipping_id`) REFERENCES `Shipping` (`shipping_id`),
  CONSTRAINT `Shopping_Order_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `Payment` (`payment_id`),
  CONSTRAINT `Shopping_Order_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`user_id`),
  CONSTRAINT `Shopping_Order_ibfk_5` FOREIGN KEY (`dispute_id`) REFERENCES `Dispute` (`dispute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-13 19:01:04
