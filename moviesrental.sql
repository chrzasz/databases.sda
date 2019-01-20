SHOW DATABASES;

DROP DATABASE moviesrental;

CREATE DATABASE IF NOT EXISTS moviesrental;

USE moviesrental;


CREATE TABLE IF NOT EXISTS customers(
customerId INT(11) NOT NULL AUTO_INCREMENT,
fullName VARCHAR(255),
phone VARCHAR(31),
email VARCHAR(255),
address VARCHAR(511),
PRIMARY KEY (customerId)
);

CREATE TABLE IF NOT EXISTS moviesInfo(
movieInfoId INT(11) NOT NULL AUTO_INCREMENT,
title VARCHAR(100),
genre VARCHAR(50),
releaseDate DATE,
movieDescription TEXT,
PRIMARY KEY (movieInfoId)
);


CREATE TABLE IF NOT EXISTS moviesCopies(
copyId INT(11) NOT NULL AUTO_INCREMENT,
movieInfoId INT(11) NOT NULL, #(FK: moviesInfo -> movieInfoId)
isRented BOOLEAN DEFAULT false,
rentedTo INT(11), #(FK: customers -> customerId)
PRIMARY KEY (copyId),
CONSTRAINT fk_movieInfoId FOREIGN KEY(movieInfoId)
REFERENCES moviesInfo (movieInfoId),
CONSTRAINT fk_rentedTo FOREIGN KEY(rentedTo)
REFERENCES customers (customerId)
);


CREATE TABLE IF NOT EXISTS rents(
rentId INT(11) NOT NULL AUTO_INCREMENT,
rentedMovieId INT(11) NOT NULL, #(FK: moviesCopies -> copyId)
customer INT(11) NOT NULL, #(FK: customers -> customerId)
rentStatus ENUM('In rent','Returned') NOT NULL DEFAULT 'Returned',
rentPricePerDay DECIMAL(2,2) NOT NULL,
rentedDate DATE NOT NULL,
returnedDate DATE NOT NULL, 
MessageInput VARCHAR(255),
PRIMARY KEY (rentId),
CONSTRAINT fk_moviesCopies FOREIGN KEY(rentedMovieId)
REFERENCES moviesCopies (copyId),
CONSTRAINT fk_customer FOREIGN KEY(customer)
REFERENCES customers (customerId)

);

SELECT * FROM moviesInfo;
SELECT * FROM customers;
SELECT * FROM moviesCopies;

DROP TABLE moviesCopies;

/* ENGINE=INNODB */

/*
*moviesCopies*
copyId
movieInfoId (FK: moviesInfo -> movieInfoId)
isRented
rentedTo (FK: customers -> customerId)

*moviesInfo*
movieInfoId
title
genre
releaseDate
description

*customers*
customerId
fullName
phone
email
address

*rents*
rentId
rentedMovieId (FK: moviesCopies -> copyId)
customer (FK: customers -> customerId)
status //'In rent', 'Returned'
rentPricePerDay
rentedDate
returnedDate (edited) 
Message Input
*/




