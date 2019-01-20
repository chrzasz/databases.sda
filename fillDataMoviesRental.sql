/*Cwiczenie 15

1. Zmodyfikuj tabelę rents tak, aby domyślną wartością dla pola status było ‘In progress’.
2. Uzupełnij bazę danych przykładowymi danymi, dodaj: 3 ulubione filmy, kilka ich fizycznych kopii,
przykładowego klienta, 2 wypożyczenia. Dla spójności, wprowadzaj dane po angielsku. Ułatw sobie życie,
skorzystaj z bazy IMDB: https://www.imdb.com/title/tt5491994/ Sprawdź, czy komendy poprawnie się
wykonują i podziel się z nimi z grupą na Slacku. UWAGA: jeśli skorzystaliście z mojego skryptu tworzącego
tabele, będziecie mieć 2 błędy logiczne – zidentyfikujcie je I poprawcie poprzez ALTER TABLE.

Cw 15 - ALTER TABLE:
1) W tabeli moviesCopies pole rentedTo musi byc zdefiniowane jako klucz obcy do tabeli customers, pole customerId
2) W tabeli rents - zgodnie z poleceniem pp 1
3) W tabeli rents - zmienic price na (4,2)
ad 1 -> ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
*/

ALTER TABLE moviesCopies
ADD FOREIGN KEY (rentedTo) REFERENCES customers(customerId);

ALTER TABLE rents ALTER status SET DEFAULT 'In rent';

ALTER TABLE rents
MODIFY rentPricePerDay DECIMAL(4,2) NOT NULL;rentPricePerDay

ALTER TABLE moviesCopies MODIFY rentedTo INT(7) NULL;

INSERT INTO moviesInfo(title,genre,releaseDate,description)
VALUES
('Mad Max: Fury Road',
'Sci-Fi',
CAST('2015-01-01' as DATE),
'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max.'
);

INSERT INTO moviesInfo(title,genre,releaseDate,description)
VALUES
('Alien: Covenant',
'Sci-Fi',
CAST('2017-05-19' as DATE),
'The crew of a colony ship, bound for a remote planet, discover an uncharted paradise with a threat beyond their imagination, and must attempt a harrowing escape.'
)
('Mad Max: Fury Road',
'Sci-Fi',
CAST('2015-05-15' as DATE),
'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max.'
)
;

#insert copies
INSERT INTO moviescopies(movieInfoId)
VALUES
(1),
(1),
(1),
(1),
(1),
(1),
(2),
(2),
(2)
;

INSERT INTO customers(fullName,phone,email,address)
VALUES
('Grzegorz Chrzaszczyk','+48123123123','email@email.com','Warsaw Bielany'),
('Adam Malysz','+48321321321','adam@malysz.pl','Wisla Malinka')
;


INSERT INTO rents(rentedMovieId,customer,status,rentPricePerDay,rentedDate,returnedDate)
VALUES
(1,1,'In rent','1.80',20190119,NULL),
(1,1,'In rent','2.20',curdate(),NULL),
(2,2,'In rent','2.99',curdate(),NULL)
;


INSERT INTO rents(rentedMovieId,customer,status,rentPricePerDay,rentedDate,returnedDate)
VALUES (2,2,'In rent','0.99','2019-01-16',NULL);


/*Cwiczenie 16
rents SET returnedDate
change status to 'Returned'
moviesCopies
isRented
rentedTo = NULL;
*/
UPDATE rents
SET returnedDate='2019-01-21';

UPDATE rents
SET status='Returned';

UPDATE moviesCopies
SET isRented=FALSE;

UPDATE moviesCopies
SET rentedTo=NULL;





