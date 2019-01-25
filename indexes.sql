/* Cw 20 
W bazie classicmodels przeszukaj kolumnę nieindeksowaną z użyciem operatora LIKE.
Następnie nałóż na tę samą kolumnę indeks FULL TEXT. Ponów wyszukiwanie tego samego tekstu przy
pomocy operatorów MATCH AGAINST. Jaka jest różnica w czasie wyszukiwania?
Podpowiedź: Aby sprawdzić, czy tabela ma indeks(y) FULL TEXT, wykonaj operację
SHOW CREATE TABLE database_name.table_name */

USE classicmodels;

#check indexes:
SHOW CREATE TABLE classicmodels.products;

/*
'CREATE TABLE `products` (
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` text NOT NULL,
  `quantityInStock` smallint(6) NOT NULL,
  `buyPrice` decimal(10,2) NOT NULL,
  `MSRP` decimal(10,2) NOT NULL,
  PRIMARY KEY (`productCode`),
  KEY `productLine` (`productLine`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`productLine`) REFERENCES `productlines` (`productline`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1'
*/

#check speed:
SELECT * FROM products WHERE productDescription LIKE '%wheel%';
SELECT * FROM products WHERE productName LIKE '196%';

ALTER TABLE products
ADD FULLTEXT(productDescription);

SELECT productDescription FROM products WHERE MATCH(productDescription) AGAINST('wheel,wheels');

/*

0 row(s) affected, 1 warning(s): 124 InnoDB rebuilding table to add column FTS_DOC_ID Records: 0  Duplicates: 0  Warnings: 1


'CREATE TABLE `products` (
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` text NOT NULL,
  `quantityInStock` smallint(6) NOT NULL,
  `buyPrice` decimal(10,2) NOT NULL,
  `MSRP` decimal(10,2) NOT NULL,
  PRIMARY KEY (`productCode`),
  KEY `productLine` (`productLine`),
  FULLTEXT KEY `productDescription` (`productDescription`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`productLine`) REFERENCES `productlines` (`productline`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1'
*/

