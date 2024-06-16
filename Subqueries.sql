use shaurya

select * from  [dbo].[Orders]

select * from [dbo].[salesman]

create table customer(customer_id int, cust_name char(20), city char(20), grade int, salesman_id int)

insert into customer values(3002, 'Nick Rimando', 'New York', 100, 5001)
insert into customer values(3007, 'Brad Davis', 'New York', 200, 5001)
insert into customer values(3005, 'Graham Zusi', 'California', 200, 5001)
insert into customer values(3008, 'Julian Green', 'London', 300, 5001)
insert into customer values(3004, 'Fabian Johnson', 'Paris', 300, 5001)
insert into customer values(3009, 'Jozy Altidor', 'Berlin', 200, 5001)
insert into customer values(3003, 'Brad Guzan', 'Moscow',200 ,5001)

select * from [dbo].[customer]


select * from orders where salesman_id IN (select salesman_id from salesman where name = 'Paul Adam')

select * from orders where salesman_id IN (select salesman_id from salesman where city = 'London')

select * from orders where salesman_id IN(select distinct salesman_id from orders where customer_id = 3007)

select * from orders where purch_amt > (select avg(purch_amt) from orders where ord_date = '10/10/2012')

select * from orders where salesman_id IN (select salesman_id from salesman where city= 'New York')

select commission from salesman where salesman_id IN(select salesman_id  from customer where city = 'Paris')

select * from customer where customer_id IN(select salesman_id - 2001 from salesman where name = 'Mc Lyon')

select grade, count(*) from customer group by grade having grade > (select avg(grade) from customer where city = 'New York')

select ord_no, purch_amt, ord_date, salesman_id from orders where salesman_id IN ( select salesman_id from salesman where commission = (select max(commission) from salesman));

select b.*, a.cust_name from orders b , customer a where a.customer_id = b.customer_id and b.ord_date = '2012-08-17'

select salesman_id, name from salesman a where 1 < (select count(*) from customer where salesman_id = a.salesman_id)

select * from Orders a where purch_amt > (select avg(purch_amt) from orders b where a.customer_id = b.customer_id)

select * from Orders a where purch_amt >= (select avg(purch_amt) from orders b where a.customer_id = b.customer_id)

select ord_date, sum(purch_amt) from orders a group by ord_date having sum(purch_amt) > (select 1000.00 + max(purch_amt) from orders b where a.ord_date = b.ord_date);

select customer_id, cust_name, city from customer where EXISTS (select * from customer where city = 'London')

select * from salesman where salesman_id IN(select distinct salesman_id from customer a where exists(select * from customer b where b.salesman_id= a.salesman_id and a.cust_name<>b.cust_name));

SELECT * 
FROM salesman 
WHERE salesman_id IN (
   SELECT DISTINCT salesman_id 
   FROM customer a 
   WHERE NOT EXISTS (
      SELECT * FROM customer b 
      WHERE a.salesman_id=b.salesman_id 
      AND a.cust_name<>b.cust_name));

select * from salesman a where exists (select * from customer b where a.salesman_id = b.salesman_id AND 1 < (select count(*) from orders where orders.customer_id = b.customer_id));

select * from salesman where city = ANY (select city from customer)

select * from salesman where city IN (select city from customer);

select * from salesman a where exists (select * from customer b where a.name < b.cust_name)

select * from customer where grade > any (select grade from customer  where city < 'New York')

select * from orders where purch_amt > any (select purch_amt from  orders where ord_date = '2012/09/10')

select * from orders where purch_amt < any(select purch_amt from orders a , customer b where a.customer_id = b.customer_id and b.city = 'London')

select * from orders where purch_amt < (select max(purch_amt) from orders a, customer b where a.customer_id = b.customer_id and b.city = 'London')

select * from customer where grade > all (select grade from customer where city = 'New York')

SELECT salesman.name, salesman.city, subquery1.total_amt FROM 
salesman, (SELECT salesman_id, SUM(orders.purch_amt) AS total_amt 
FROM orders GROUP BY salesman_id) subquery1 WHERE subquery1.salesman_id = salesman.salesman_id AND
salesman.city IN (SELECT DISTINCT city FROM customer);


select * from customer where grade <> all (select grade from customer where city = 'London' and grade is not null)

select * from customer where grade <> all (select grade from customer where city = 'paris')

select * from customer where NOT grade = any (select grade from customer where city = 'Dallas')

create table company_mast(com_id int, com_name char(20))

insert into company_mast values(11, 'Samsung')
insert into company_mast values(12, 'iBall')
insert into company_mast values(13, 'Epsion')
insert into company_mast values(14, 'Zebronics')
insert into company_mast values(15, 'Asus')
insert into company_mast values(16, 'Frontech')


select * from company_mast


create table item_mast(pro_id int, pro_name char(20), pro_price float, pro_com int)

insert into item_mast values(101, 'Mother board', 3200.00, 15)
insert into item_mast values(102, 'Key Board', 450.00, 16)
insert into item_mast values(103, 'Zip drive', 250.00, 14)
insert into item_mast values(104, 'Speaker', 550.00, 16)
insert into item_mast values(105, 'Monitor', 5000.00, 11)
insert into item_mast values(106, 'DVD drive', 900.00, 12)
insert into item_mast values(107, 'CD drive', 800.00, 12)
insert into item_mast values(108, 'Printer', 2600.00, 13)
insert into item_mast values(109, 'Refill cartridge', 350.00, 13)

select * from [dbo].[item_mast]


select avg(pro_price) as 'Avg price', company_mast.com_name as 'Company' from item_mast, company_mast where item_mast.pro_com = company_mast.com_id group by company_mast.com_name

select avg(pro_price) as 'Avg price', company_mast.com_name as 'Company' from item_mast, company_mast where item_mast.pro_com = company_mast.com_id group by company_mast.com_name having avg(pro_price) >= 350;

select  * from [dbo].[item_mast]

select * from [dbo].[company_mast]

select pro_name as 'productname', pro_price as 'price', com_name as 'company' from item_mast p, company_mast c where p.pro_com = c.com_id and pro_price = (select max(p.pro_price) from item_mast p where p.pro_com = c.com_id)

