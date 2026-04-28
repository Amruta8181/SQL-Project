use company_DB;

create table customers
(Customer_ID int,
customer_name varchar(50),
City varchar(30));

insert into customers
values
(1,"John Smith","New york"),
(2,"Mary Johnson","Chicago"),
(3,"Peter Adams","Los Angeles"),
(4,"Nancy Miller","Houston"),
(5,"Robert White","Miami");

select * From Customers;
TRUNCATE TABLE customers;

create table orders
(Order_ID int,
Customer_ID int,
Order_date date,
Amount int);

insert into Orders
values
(101,1,"2024-10-01",250),
(102,2,"2024-10-05",300),
(103,1,"2024-10-07",150),
(104,3,"2024-10-10",450),
(105,6,"2024-10-12",400);

select * From Orders;

create table payments
(paymentID char(4),
customerID int,
payment_date date,
Amount int);

alter table payments
modify paymentID char(4);

insert into payments
values
("P001",1,"2024-10-02",250),
("P002",2,"2024-10-06",300),
("P003",3,"2024-10-11",450),
("P004",4,"2024-10-15",200);

select * From Payments;
select * From employees;

create table Employee_1
(employeesID int,
Employees_name varchar(50),
ManagerID int);

insert into Employee_1
values
(1,"Alex Green",NULL),
(2,"Brian Lee",1),
(3,"Carol Ray",1),
(4,"David Kim",2),
(5,"Eva Smith",2);

select * from Employee_1;

##Question 1. Retrieve all customers who have placed at least one order.
SELECT c.Customer_ID, c.Customer_name,COUNT(o.Order_ID) AS Totalorders
FROM Customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_name
HAVING COUNT(o.Order_ID) >= 1;

##Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.
Select c.Customer_ID, c.Customer_name,o.Order_ID
from customers c
left join orders o ON c.Customer_ID = o.Customer_ID;

##Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
Select o.Order_ID,o.Order_date,c.Customer_ID,c.Customer_name,c.city
From orders o
left join customers c on o.customer_ID = c.customer_ID
order by o.order_id;

##Question 4. Display all customers and orders, whether matched or not.
select c.Customer_ID,c.Customer_name,o.order_id,o.order_date,o.amount
From customers c
left join orders o on o.customer_ID = c.customer_ID
UNion all
select c.Customer_ID,c.Customer_name,o.order_id,o.order_date,o.amount
From customers c
Right join orders o on o.customer_ID = c.customer_ID
WHERE c.Customer_ID IS NULL
order by Customer_ID,order_id;

##Question 5. Find customers who have not placed any orders.
select c.Customer_ID,c.Customer_name,o.order_id
From customers c
left join orders o on o.customer_ID = c.customer_ID
WHERE o.order_ID IS NULL
order by Customer_ID,order_id;

##Question 6. Retrieve customers who made payments but did not place any orders.
select p.paymentid,p.customerID,o.order_id,o.order_date
from payments p
left join orders o on o.customer_ID = p.customerID
where o.order_ID IS NULL
order by paymentid,order_id;

##Question 7. Generate a list of all possible combinations between Customers and Orders.
SELECT c.Customer_ID, c.Customer_name, o.Order_ID, o.Order_date, o.Amount
FROM Customers c
CROSS JOIN Orders o
ORDER BY c.Customer_ID, o.Order_ID;

##Question 8. Show all customers along with order and payment amounts in one table
select c.Customer_ID, c.Customer_name, o.Order_ID, o.Order_date, o.Amount,p.paymentid
From customers c
left join orders o on o.customer_ID = c.customer_ID
left join payments p on p.customerID = c.customer_ID
ORDER BY c.Customer_ID, o.Order_ID,p.paymentid;

##Question 9. Retrieve all customers who have both placed orders and made payments
select c.Customer_ID, c.Customer_name, o.Order_ID, o.Order_date, o.Amount,p.paymentid
From customers c
left join orders o on o.customer_ID = c.customer_ID
left join payments p on p.customerID = c.customer_ID
where o.order_ID and p.paymentID is not NULL
ORDER BY c.Customer_ID, o.Order_ID,p.paymentid;







