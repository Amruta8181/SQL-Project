##Q1. Create a New Database and Table for Employees
create database Company_DB;

use company_db;
create table employees
(employee_ID INT,
First_Name varchar(50),
Last_Name varchar(50),
Department varchar(50),
Salary INT,
Hire_date  date); 

Alter table employees
add primary key (employee_ID);

SELECT * FROM company_db.employees;

##Q2. Insert Data into Employees Table
insert into employees
values
(101,"Amit","Sharma","HR",50000,'2020-01-15'),
(102,"Riya","Kapoor","Sales",75000,'2019-03-22'),
(103,"Raj","Mehta","IT",90000,'2018-07-11'),
(104,"Neha","Verma","IT",85000,'2021-09-01'),
(105,"Arjun","Singh","Finance",60000,'2022-02-10');

## Q3. Display All Employee Records Sorted by Salary
select * From employees
order by Salary;

##Q4. Show Employees Sorted by Department (A–Z) and Salary (High → Low)
select * From employees
order by Deparment ASC, Salary desc;

##Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First)
select * from employees
where Deparment = "IT"
order by Hire_date desc;

##Q6. Create and Populate a Sales Table
create table Sales
(sales_id int,
customer_name varchar(10),
amount int,
sales_date date);

select * from sales;

insert into sales
(sales_id,customer_name,amount,sales_date)
values
(1,"Aditi",1500,"2024-08-01"),
(2,"Rohan",2200,"2024-08-03"),
(3,"Aditi",3500,"2024-09-05"),
(4,"Meena",2700,"2024-09-15"),
(5,"Rohan",4500,"2024-09-25");

##Q7. Display All Sales Records Sorted by Amount (Highest → Lowest)
select * from sales
order by amount desc;

##Q8. Show All Sales Made by Customer “Aditi”
select * from sales
where customer_name = "Aditi";

##Q9. What is the Difference Between a Primary Key and a Foreign Key?
#A primary key uniquely identifies a record in a table, while a foreign key links records between tables by referencing a primary key.

##Q10. What Are Constraints in SQL and Why Are They Used?
#Constraints are rules applied to table columns that restrict the type of data that can be stored in a table.
#They help ensure the accuracy, reliability, and integrity of data in a database










