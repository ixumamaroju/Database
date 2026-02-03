select * from students;
select * from courses;
select * from enrollments;

select * from students where email like '%@gmail.com';
select * from courses where course_name like 'data%';

insert into students(student_id,name,email,age,register_date,is_active)values(1014,'kavya','kvya@gmail.com',NULL,'2026-02-01',1);

select * from students where age IS NULL;

select * from students where age IS NOT NULL;

select * from students;
select count(*) as total_student from students;
SELECT COUNT(*) AS active_students
FROM students
WHERE is_active = 1;

SELECT
    COUNT(*) AS total_students,
    COUNT(CASE WHEN is_active = 1 THEN 1 END) AS active_students
FROM students;

select sum(fee) As total_course_fee from courses;


select AVG(fee) as AVF_FEE from courses;

select sum(fee) as total_fee_above_9000 from courses where fee>9000;

select min(age) as minimum_age from students;

select max(fee) as MAX_FEE from courses;

select max(register_date) as LASTEST_JOIN_DATE from students;

select min(register_date) as oldest_join_date from students;

select is_active,count(*)as student_count from students group by is_active;

select age,count(*) as student_count FROM students where age IS NOT NULL  GROUP BY age ORDER BY age;


select course_name, SUM(fee) AS total_fee FROM courses GROUP BY course_name;

select * from enrollments;

select
    c.course_name,
    count(e.enroll_id) as total_enrollments
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name
HAVING COUNT(e.enroll_id) > 2;

SELECT
    age,
    AVG(age) AS average_age
FROM students
GROUP BY age
HAVING AVG(age) > 21;


SELECT *
FROM students
WHERE age > 20
ORDER BY age;

SELECT COUNT(*) AS students_with_a
FROM students
WHERE name LIKE '%a%';

SELECT *
FROM courses
WHERE fee BETWEEN 5000 AND 15000
ORDER BY fee;

SELECT *
FROM students
WHERE is_active = 0
AND age IS NOT NULL;




SELECT
    student_id,
    COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY student_id
HAVING COUNT(*) > 1;

