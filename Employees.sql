Create database employees;

use employees;
create table employee_information
(Employee_ID int,
Emp_Full_Name varchar(50),
Department varchar(50),
City varchar(50),
Salary int,
Hire_date date);

Select * from employee_information;

insert into employee_information
values 
(101,"Rahul Mehta","sales","Delhi",55000,"2020-04-12"),
(102,"Priya Sharma","HR","Mumbai",62000,"2019-09-25"),
(103,"Aman Singh","IT","Bangaluru",72000,"2021-03-10"),
(104,"Neha Patel","Sales","Delhi",48000,"2022-01-14"),
(105,"Karan Joshi","Marketing","Pune",45000,"2018-07-22"),
(106,"Divya Nayar","IT","Chennai",81000,"2019-12-11"),
(107,"Raj Kumar","HR","Delhi",60000,"2020-05-28"),
(108,"Simran Kaur","Finance","Mumbai",58000,"2021-08-03"),
(109,"Arjun Reddy","IT","Hyderabad",70000,"2022-02-18"),
(110,"Anjali Das","Sales","Kolkata",51000,"2023-01-15");

##Question 1 : Show employees working in either the ‘IT’ or ‘HR’ departments
Select * from employee_information
where Department in("IT","HR");

##Question 2 : Retrieve employees whose department is in ‘Sales’, ‘IT’, or ‘Finance’.
Select * from employee_information
where Department in("Sales","IT","Finance");

##Question 3 : Display employees whose salary is between ₹50,000 and ₹70,000.
Select * from employee_information
where salary between 50000 and 70000;

##Question 4 : List employees whose names start with the letter ‘A’.
Select * from employee_information
where Emp_Full_Name like "A%";

##Question 5 : Find employees whose names contain the substring ‘an’.
Select * from employee_information
where Emp_Full_Name like "%an%";

##Question 6 : Show employees who are from ‘Delhi’ or ‘Mumbai’ and earn more than ₹55,000
Select * from employee_information
where City in("Delhi","Mumbai") and Salary >= 55000;

##Question 7 : Display all employees except those from the ‘HR’ department.
Select * from employee_information
where Department <>"HR";

##Question 8 : Get all employees hired between 2019 and 2022, ordered by HireDate (oldest first).
Select * from employee_information
where year(hire_date) between 2019 and 2022
order by Hire_date;

use employees;
create table employee_dataset
(emp_id int,
Emp_Name varchar(30),
Department_id char(4),
Salary int);

insert into employee_dataset
values
(101,"Abhishek","D01",62000),
(102,"Shubham","D01",58000),
(103,"Priya","D02",67000),
(104,"Rohit","D02",64000),
(105,"Neha","D03",72000),
(106,"Aman","D03",55000),
(107,"Ravi","D04",60000),
(108,"Sneha","D04",75000),
(109,"Kiran","D05",70000),
(110,"Tanuja","D05",65000);

 Select * From employee_dataset;

create table department_dataset
(department_ID char(4),
department_name varchar(30),
departmetn_location varchar(30));

insert into department_dataset
values
("D01","sales","Mumbai"),
("D02","Marketing","Delhi"),
("D03","Finance","Pune"),
("D04","HR","Bengluru"),
("D05","IT","Hydrabad");

select * From department_dataset;

Create table sales_dataset
(Sales_ID int,
Emp_ID int,
Sales_amount int,
Sales_date date);

insert into sales_dataset
values
(201,101,4500,"2025-01-05"),
(202,102,7800,"2025-01-10"),
(203,103,6700,"2025-01-14"),
(204,104,12000,"2025-01-20"),
(205,105,9800,"2025-02-02"),
(206,106,10500,"2025-02-05"),
(207,107,3200,"2025-02-09"),
(208,108,5100,"2025-02-15"),
(209,109,3900,"2025-02-20"),
(210,110,7200,"2025-03-01");

Select * from sales_dataset;

##Basic Level
## Q1.Retrieve the names of employees who earn more than the average salary of all employees.
select EMP_name,Salary
from employee_dataset
where salary >(select avg(salary) 
from employee_dataset);

##Q2.Find the employees who belong to the department with the highest average salary.
select e.EMP_name,e.Department_id,d.department_name,e.salary
from employee_dataset e
left join department_dataset d on d.department_id = e.department_id
where e.Department_id =(select e.Department_id
from employee_dataset
group by e.Department_id
order by avg(e.salary) desc)
Limit 1;

##Q3.List all employees who have made at least one sale.
select e.EMp_id,e.emp_name,S.sales_ID,s.sales_amount
From employee_dataset e
inner join sales_dataset s on s.Emp_ID=e.emp_id
where e.emp_id =(select e.emp_id
from sales_dataset
group by e.emp_id
order by sum(s.Sales_amount) desc
limit 1);

## Q4.Find the employee with the highest sale amount.
select e.EMp_id,e.emp_name,
(select sum(s.sales_amount)
from sales_dataset s
where e.emp_id = s.emp_id)  as total_sales
From employee_dataset e
where e.emp_id =(select s.Emp_ID
from sales_dataset s
group by s.Emp_ID
order by sum(s.Sales_amount)desc
Limit 1); 

##Q5.Retrieve the names of employees whose salaries are higher than Shubham’s salary.
select e.emp_name,e.salary
from employee_dataset e
where e.Salary > ( select Salary 
from employee_dataset
where EMP_name = "Shubham")
order by e.salary desc;

## Intermediate Level
##Q1.Find employees who work in the same department as Abhishek
Select e.emp_name,e.department_id
from employee_dataset e
where e.Department_id =(select department_ID
from employee_dataset
where Emp_Name = "Abhishek")
order by e.Department_id;

##Q2.List departments that have at least one employee earning more than ₹60,000.
select distinct e.Department_id,e.salary
from employee_dataset e
where e.Department_id in ( select Department_id
from employee_dataset
where e.salary > 60000);

##Q3.Find the department name of the employee who made the highest sale.
SELECT d.Department_name
FROM department_dataset d
JOIN employee_dataset e ON d.Department_id = e.Department_id
JOIN sales_dataset s ON e.emp_id = s.emp_id
WHERE s.sales_amount = 
(SELECT MAX(sales_amount)
FROM sales_dataset);

##Q4.Retrieve employees who have made sales greater than the average sale amount
select e.emp_name
from employee_dataset e
join sales_dataset s on e.emp_id = s.emp_id
where s.Sales_amount > (select avg(sales_amount)
from sales_dataset);

##Q5.Find the total sales made by employees who earn more than the average salary
select e.emp_name,sum(s.Sales_amount) as total_sales
from employee_dataset e
left join sales_dataset s on e.emp_id = s.Emp_ID
where e.Salary > (select avg(Salary)
from employee_dataset) 
group by e.Emp_Name;

##Advanced Level
##Q1.Find employees who have not made any sales.
Select e.emp_name
from employee_dataset e
where not exists(select 1 from sales_dataset s
where s.Emp_ID=e.emp_id);

##Q2.List departments where the average salary is above ₹55,000
select distinct e.Department_id, d.department_name,e.Salary
from employee_dataset e
left join department_dataset d on d.department_ID=e.Department_id
where e.department_ID in(SELECT Department_id
FROM employee_dataset
group by Department_id
having avg(Salary) > 55000);

##Q3.Retrieve department names where the total sales exceed ₹10,000.
select d.department_name
from department_dataset d
where d.Department_id in(select e.Department_id
from employee_dataset e
JOIN sales_dataset s ON s.emp_id = e.emp_id
group by e.Department_id
having sum(s.Sales_amount)>10000);    
    
##Q4.Find the employee who has made the second-highest sale.
select e.EMp_id,e.emp_name,
(select sum(s.sales_amount)
from sales_dataset s
where e.emp_id = s.emp_id)  as total_sales
From employee_dataset e
where e.emp_id =(select s.Emp_ID
from sales_dataset s
group by s.Emp_ID
order by sum(s.Sales_amount)desc
Limit 1 offset 1); 

##Q5.Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
SELECT e.emp_name
FROM employee_dataset e
WHERE e.salary > (SELECT MAX(sales_amount)
FROM sales_dataset);

