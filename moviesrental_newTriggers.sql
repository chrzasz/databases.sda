SELECT * FROM moviescopies;
SELECT * FROM rents;

SHOW TRIGGERS;

SELECT curdate();


DELIMITER $$
CREATE TRIGGER rents_BEFORE_INSERT BEFORE INSERT ON rents FOR EACH ROW
BEGIN
SET NEW.rentPricePerDay=(SELECT getRentPricePerDay(releaseDate) FROM moviesinfo WHERE movieInfoId=NEW.rentedMovieID);
SET NEW.rentedDate=(SELECT curdate());
SET NEW.rentStatus='In rent';
UPDATE moviescopies SET rentedTo=new.customer WHERE copyID=new.rentedMovieID;
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_rents_update BEFORE UPDATE ON rents FOR EACH ROW
BEGIN
SET @countDays = DATEDIFF(NEW.returnedDate, OLD.rentedDate);
    IF (OLD.returnedDate IS NULL AND NEW.returnedDate IS NOT NULL) THEN 
		IF (@countDays>0) THEN
			SET NEW.totalPrice = NEW.rentPricePerDay * DATEDIFF(NEW.returnedDate, OLD.rentedDate);
		ELSE SET NEW.totalPrice = NEW.rentPricePerDay ;	
        END IF;
        SET NEW.rentStatus = 'Returned';
        UPDATE moviescopies SET isRented=false,rentedTo=NULL WHERE copyID=NEW.rentedMovieID;
	ELSE
    SET NEW.rentStatus = 'In Rent';
    UPDATE moviescopies SET rentedTo=new.customer WHERE copyID=new.rentedMovieID;
	END IF;
END
$$
DELIMITER ;