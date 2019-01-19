/*standard querries*/


select distinct productName, productVendor,MSRP from products;

select distinct productScale from products order by productScale desc;

select COUNT(distinct productScale) from products;

/* Ilu producentów ma w swojej ofercie sprzedawca? */
select COUNT(distinct productVendor) from products;

select COUNT(distinct employeeNumber) from employees;

/*Cwiczenie 4
1. Jakie modele ma w swojej ofercie producent, który ma w nazwie liczbę ‘66’?
2. Wyszukaj wszystkie modele, które są sprzedawane w najmniejszej i największej skali.
3. Wyszukaj produkty, których ilość na stanie jest mniejsza niż 1000 sztuk, a cena zakupu większa niż 50.
Filtering data
SELECT list FROM table WHERE conditions*/

SELECT customerName,creditLimit FROM customers WHERE country='Poland' OR country='Germany' AND creditLimit > 10000;

SELECT productName,productScale,MSRP FROM products WHERE productVendor like '%66%';

SELECT * FROM products WHERE productScale='1:10' OR productScale='1:700';

SELECT * FROM products WHERE quantityInStock < 1000 AND buyPrice > 50;

SELECT * FROM products WHERE productScale IN ('1:10', '1:700');

/* Cwiczenie 5
Wypisz modele oferowane przez firmy, które mają w swojej nazwie ‘Classics’ bądź ‘Diecast’
*/
SELECT DISTINCT productVendor FROM products;
SELECT * FROM products WHERE productVendor IN ('Highway 66 Mini Classics','Motor City Art Classics','Second Gear Diecast');

/*Subquerries Cwiczenie 6
Wypisz podstawowe dane produktów, których liczba w zamówieniach wyniosła ponad 70.
*/

SELECT * FROM orderdetails WHERE quantityOrdered > 70;

SELECT * FROM products WHERE productCode IN (SELECT productCode FROM orderdetails WHERE quantityOrdered > 70);

/* Cwiczenie 7
Wypisz podstawowe dane produktów, których cena waha się w granicach od 5 do 20.
Wypisz dane zamówień, które wysłano od początku do końca grudnia 2004 roku.
*/
SELECT * FROM products WHERE buyPrice BETWEEN 5 AND 20;

SELECT * FROM orders WHERE shippedDate BETWEEN 
CAST('2004-12-01' as DATE) AND CAST('2004-12-31' as DATE);

/* Cwiczenie 7
Wypisz podstawowe dane produktów, które w opisie mają słowo ‘steering’
Wypisz podstawowe dane produktów będących modelami pojazdów z lat 60-tych.
*/
SELECT DISTINCT productName FROM products;

SELECT * FROM products WHERE productDescription LIKE '%steering%';

SELECT * FROM products WHERE productName LIKE '%196%';


/*Cwiczenie 8 Wypisz 3 najtańsze modele w największej skali */
SELECT * FROM products WHERE productScale='1:10' ORDER BY MSRP LIMIT 3; 

