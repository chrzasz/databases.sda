DROP DATABASE moviesRental;
CREATE DATABASE IF NOT EXISTS moviesRental; #operujemy na nowo utworzonej bazie danych
USE moviesRental;

#wazna kolejnosc tabel ze wzgledu na referowanie sie do kluczy obcych
CREATE TABLE IF NOT EXISTS customers (
   customerId INT(7) NOT NULL AUTO_INCREMENT,
   fullName VARCHAR(255) NOT NULL,
   phone VARCHAR(31) NOT NULL,
   email VARCHAR(255),
   address VARCHAR(511),
   PRIMARY KEY (customerId)
);

CREATE TABLE IF NOT EXISTS moviesInfo (
movieInfoId INT(7) NOT NULL AUTO_INCREMENT, #PK dla tej tabeli
title VARCHAR(511) NOT NULL,
genre VARCHAR(127) NOT NULL,
releaseDate DATE NOT NULL,
description TEXT, #uznalem ze moze byc nullem
PRIMARY KEY (movieInfoId) #PK dla tej kolumny
);


CREATE TABLE IF NOT EXISTS moviesCopies(
copyId INT(7) NOT NULL AUTO_INCREMENT,
movieInfoId INT(7) NOT NULL, #(FK: moviesInfo -> movieInfoId)
isRented BOOLEAN NOT NULL DEFAULT false,
rentedTo INT(7), #(FK: customers -> customerId)
PRIMARY KEY (copyId),
CONSTRAINT fk_movieInfoId FOREIGN KEY(movieInfoId)
REFERENCES moviesInfo (movieInfoId),
CONSTRAINT fk_rentedTo FOREIGN KEY(rentedTo)
REFERENCES customers (customerId)
);



CREATE TABLE IF NOT EXISTS rents (
   rentId INT(7) NOT NULL AUTO_INCREMENT,
   rentedMovieId INT(7) NOT NULL,
   customer INT(7) NOT NULL,
   status ENUM ('In rent', 'Returned') NOT NULL DEFAULT 'Returned',
   rentPricePerDay DECIMAL(4,2) NOT NULL,
   rentedDate DATE NOT NULL,
   returnedDate DATE,
   PRIMARY KEY (rentId),
   CONSTRAINT fk_rentedMovieId FOREIGN KEY (rentedMovieId) REFERENCES moviesCopies (copyId),
   CONSTRAINT fk_customer FOREIGN KEY (customer) REFERENCES customers (customerId)
);