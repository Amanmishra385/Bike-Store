-- This query selects data from 9 tables and calculates total units and revenue for each order.

SELECT 
    Ord.order_id, -- Selecting the order ID from the Sales.Orders table
    CONCAT(cus.first_name,' ',cus.Last_name) AS Customers, -- Concatenating the first and last name of the customer from the Sales.Customers table
    cus.City, -- Selecting the city of the customer from the Sales.Customers table
    cus.state, -- Selecting the state of the customer from the Sales.Customers table
    ord.order_date, -- Selecting the date of the order from the Sales.Orders table
    SUM(ite.quantity) AS 'total_units', -- Summing the quantity of each item ordered from the Sales.Order_Items table
    SUM(ite.quantity * ite.list_price) AS 'revenue', -- Multiplying the quantity of each item ordered by its list price to calculate revenue
    pro.Product_name, -- Selecting the name of the product from the Production.Products table
    cat.Category_name, -- Selecting the name of the category of the product from the Production.Categories table
    sto.Store_name, -- Selecting the name of the store from the Sales.Stores table
    CONCAT(sta.First_name,' ',sta.Last_name) AS 'Sales_Rep' -- Concatenating the first and last name of the sales representative from the Sales.Staffs table
FROM 
    sales.orders ord -- Joining Sales.Orders table
    JOIN sales.customers cus ON ord.customer_id = Cus.customer_id -- Joining Sales.Customers table on customer_id
    JOIN sales.order_items ite ON ord.order_id = ite.order_id -- Joining Sales.Order_Items table on order_id
    JOIN Production.products pro ON ite.product_id = pro.product_id -- Joining Production.Products table on product_id
    JOIN production.categories cat ON pro.category_id = cat.category_id -- Joining Production.Categories table on category_id
    JOIN sales.stores sto ON ord.store_id = sto.store_id -- Joining Sales.Stores table on store_id
    JOIN Sales.staffs sta ON ord.staff_id = sta.staff_id -- Joining Sales.Staffs table on staff_id
GROUP BY 
    Ord.order_id, -- Grouping the result by order ID
    CONCAT(cus.first_name,' ',cus.Last_name), -- Grouping the result by the customer's name
    cus.City, -- Grouping the result by the city of the customer
    cus.state, -- Grouping the result by the state of the customer
    ord.order_date, -- Grouping the result by the order date
    pro.product_name, -- Grouping the result by the product name
    cat.Category_name, -- Grouping the result by the category name
    sto.Store_name, -- Grouping the result by the store name
    CONCAT(sta.First_name,' ',sta.Last_name) -- Grouping the result by the sales representative's name
