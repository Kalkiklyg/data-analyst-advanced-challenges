

----SQL-----
create table sales(order_id int primary key,customer_id int,amount int,
Date date not null);

Insert into sales(order_id,customer_id,amount,Date) Values
(1011,11,25000,'2025-03-11'),
(1021,21,15000,'2025-05-03'),
(1033,33,28000,'2025-04-01'),
(1054,54,52000,'2025-08-12');

select * 
from sales;

create table custmer(customer_id int primary key,region varchar (80));
Insert into custmer(customer_id,region) VALUES
(11,'Pune'),
(21,'Mumbai'),
(33,'Nagpur'),
(54,'Nashik');
SELECT * from custmer;

select sum(sales.amount),custmer.region
from custmer
join sales on custmer.customer_id=sales.customer_id
group by region;

select custmer.customer_id,(avg(sales.amount)) as avg_sales
from custmer
join sales on custmer.customer_id=sales.customer_id
group by custmer.customer_id,custmer.region
having sum(sales.amount) > (select avg (amount) from sales);

select customer_id,amount 
from sales
order by amount desc


