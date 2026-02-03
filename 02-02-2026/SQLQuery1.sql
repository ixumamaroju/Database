CREATE TABLE students (
    student_id BIGINT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    age INT,
    join_date DATE,
    is_active BIT
);


CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(20) NOT NULL,
    fee DECIMAL(10,2)
);

CREATE TABLE enrollments (
    enroll_id BIGINT PRIMARY KEY,
    student_id BIGINT,
    course_id BIGINT,
    enroll_timestamp TIMESTAMP
);
INSERT INTO students
(student_id, name, email, age, join_date, is_active)
VALUES
(1001, 'Uma', 'uma@gmail.com', 18, '2026-01-05', 1),
(1002, 'Ravi', 'ravi@gmail.com', 21, '2026-01-10', 1),
(1003, 'Anu', 'anu@gmail.com', 20, '2026-01-12', 1),
(1004, 'Kiran', 'kiran@gmail.com', 22, '2026-01-15', 0),
(1005, 'Sita', 'sita@gmail.com', 19, '2026-01-18', 1),
(1006, 'Manoj', 'manoj@gmail.com', 23, '2026-01-20', 1),
(1007, 'Priya', 'priya@gmail.com', 21, '2026-01-22', 0),
(1008, 'Arjun', 'arjun@gmail.com', 24, '2026-01-25', 1),
(1009, 'Divya', 'divya@gmail.com', 20, '2026-01-27', 1),
(1010, 'Rahul', 'rahul@gmail.com', 22, '2026-01-30', 1);


INSERT INTO courses (course_id, course_name, fee)
VALUES
(101, 'DBMS', 7500.00),
(102, 'DAA', 10000.00),
(103, 'OS', 8200.50),
(104, 'CN', 6800.75),
(105, 'Java', 9000.00);

INSERT INTO enrollments
(enroll_id, student_id, course_id, enroll_timestamp)
VALUES
(1, 1001, 101, '2026-02-01 10:00:00'),
(2, 1001, 102, '2026-02-01 10:05:00'),
(3, 1002, 101, '2026-02-02 11:00:00'),
(4, 1002, 103, '2026-02-02 11:10:00'),
(5, 1003, 104, '2026-02-03 09:30:00'),
(6, 1003, 105, '2026-02-03 09:40:00'),
(7, 1004, 102, '2026-02-04 12:00:00'),
(8, 1004, 103, '2026-02-04 12:15:00'),
(9, 1005, 101, '2026-02-05 10:45:00'),
(10, 1006, 105, '2026-02-06 14:00:00'),
(11, 1007, 104, '2026-02-07 15:30:00'),
(12, 1008, 102, '2026-02-08 16:00:00'),
(13, 1008, 105, '2026-02-08 16:10:00'),
(14, 1009, 103, '2026-02-09 11:20:00'),
(15, 1010, 101, '2026-02-10 09:00:00');



ALTER TABLE enrollments
DROP COLUMN enroll_timestamp;

ALTER TABLE enrollments
ADD enroll_timestamp DATETIME2;

INSERT INTO enrollments
(enroll_id, student_id, course_id, enroll_timestamp)
VALUES
(1, 1001, 101, '2026-02-01 10:00:00'),
(2, 1001, 102, '2026-02-01 10:05:00'),
(3, 1002, 101, '2026-02-02 11:00:00'),
(4, 1002, 103, '2026-02-02 11:10:00'),
(5, 1003, 104, '2026-02-03 09:30:00'),
(6, 1003, 105, '2026-02-03 09:40:00'),
(7, 1004, 102, '2026-02-04 12:00:00'),
(8, 1004, 103, '2026-02-04 12:15:00'),
(9, 1005, 101, '2026-02-05 10:45:00'),
(10, 1006, 105, '2026-02-06 14:00:00'),
(11, 1007, 104, '2026-02-07 15:30:00'),
(12, 1008, 102, '2026-02-08 16:00:00'),
(13, 1008, 105, '2026-02-08 16:10:00'),
(14, 1009, 103, '2026-02-09 11:20:00'),
(15, 1010, 101, '2026-02-10 09:00:00');

INSERT INTO students
(student_id, name, email, age, join_date, is_active)
VALUES
(1011, 'Sai', 'sai@gmail.com', 27, '2026-01-25', 1),
(1012, 'Neha', 'neha@gmail.com', 26, '2026-01-26', 1),
(1013, 'Vikas', 'vikas@gmail.com', 28, '2026-01-27', 0);

INSERT INTO courses
(course_id, course_name, fee)
VALUES
(106, 'DS', 25000.00);


INSERT INTO enrollments
(enroll_id, student_id, course_id, enroll_timestamp)
VALUES
(16, 1011, 106, '2026-02-12 10:00:00'),
(17, 1012, 106, '2026-02-12 10:05:00'),
(18, 1013, 101, '2026-02-13 11:30:00');


select * from students;

select name,email from students;

select * from students order by age desc;

select TOP 5 * from students order by join_date asc;

select DISTINCT age from students;

select distinct course_name from courses;

update students set age = 20 where student_id = 1001;

update students set is_active =0 where student_id in (1001,1002);

use college_db;
update courses set fee = fee *1.10;

delete from students where student_id = 1003;

delete from courses where fee<1000;

delete from enrollments where enroll_timestamp <'2026-02-05';
select * from enrollments;

EXEC sp_rename 'dbo.students.join_date', 'registration_date', 'COLUMN';

ALTER TABLE students
ADD registration_date DATE;


select * from students;
alter table students drop column registration_date; 
select * from students;

alter table students add phnnumber varchar(15);
select * from students;
select * from students where age >21;

select * from students where is_active=1;

SELECT *
FROM courses
WHERE fee BETWEEN 7000 AND 10000;

select * from students where age in(21,22,25);

select * from students where age>20 and is_active=1;
select * from students where age<20 or is_active=0;

select * from courses where 





