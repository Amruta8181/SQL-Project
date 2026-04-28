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

##Q6. Write a CTE to calculate the total revenue for each product(Revenues = Price × Quantity), and return only products where revenue > 3000.

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

##Q7. Create a view named that shows Category, TotalProducts, AveragePrice?
CREATE VIEW vw_CategoryProductSummary AS
WITH CategoryStats AS (
    SELECT 
        Category,
        COUNT(*) AS Total_Products,
        AVG(Price) AS Average_Price
    FROM Product
    GROUP BY Category
)
SELECT 
    Category,
    Total_Products,
    Average_Price
FROM CategoryStats;

SELECT * FROM vw_CategoryProductSummary;

##Q8. Create an updatable view containing ProductID, ProductName, and Price.Then update the price of ProductID = 1 using the view.

CREATE VIEW vw_ProductBasicInfo AS
SELECT 
    Product_ID,
    Product_Name,
    Price
FROM Product;

UPDATE vw_ProductBasicInfo
SET Price = 150
WHERE Product_ID = 1;

##Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category
DELIMITER //

CREATE PROCEDURE sp_GetProductByCategory(IN CategoryName VARCHAR(100))
BEGIN
    SELECT 
        Product_ID,
        Product_Name,
        Price,
        Category
    FROM Product
    WHERE Category = CategoryName;
END //

DELIMITER ;

CALL sp_GetProductByCategory('Electronics');

## Q10. Create an AFTER DELETE trigger on the table that archives deleted product rows into a new table ProductArchiv. The archive should store ProductID, ProductName, Category, Price, and DeletedAttimestamp.
CREATE TABLE ProductArchiv (
    Product_ID INT,
    Product_Name VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

DELIMITER //

CREATE TRIGGER trg_AfterDelete_Product
AFTER DELETE ON Product
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchiv 
        (Product_ID, Product_Name, Category, Price, DeletedAt)
    VALUES 
        (OLD.Product_ID, 
         OLD.Product_Name, 
         OLD.Category, 
         OLD.Price, 
         NOW());
END //

DELIMITER ;

DELETE FROM Product WHERE Product_ID = 1;

SELECT * FROM ProductArchiv;