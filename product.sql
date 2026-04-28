 use pw;
 create table product
 (product_id int primary key,
 product_name varchar(100),
 category varchar(50),
 price decimal(10,2));
 
 insert into product
 values
 (1,"Keyboard","electronics",1200),
 (2,"Mouse","Electronics",800),
 (3,"Chair","Furnoture",2500),
 (4,"Desk","Furniture",5500);
 
 select * from product;
 
 Create table sales
 (sales_ID int primary key,
 product_ID int,
 Quantity int,
 Sales_date date,
 foreign key (product_ID) references product(product_ID));
 
 insert into sales
 values
 (1,1,4,"2024-01-05"),
 (2,2,10,"2024-01-06"),
 (3,3,2,"2024-01-10"),
 (4,4,1,"2024-01-11");
 
 select * from sales;

WITH Product_Revenue AS (
    SELECT 
        p.Product_ID,
        p.Product_Name,
        SUM(p.Price * s.Quantity) AS Total_Revenue
    FROM pw.Sales s
    JOIN pw.Product p
        ON s.Product_ID = p.Product_ID
    GROUP BY p.Product_ID, p.Product_Name
)
SELECT 
    Product_ID,
    Product_Name,
    Total_Revenue
FROM Product_Revenue
WHERE Total_Revenue > 3000;