/* zajecia 2 */

USE moviesrental;
SELECT * FROM moviescopies;
SELECT * FROM rents;
SELECT * FROM customers;



/* 1. Dla projektu wypożyczalni filmów zdefiniuj trigger, który przy wypożyczeniu zwiększa o 1 licznik wypożyczeń filmu. */

ALTER TABLE moviescopies 
ADD COLUMN rentedTimes INT NOT NULL DEFAULT 0;

DELIMITER $$
CREATE TRIGGER before_moviescopies_update    
	BEFORE UPDATE ON moviescopies
    FOR EACH ROW
BEGIN
    IF (OLD.isRented = FALSE AND NEW.isRented = TRUE) THEN
        SET NEW.rentedTimes = OLD.rentedTimes + 1;
    END IF;    
END
$$ DELIMITER ;

#DROP TRIGGER before_moviescopies_isRented_update;

#UPDATE rents SET returnedDate=NULL;

SHOW TRIGGERS;

/*symulate trigger*/
UPDATE moviescopies SET isRented=TRUE WHERE copyID = 1;


/* 2. Zdefiniuj trigger, który przy rejestracji wypożyczenia ustawia stan “wypożyczony”
dla danej kopii filmu (odwrotnie przy zwrocie). */
DELIMITER $$
CREATE TRIGGER before_moviescopies_isRented_update    
	BEFORE UPDATE ON moviescopies
    FOR EACH ROW PRECEDES before_moviescopies_update
BEGIN
    IF (OLD.rentedTo IS NULL AND NEW.rentedTo IS NOT NULL) THEN
        SET NEW.isRented = true;
	END IF;
    IF (OLD.rentedTo IS NOT NULL AND NEW.rentedTo IS NULL) THEN
		SET NEW.isRented = false;
    END IF;    
END
$$ DELIMITER ;

#DROP TRIGGER before_moviescopies_isRented_update;

/*symulate trigger*/
UPDATE moviescopies SET rentedTo=1 WHERE copyID = 4;


/* 3. Zmień tabelę i zdefiniuj trigger, który przy rejestracji zwrotu wylicza
należność za wypożyczenie. */

ALTER TABLE rents 
MODIFY COLUMN totalPrice DECIMAL(6,2) AFTER rentPricePerDay;

DELIMITER $$
CREATE TRIGGER before_rents_update    
	BEFORE UPDATE ON rents
    FOR EACH ROW 
BEGIN
    IF (OLD.returnedDate IS NULL AND NEW.returnedDate IS NOT NULL) THEN
        SET NEW.totalPrice = NEW.rentPricePerDay * DATEDIFF(NEW.returnedDate, OLD.rentedDate);
	END IF;
END
$$ DELIMITER ;

/*symulate trigger*/
UPDATE rents SET returnedDate = '2018-01-22' WHERE rentID=2;

UPDATE rents SET rentedDate = '2018-01-20';

UPDATE rents SET totalPrice=null;


/* ------------------------------------------------------------------------------
---------- PROCEDURY ------------------------------------------------------------
---------------------------------------------------------------------------------*/

/* Napisz procedurę, która dla podanego klienta zwróci informację o tym,
ile filmów do tej pory wypożyczył oraz ile aktualnie wypożycza. */

SELECT count(*) FROM rents WHERE customer = 1;

DELIMITER $$
CREATE PROCEDURE ShowStatus(
	IN custID VARCHAR(25),
    OUT rentedCount INT,
    OUT rentingCount INT
)
BEGIN
	SELECT count(*)
    INTO rentedCount
    FROM rents
    WHERE  customer = custID AND  status = 'Returned';
	SELECT count(*)
    INTO rentingCount
    FROM rents
    WHERE status = 'In rent';
END$$
DELIMITER ;    

#DROP PROCEDURE ShowStatus;

/* call procedure */

CALL ShowStatus(1, @rentedCount,@rentingCount);
SELECT @rentedCount,@rentingCount;
    
    
/* show */ 
SHOW PROCEDURE STATUS WHERE db = 'moviesrental';
SHOW CREATE PROCEDURE ShowStatus;

/* ------------------------------------------------------------------------------
---------- FUNKCJE --------------------------------------------------------------
---------------------------------------------------------------------------------*/

/* cw 25 
Napisz funkcję, która wylicza cenę za dzień wypożyczenia filmu wg relacji:
- jeśli od daty wydania nie upłynęły 2 tygodnie, 10 zł,
- jeśli między 2 tygodnie a 6 miesięcy, 5 zł,
- jeśli powyżej 6 miesięcy, 2,50 zł.
Sprawdź działanie funkcji dla każdego filmu znajdującego się w bazie. */

DELIMITER %%
CREATE FUNCTION countPrice(p_releaseDate DATE)
	RETURNS DOUBLE
	DETERMINISTIC
BEGIN
	DECLARE price DECIMAL;
    DECLARE daysCount INT;
    SET daysCount = DATEDIFF(curdate() - p_releaseDate);
    
    IF(daysCount < 14) THEN SET price = 10;
    ELSEIF(daysCount >=14 AND daysCount <=180) THEN SET price = 5;
    ELSE SET price = 2.5;
    END IF;
    
RETURN (price);
END%%
DELIMITER 

SELECT * FROM 