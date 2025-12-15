create database onlineshopping;
use onlineshopping;

#Products (ProductID, Name, Price, Stock, Category)
create table Products(
product_id int primary key,
name varchar(50),
price int,
stock int,
category varchar(50) 
);

#Customers (CustomerID, Name, Email, Phone)
create table Customers(
customer_id int primary key,
name varchar(50),
email varchar(50),
phone varchar(50)
);


#Orders (OrderID, CustomerID, OrderDate, TotalAmount)
create table Orders(
order_id int primary key,
customer_id int,
order_date date,
total_amount int,
foreign key(customer_id) references Customers(customer_id)
);

#OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
create table OrderDetails(
orderdetail_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key(order_id) references Orders(order_id),
foreign key(product_id) references Products(product_id)
);

INSERT INTO Products (product_id, name, price, stock, category) VALUES
(1, 'Laptop', 55000, 10, 'Electronics'),
(2, 'Smartphone', 30000, 25, 'Electronics'),
(3, 'Table Fan', 1500, 40, 'HomeAppliance'),
(4, 'Office Chair', 4500, 15, 'Furniture'),
(5, 'Coffee Mug', 250, 100, 'Kitchen');

INSERT INTO Customers (customer_id, name, email, phone) VALUES
(1, 'Arjun Kumar', 'arjun@gmail.com', '9876543210'),
(2, 'Neha Sharma', 'neha@gmail.com', '9123456789'),
(3, 'Rahul Raj', 'rahul123@yahoo.com', '9988776655'),
(4, 'Divya Nair', 'divya.nair@gmail.com', '9001122334'),
(5, 'Mohammed Ali', 'ali.mohammed@gmail.com', '9090909090');

INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2025-01-01', 55000),
(2, 2, '2025-01-03', 30000),
(3, 3, '2025-01-05', 4750),
(4, 4, '2025-01-08', 1500),
(5, 5, '2025-01-10', 500);

INSERT INTO OrderDetails (orderdetail_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 4, 1),
(4, 3, 5, 5),
(5, 4, 3, 1);

INSERT INTO OrderDetails (orderdetail_id, order_id, product_id, quantity) VALUES
(6, 6, 1, 1),
(7, 7, 2, 1),
(8, 8, 4, 1),
(9, 9, 5, 5),
(10, 10, 3, 1);

#Queries:

#Find top 3 selling products
select p.name,p.price,od.quantity from OrderDetails od 
join Products p on od.product_id=p.product_id
order by od.quantity desc limit 3;


#Get all orders made in the last 30 days
ALTER TABLE Orders  MODIFY order_date DATE DEFAULT (CURRENT_DATE);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(6, 1, '2025-11-12', 2500),    #within last 30 days
(7, 2, '2025-11-20', 3200),    #within last 30 days
(8, 3, '2025-11-28', 1500),    #within last 30 days
(9, 4, '2025-12-02', 800),     #within last 30 days
(10, 5, '2025-12-08', 1200);   #within last 30 days



select p.name,o.order_date,od.quantity from OrderDetails od
join Products p on od.product_id=p.product_id
join Orders o on od.order_id=o.order_id
where o.order_date >= CURRENT_DATE - INTERVAL 30 DAY;



#Calculate total sales revenue
select sum(total_amount) as total_sales_revenue from orders;


