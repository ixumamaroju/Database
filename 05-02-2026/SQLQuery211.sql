create database college_db;
use college_db;
create table customers (cust_id int primary key, cust_name  varchar(30) not null  ,cust_city varchar(30) not null,cust_email varchar(50) not null unique);

insert into customers(cust_id,cust_name,cust_city,cust_email) values(1001,'uma','hyderabad','uma@gmail.com'),(1002,'sri','banglore','sri@gamil.com'),
(1003,'sai','chennai','sai@gmail.com'),(1004,'abhi','chennai','abhi@gmail.com');

select * from customers;

create table orders(order_id int primary key , order_date Date,cust_id int foreign key (cust_id) references customers(cust_id));
insert into orders(order_id,order_date,cust_id) values(001,'2026-02-01',1002),(002,'2026-02-02',1003),(003,'2026-02-02',1002),(004,'2026-02-03',1004),
(005,'2026-02-05',1001);
select * from orders;

insert into orders values(006,'2026-02-02',1005);

create table students(student_id int primary key , student_name varchar(30));
insert into students(student_id,student_name) values(1,'uma'),(2,'sai'),(3,'sri');
select * from students;

create table courses(courses_id int primary key, course_name varchar(30));
insert into courses(courses_id,course_name) values(101,'datascience'),(102,'operatingsystem'),(103,'computernetworks');
select * from courses;

create table student_course(student_id int,courses_id int , primary key(student_id,courses_id),foreign key (student_id) references students(student_id),
foreign key (courses_id) references courses(courses_id) );

insert into student_course(student_id,courses_id) values (1,101),(1,102),(2,103),(3,103),(2,102);
select * from student_course;

select c.cust_id,c.cust_name,o.order_id,o.order_date from customers c join orders o on 
c.cust_id=o.cust_id;

select c.cust_name,c.cust_city,o.order_id,o.order_date from customers c join orders o 
on c.cust_id = o.cust_id;

create table department(dept_id int primary key ,dept_name varchar(30));
insert into department(dept_id,dept_name)values(20,'cse'),(30,'ece'),(40,'it');
select * from department;
create table employee(emp_id int primary key , emp_name varchar(30),dept_id int ,
foreign key(dept_id) references department (dept_id));
insert into employee(emp_id,emp_name,dept_id) values(23,'uma',20),(24,'sri',40);
select * from employee;
select e.emp_name,e.emp_id,d.dept_name from employee e join department d on e.dept_id =
d.dept_id;

create table product (prd_id int primary key,prd_name varchar(30),prd_price decimal(5,2));
alter table product alter column prd_price decimal(10,2);
insert into product (prd_id,prd_name,prd_price) values (201,'mouse',299.35),(202 ,'keyboard',1000.45),
(203,'monitor',7000.36),(204,'cpu',10000.46);
select * from product;

create table order_items(order_id int,prd_id int,quantity int,primary key (order_id,prd_id) ,
foreign key (order_id) references orders(order_id),foreign key (prd_id) references product(prd_id));
insert into order_items(order_id,prd_id,quantity)values(1,202,2),(2,204,5),(3,201,10);
select * from order_items;

select o.order_id,o.order_date,p.prd_name,oi.quantity from orders o join order_items oi on o.order_id
=oi.order_id join product p on oi.prd_id = p.prd_id;

select o.order_id,p.prd_name,oi.quantity,p.prd_price,(p.prd_price*oi.quantity) as Amount from orders o
join order_items oi on o.order_id = oi.order_id join product p on oi.prd_id = p.prd_id where (p.prd_price*oi.quantity) >5000;

select o.order_id,p.prd_name from orders o join order_items oi on o.order_id=oi.order_id join 
product p on oi.prd_id=p.prd_id where p.prd_name like '%u%';

insert into customers values(1005,'jai','kerala','jai@gmail.com');

select c.cust_id,c.cust_name,o.order_id from customers c left join orders o on c.cust_id=o.cust_id;

select c.cust_id ,c.cust_name,o.order_id from customers c left join orders o on c.cust_id=o.cust_id 
where o.order_id IS NULL;

select d.dept_id,d.dept_name,e.emp_name from department d left join employee e on d.dept_id=e.dept_id;

select d.dept_id,d.dept_name from department d left join employee e on d.dept_id=e.dept_id where e.emp_id is null;

select p.prd_name,p.prd_id from product p left join order_items oi on p.prd_id=oi.prd_id where oi.prd_id is null;

select p.prd_name,oi.order_id from product p left join order_items oi on p.prd_id=oi.prd_id where p.prd_name like '%e%';


select o.order_id,o.order_date,c.cust_id,c.cust_name from customers c right join orders o  on c.cust_id = o.cust_id;
use college_db;
insert into orders values(6,'2026-02-07',1006);

select d.dept_id,d.dept_name,e.emp_name from employee e right join department d on e.dept_id=d.dept_id;

select d.dept_id,d.dept_name ,e.emp_name from employee e right join department d on e.dept_id=d.dept_id where d.dept_id=20;

insert into employee values(25,'sai',20);

select d.dept_name,count(e.emp_id) from employee e right join department d on e.dept_id=d.dept_id group by d.dept_name;

select c.cust_name,c.cust_city,o.order_id,o.order_date from customers c left join orders o on c.cust_id=o.cust_id union select c.cust_name,c.cust_city,o.order_id,o.order_date from customers c right join orders o 
on c.cust_id=o.cust_id;

select c.cust_id,c.cust_name,o.order_id,'leftside'as common from customers c left join orders o  on c.cust_id =o.cust_id union select  c.cust_id,c.cust_name,o.order_id,'rightonly' as common from customers c right join orders o 
on c.cust_id=o.cust_id;

select d.dept_name,d.dept_id,e.emp_name,e.emp_id from employee e left join department d on e.dept_id=e.dept_id union
select  d.dept_name,d.dept_id,e.emp_name,e.emp_id from employee e right join department d on e.dept_id=e.dept_id;


alter table employee add manager_id int ;
use college_db;
update employee set manager_id = case when emp_id=23  then null when emp_id = 24 then 23 when emp_id = 25 then 24 end; 
select e.emp_name as employee ,m.emp_name as manager from employee e left join employee m on e.manager_id=m.emp_id;

use college_db;

insert into employee values(26,'abhi',20,23);
 select e1.emp_name as employee1,e2.emp_name as employee2 ,e1.manager_id from employee e1 join employee e2
 on e1.manager_id=e2.manager_id and e1.emp_id <> e2.emp_id where e1.manager_id is not null;

 select distinct m.emp_id,m.emp_name from employee e join employee m on e.manager_id=m.emp_id;

 alter table employee add mentor_id int;

 update employee set mentor_id = case when emp_id=23 then 24 when emp_id=24 then 25 when emp_id=25 then 23
 when emp_id=26 then 23 end ;
 select * from employee;

 select e.emp_name as employee ,m.emp_name as mentor from employee e left join employee m on 
 e.mentor_id=m.emp_id;


 select c.cust_id,c.cust_name,p.prd_id,p.prd_name from customers c cross join product p;

create table roles(role_id int primary key ,role_name varchar(30));
insert into roles(role_id,role_name) values (123,'employee'),(124,'manager'),(125,'mentor');
select e.emp_id,e.emp_name,r.role_name from employee e cross join roles r;

select * from customers c cross join product p;


select c.cust_name,c.cust_city,o.order_id,o.order_date,oi.prd_id,oi.quantity from customers c join orders o 
on c.cust_id=o.cust_id join order_items oi on o.order_id = oi.order_id;

create table suppliers (sup_id int primary key,sup_name varchar(60));
insert into suppliers(sup_id,sup_name )values(5001,'sriganesh_trades'),(5002,'saiviaks_solutions'),
(5003,'venkateshwara_trades');
alter table product add sup_id int ;
update product set sup_id = case when prd_id = 201 then 5001 when prd_id=202 then 5001 when prd_id=203 then 5002
when prd_id=204 then 5003 end ;
select * from suppliers;

select o.order_id ,o.order_date,p.prd_name,p.prd_price,s.sup_name from orders o join order_items oi on
o.order_id=oi.order_id join product p on oi.prd_id=p.prd_id join suppliers s on p.sup_id=s.sup_id;

create table location(loc_id int primary key,loc_name varchar(40));
insert into location(loc_id,loc_name) values(301,'block-A'),(302,'block-B'),(303,'block-C');

alter table department add loc_id int;
update department set loc_id= case when dept_id=20 then 301 when dept_id=30 then 302 when dept_id=40 then 303 end ; 

select e.emp_name,d.dept_name,l.loc_name from employee e join department d on e.dept_id= d.dept_id  join 
location l on d.loc_id=l.loc_id;

select * from orders o join order_items oi on o.order_id=oi.order_id join product p on oi.prd_id=p.prd_id
join suppliers s on p.sup_id = s.sup_id;

insert into orders(order_id,order_date,cust_id) values(6,'2026-02-07',1004),(7,'2026-02-07',1004);

select c.cust_id,c.cust_name,count(c.cust_id) as order_count  from orders o left join customers c on o.cust_id=c.cust_id 
group by c.cust_id,c.cust_name;

select c.cust_id,c.cust_name,sum(oi.quantity* p.prd_price )as total_amount from customers c left join orders o
on c.cust_id=o.cust_id left join order_items oi on o.order_id=oi.order_id left join  product p on
oi.prd_id=p.prd_id group by c.cust_id,c.cust_name;


select d.dept_name,count(e.dept_id) as employeecount,STRING_AGG(e.emp_name,',')as employee from employee e left join department d on e.dept_id=d.dept_id 
group by e.dept_id,d.dept_name;


insert into order_items values(4,204,6);

select p.prd_name,count(p.prd_id) as no_Ofproducts , string_agg( oi.order_id,',')as orders from product p left join order_items oi on
p.prd_id = oi.prd_id group by(p.prd_name);

alter table employee add sal decimal(10,2);
update employee set sal = case when emp_id=23 then 40000 when emp_id=24 then 20000 when emp_id = 25 then 10000 when emp_id=26 then 30000 end;
select * from employee;

select d.dept_id,sum(e.sal),d.dept_name from employee e left join department d on e.dept_id =d.dept_id group by d.dept_id,d.dept_name;

select c.cust_id ,c.cust_name,count(o.order_id) as order_count from  customers c left join orders o on c.cust_id=o.cust_id group by c.cust_id,c.cust_name having count(o.order_id )>2;

select d.dept_id,d.dept_name ,count(e.emp_id ) as employee_count from department d left join employee e on e.dept_id = d.dept_id group by d.dept_id ,d.dept_name having count(e.emp_id )>1;

use college_db;

select count(o.order_id)as no_of_orders,c.cust_city from orders o left join customers c on o.cust_id=c.cust_id group by c.cust_city having count(o.order_id)>1;

create table category (cat_id int primary key,cat_name varchar(30));
insert into category(cat_id,cat_name) values(601,'systempart'),(602,'processor');
alter table product add cat_id int;
update product set cat_id = case when prd_id = 201 then 601 when prd_id=202 then 601 when prd_id = 203 then 601 when prd_id=204 then 602 end ;
select * from product;

select count(p.prd_id),c.cat_name from product p left join category c on p.cat_id=c.cat_id group by c.cat_name having count(p.prd_id)>2;

select c.cust_id,c.cust_name ,c.cust_city,c.cust_email from customers c join orders o on c.cust_id = o.cust_id where o.order_date>'2026-02-03';

select e.emp_id,e.emp_name from employee e join department d on e.dept_id=d.dept_id where d.dept_name='cse';
select c.cust_name,c.cust_city,o.order_id from customers c join orders o on c.cust_id=o.cust_id where c.cust_city='chennai';  

select p.prd_id,p.prd_price,oi.quantity from  product p left join order_items oi on p.prd_id=oi.prd_id where p.prd_price>5000; 

select c.cust_name,o.order_id from customers c join orders o on c.cust_id=o.cust_id where c.cust_name like 'a%';
select e.emp_id,e.emp_name ,d.dept_name from employee e join department d on e.dept_id=d.dept_id where e.emp_name like '%s%';
select o.order_id,o.order_date,p.prd_name,oi.quantity from orders o join order_items oi on o.order_id=oi.order_id join product p on oi.prd_id=p.prd_id where p.prd_name like '%mouse%';


select e.emp_name,d.dept_name from employee e join department d on e.dept_id=d.dept_id; 
insert into employee values(27,'jai',50,24,null,10000);
alter table department add constraint unique_dept_name unique (dept_name);
select e.emp_name ,d.dept_name from employee e join department d on d.dept_name ='cse';
select * from department;
alter table employee alter column dept_id int not null;
insert into employee values(28,'ani',null,24,23,50000);

alter table employee nocheck constraint all;
insert into employee values(4,'test',500,null,null,20000);
select * from employee;
select * from customers where cust_id in (select cust_id from orders);
select * from customers where cust_id not in(select cust_id from orders);
select * from product where prd_id not in(select prd_id from order_items);
select * from employee where emp_id not in(select emp_id from department);
insert into employee values(27 ,'ani',50,null,null,10000);
select p.prd_id,p.prd_name,(p.prd_price*oi.quantity)as amount from product p join order_items oi on p.prd_id=oi.prd_id where (p.prd_price * oi.quantity)> 
(select avg(p2.prd_price*oi2.quantity)from product p2 join order_items oi2 on p2.prd_id=oi2.prd_id);

select * from product p where not exists(select 1 from order_items oi where oi.prd_id=p.prd_id);
select e.emp_id,e.emp_name,d.dept_name,e.sal from employee e join department d on e.dept_id=d.dept_id where e.sal>(select avg(e2.sal) from employee e2 where e2.dept_id=e.dept_id);
select * from department d where exists ( select 1 from employee e where e.dept_id=d.dept_id);

alter table orders add status varchar(30);
update orders set status = case when order_id=1 then 'not cancelled' when order_id=2 then 'not cancelled' when order_id=3 then 'not cancelled' when order_id=4 then 'not cancelled' when order_id=5 then 'not cancelled' when order_id=6 then 'cancelled' when order_id=7 then'cancelled' end ;
select * from orders;

select * from customers c where not exists (select 1 from orders o where o.cust_id= c.cust_id  and o.status = ' cancelled');
select * from customers c where not exists (select 1 from orders o where o.cust_id=c.cust_id);

use college_db;
select e.emp_id,e.emp_name,d.dept_name,e.sal from employee e join department d on e.dept_id=d.dept_id and e.sal>(select avg(e2.sal) from employee e2 where e2.dept_id =e.dept_id);

select e.emp_id,e.emp_name,e.sal,d.dept_id,d.dept_name,d.loc_id from employee e join department d on e.dept_id=d.dept_id; 
select e.emp_id as employeeid ,e.emp_name as employeename ,d.dept_name as departmentname ,e.sal as salary from employee e join department d on e.dept_id = d.dept_id;
select e.emp_name,d.dept_name ,e.sal ,e.sal*12 as anuualsalary,e.sal *0.10 as bonusamount from employee e join department d on e.dept_id=d.dept_id;
select e.emp_name,d.dept_name,e.sal,case when e.sal>=35000 then'high salary' when e.sal>=25000 then 'medium salary' else 'low salary' end as salarycategory from employee e join department d on e.dept_id=d.dept_id; 
