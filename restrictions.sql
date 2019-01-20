/* Cw 18
Utwórz bazę ‘dbdemo’ oraz dwie tabele: ‘categories’ i ‘products’.
Każda kategoria posiada jeden lub więcej produktów, ale każdy produkt należy tylko do jednej kategorii.
W tabeli ‘products’ znajduje się kolumna ‘cat_id’, która jest kluczem obcym z akcjami ‘UPDATE ON CASCADE’ oraz
‘DELETE ON RESTRICT’
*/

CREATE DATABASE dbdemo;
USE dbdemo;

CREATE TABLE categories(
	cat_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_name VARCHAR(255) NOT NULL,
    cat_desc VARCHAR(1000)
);
 
CREATE TABLE products(
	p_id INT PRIMARY KEY AUTO_INCREMENT,
    p_name VARCHAR(255) NOT NULL,
    p_price DOUBLE(6,2) NOT NULL,
    cat_id INT NOT NULL,
    FOREIGN KEY fk_cat_id(cat_id)
    REFERENCES categories(cat_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

 
INSERT INTO categories(cat_name)
VALUES('Toy cars'),('Books');

SELECT * FROM products;




