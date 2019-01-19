/*standard querries*/

select distinct productName, productVendor,MSRP from products;

select distinct productScale from products order by productScale desc;

select COUNT(distinct productScale) from products;

select COUNT(distinct productVendor) from products;

select COUNT(distinct employeeNumber) from employees;

/*Filtering data
SELECT list FROM table WHERE conditions*/

SELECT customerName,creditLimit FROM customers WHERE country='Poland' OR country='Germany' AND creditLimit > 10000;

SELECT productName,productScale,MSRP FROM products WHERE productVendor like '%66%';

SELECT * FROM products WHERE productScale='1:10' OR productScale='1:700';

SELECT * FROM products WHERE quantityInStock < 1000 AND buyPrice > 50;

SELECT * FROM products WHERE productScale IN ('1:10', '1:700');

SELECT DISTINCT productVendor FROM products;
SELECT * FROM products WHERE productVendor IN ('Highway 66 Mini Classics','Motor City Art Classics','Second Gear Diecast');

/*Subquerries Cwiczenie 6*/

SELECT * FROM orderdetails WHERE quantityOrdered > 70;

SELECT * FROM products WHERE productCode IN (SELECT productCode FROM orderdetails WHERE quantityOrdered > 70);

