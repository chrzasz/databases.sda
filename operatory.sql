/* Cwiczenie 13
1. W jakich miastach operują biura firmy oraz znajdują się jej klienci?
2. W jakich miastach operują biura firmy, ale nie znajdują się jej klienci?
3. W jakich miastach znajdują się klienci firmy, ale nie operują jej biura?
*/ 
SELECT city from customers;/*Nantes,Las Vegas,Melbourne,Nantes...*/
SELECT city from offices;/*San Francisco,Boston,NYC,Paris,Tokyo,Sydney,London*/

/* 1 */
SELECT DISTINCT city FROM customers 
UNION
SELECT DISTINCT city from offices;

/* 2 */
SELECT DISTINCT city from offices
WHERE city NOT IN(SELECT DISTINCT city from customers);

/* 3 */
SELECT DISTINCT city from customers
WHERE city NOT IN(SELECT DISTINCT city from offices);



