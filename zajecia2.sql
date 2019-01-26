/* zajecia 2 */

/*
1. Dla projektu wypożyczalni filmów zdefiniuj trigger, który przy wypożyczeniu zwiększa o 1 licznik wypożyczeń filmu.
Sprawdź na około 15 slajdów do przodu (“Procedury – Instrukcje warunkowe”) jak korzystać z IF-ELSE.
2. Zdefiniuj trigger, który przy rejestracji wypożyczenia ustawia stan “wypożyczony” dla danej kopii filmu (odwrotnie przy zwrocie). 
3. Zmień tabelę i zdefiniuj trigger, który przy rejestracji zwrotu wylicza należność za wypożyczenie.
*/

#UPDATE rents
#OLD.returnedDate == NULL AND NEW.returnedDate != NULL AND isRented = TRUE ---> isRented = FALSE, rentedTimes++

USE moviesrental;
SELECT * FROM moviescopies;
SELECT * FROM rents;

ALTER TABLE moviescopies 
ADD COLUMN rentedTimes INT NOT NULL DEFAULT 0;

DELIMITER $$
CREATE TRIGGER before_rents_update    
	BEFORE UPDATE ON rents
    FOR EACH ROW
BEGIN
	UPDATE moviescopies
    IF OLD.returnedDate == NULL AND NEW.returnedDate != NULL AND isRented = TRUE
    THEN
    SET rentedTimes = rentedTimes + 1
    #SET isRented = false
    

END;
$$ DELIMITER ;
