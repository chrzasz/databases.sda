USE moviesRental;
SHOW CREATE TABLE customers;
/*
'CREATE TABLE `customers` (
  `customerId` int(7) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(255) NOT NULL,
  `phone` varchar(31) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(511) DEFAULT NULL,
  PRIMARY KEY (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
*/

SET autocommit = 0;

show global variables like 'autocommit';