SELECT * FROM moviescopies;
SELECT * FROM rents;

SHOW TRIGGERS;

SELECT curdate();


DELIMITER $$
CREATE TRIGGER rents_BEFORE_INSERT BEFORE INSERT ON rents FOR EACH ROW
BEGIN
UPDATE moviescopies SET rentedTo=new.customer WHERE copyID=new.rentedMovieId;
SET NEW.rentedDate=(SELECT curdate());
SET NEW.status='In rent';
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_rents_update BEFORE UPDATE ON rents FOR EACH ROW BEGIN
SET @countDays = DATEDIFF(NEW.returnedDate, OLD.rentedDate);
    IF (OLD.returnedDate IS NULL AND NEW.returnedDate IS NOT NULL) THEN 
		IF (@countDays>0) THEN
			SET NEW.totalPrice = NEW.rentPricePerDay * DATEDIFF(NEW.returnedDate, OLD.rentedDate);
		ELSE SET NEW.totalPrice = NEW.rentPricePerDay ;	
        END IF;
        SET NEW.status = 'Returned';
        UPDATE moviescopies SET isRented=false,rentedTo=NULL WHERE copyID=NEW.rentedMovieId;
	END IF;
END
$$
DELIMITER ;