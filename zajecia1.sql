select distinct productName, productVendor,MSRP from products;

select distinct productScale from products order by productScale desc;

select COUNT(distinct productScale) from products;

select COUNT(distinct productVendor) from products;

select COUNT(distinct employeeNumber) from employees;


