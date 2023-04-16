--Selecting the data that we will be working with which is distributed across 9 tables 

select
	Ord.order_id,
	CONCAT(cus.first_name,' ',cus.Last_name) AS Customers,
	cus.City,
	cus.state,
	ord.order_date,
	sum(ite.quantity) AS 'total_units',
	Sum(ite.quantity * ite.list_price) AS 'revenue',
	pro.Product_name,
	cat.Category_name,
	sto.Store_name,
	CONCAT(sta.First_name,' ',sta.Last_name) AS 'Sales_Rep'
From sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = Cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id
JOIN Production.products pro
ON ite.product_id = pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
JOIN Sales.staffs sta
ON ord.staff_id = sta.staff_id
Group BY
	Ord.order_id,
	CONCAT(cus.first_name,' ',cus.Last_name),
	cus.City,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.Category_name,
	sto.Store_name,
	CONCAT(sta.First_name,' ',sta.Last_name)