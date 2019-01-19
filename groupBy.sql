SELECT * FROM orders;

SELECT * FROM orders GROUP BY status;

/*Cwiczenie 12
1. Jakie są średnie ceny produktów danej firmy?
2. Jaka jest najwyższa cena produktów danej firmy? Posortuj malejąco.
3. Jakie modele są najchętniej kupowane? Posortuj malejąco.
4. Czy wśród klientów są firmy które opłaciły zamówienie o wartości większej niż ich limit kredytowy?
*/

SELECT * FROM products;
SELECT * FROM products GROUP BY productline;

/* 1 */
SELECT AVG(buyPrice) AS avgp, productVendor, productName FROM products GROUP BY productVendor order by avgp DESC;

SELECT productName,AVG(buyPrice) AS avg  FROM products GROUP BY productLine;

/* 2 */
SELECT productVendor, MAX(buyPrice) AS exp FROM products GROUP BY productVendor ORDER BY exp;

SELECT creditLimit FROM customers;
SELECT * FROM orderDetails;

/* 3 */









SELECT productVendor, AVG(buyPrice) as avgp
FROM products
GROUP BY productVendor
ORDER BY avgp DESC;

SELECT productVendor, productName, MAX(buyPrice) as exp
FROM products
GROUP BY productVendor
ORDER BY exp DESC;SELECT productName, productVendor, SUM(quantityOrdered) as sold
FROM products
INNER JOIN orderdetails
USING (productCode)
GROUP BY productCode
ORDER BY sold DESC;

SELECT customerName, creditLimit, amount
FROM customers
INNER JOIN payments
USING (customerNumber)
GROUP BY customerName
HAVING amount > creditLimit;