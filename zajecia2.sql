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
    FOR EACH ROW FOLLOWS before_moviescopies_update
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
UPDATE moviescopies SET rentedTo=1 WHERE copyID = 3;


/* 3. Zmień tabelę i zdefiniuj trigger, który przy rejestracji zwrotu wylicza
należność za wypożyczenie. */

ALTER TABLE rents 
ADD COLUMN totalPrice DECIMAL(5,2) NOT NULL DEFAULT 0;
