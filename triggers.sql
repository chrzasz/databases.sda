CREATE TABLE employees_audit (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);



DELIMITER $$
CREATE TRIGGER before_employee_update    
	BEFORE UPDATE ON employees
    FOR EACH ROW
BEGIN
	INSERT INTO employees_audit(action, employeeNumber, lastName, changedat)
    VALUES('update', OLD.employeeNumber, OLD.lastName, now());
END $$    
DELIMITER ;



##SHOW TRIGGERS;



