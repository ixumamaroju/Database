use college_db;
 select e1.emp_name as employee1,e2.emp_name as employee2 ,e1.manager_id from employee e1 join employee e2
 on e1.manager_id=e2.manager_id and e1.emp_id <> e2.emp_id where e1.manager_id is not null;