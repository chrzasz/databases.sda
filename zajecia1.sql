/*standard querries*/

select distinct productName, productVendor,MSRP from products;

/* Wypisz, w jakich skalach dostępne są sprzedawane modele*/
select distinct productScale from products order by productScale desc;

select COUNT(distinct productScale) from products;

/* Ilu producentów ma w swojej ofercie sprzedawca? */
SELECT COUNT(distinct productVendor) FROM products ;

SELECT COUNT(distinct employeeNumber) from employees;

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

/*Cwiczenie 9
Wypisz 5 najpopularniejszych producentów.
Wyświetl modele od tych producentów, posortowane od najpopularniejszego z nich, do ‘numeru 5’.
*/

SELECT DISTINCT productVendor FROM products WHERE productCode IN(
SELECT productCode FROM orderDetails ORDER BY quantityOrdered) LIMIT 5;

SELECT productName, productVendor, MSRP
FROM products
WHERE productVendor IN(
'Min Lin Diecast',
'Classic Metal Creations',
'Highway 66 Mini Classics',
'Red Start Diecast',
'Motor City Art Classics'
)
ORDER BY FIELD(productVendor,
'Highway 66 Mini Classics',
'Min Lin Diecast',
'Classic Metal Creations',
'Red Start Diecast',
'Motor City Art Classics');


SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM orderdetails; /*productCode*/

SELECT * FROM orderdetails ORDER BY quantityOrdered DESC LIMIT 5;


SELECT * FROM products WHERE productCode IN (SELECT productCode FROM orderdetails ORDER BY quantityOrdered DESC);

SELECT * FROM products WHERE productCode IN('S12_4675','S18_3278','S700_2466','S700_3167','S12_3990');

/*Cwiczenie 10
1. Wypisz najchętniej kupowane produkty.
2. Wypisz z 3 tabel następujące dane: nazwę klienta, miasto, państwo, datę zapłaty, datę zamówienia,datę na kiedy potrzebne (required date), datę wysłania.
3. Sprawdź, czy są produkty, których stan magazynowy należy zwiększyć (w historii zamówień są zamówienia, gdzie liczba zamawiana była większa niż obecny stan magazynowy).
*/
SELECT * FROM products p INNER JOIN orderDetails o ON p.productCode = o.productCode WHERE p.productCode = 'S12_4675';

SELECT * FROM orderDetails ORDER BY quantityOrdered DESC LIMIT 1; /* S12_4675 */
SELECT * FROM products WHERE productCode IN (SELECT productCode FROM orderDetails ORDER BY quantityOrdered DESC);
SELECT * FROM products WHERE productCode IN ('S12_4675'); /* '1969 Dodge Charger' */
/* 1 */
SELECT * FROM products p INNER JOIN orderDetails od ON p.productCode = od.productCode ORDER BY od.quantityOrdered DESC;
/* 2 */
SELECT * FROM customers c
INNER JOIN payments p ON c.customerNumber = p.customerNumber
INNER JOIN orders o ON o.customerNumber = c.CustomerNumber;
/* 3 */
SELECT orderNumber,productName,productVendor,quantityInStock,quantityOrdered
FROM products p
INNER JOIN orderdetails od
ON p.productCode = od.productCode
WHERE p.quantityInStock < od.quantityOrdered;

/*Cwiczenie 11
1. Wyświetl informacje na temat wpłat klientów, korzystając z operatora LEFT JOIN. Porównaj, jakie wyniki otrzymasz, kiedy “lewą tabelą” będzie customers, a jakie, kiedy payments.
2. Sprawdź, czy w asortymencie sklepu są produkty, które “się nie sprzedają”. Wyświetl ich podstawowe dane (nazwa, producent, cena, stan magazynowy).
*/

SELECT * FROM customers
LEFT JOIN payments USING (customerNumber);



SELECT * FROM payments 
LEFT JOIN customers USING (customerNumber);


/*2 - zly przyklad*/
SELECT productName, productVendor, buyPrice, quantityInStock, quantityOrdered, priceEach
FROM products
LEFT JOIN orderdetails
USING (productCode)
WHERE orderNumber IS NULL;

SELECT customerName, checkNumber, paymentDate, amount
FROM customers
LEFT JOIN payments
USING (customerNumber);
