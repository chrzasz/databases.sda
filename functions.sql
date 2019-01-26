USE moviesrental;


DELIMITER %%

CREATE FUNCTION getRentPricePerDay(releaseDate DATE) RETURNS DOUBLE

DETERMINISTIC #dla danej daty zawsze jeden wynik

BEGIN

    DECLARE price DOUBLE;

   DECLARE diffInDays INT;

   SET diffInDays = DATEDIFF(CURDATE(), releaseDate);    IF(diffInDays < 14)

   THEN SET price = 10;

   ELSEIF(diffInDays >= 14 AND diffInDays <= 180)

   THEN SET price = 5;

   ELSE SET price = 2.5;

   END IF;    return (price);

END%%

SELECT title, releaseDate, getRentPricePerDay(releaseDate) as rentPricePerDay

FROM moviesinfo;


INSERT INTO moviesinfo (title, releaseDate, genre)

VALUES('empty title', '2019-01-14', 'nothing');