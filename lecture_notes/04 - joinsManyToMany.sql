IF OBJECT_ID(N'dbo.courses', N'U') IS NOT NULL -- droppar om tabellen finns
   DROP TABLE [dbo].courses;
create table courses
(
    id int,
    name nvarchar(max)
);

insert into courses values (1, 'Python');
insert into courses values (2, 'Algebra');
insert into courses values (3, 'Databaser');
insert into courses values (4, 'AI');

drop table students;
create table students
(
    id int,
    name nvarchar(max)
);

insert into students values (1, 'Thomas');
insert into students values (2, 'Erik');
insert into students values (3, 'Anna');
insert into students values (4, 'Camilla');
insert into students values (5, 'Maria');

drop table coursesStudents
create table coursesStudents
(
    courseId int,
    studentId int
)

insert into coursesStudents values (1, 1);
insert into coursesStudents values (1, 2);
insert into coursesStudents values (1, 3);
insert into coursesStudents values (2, 1);
insert into coursesStudents values (2, 2);
insert into coursesStudents values (2, 3);
insert into coursesStudents values (2, 4);
insert into coursesStudents values (3, 2);
insert into coursesStudents values (3, 4);

select * from courses;
select * from students;
select * from coursesStudents;

select
	* -- alla kolumner från alla tabeller
from
	courses c
	join coursesStudents cs on c.id = cs.courseId
	join students s on s.id = cs.studentId


select
	c.name as 'Kurs',
	s.name as 'Student'
from
	courses c
	join coursesStudents cs on c.id = cs.courseId
	join students s on s.id = cs.studentId

---------------------------------------------------------------------------------------------------
select
	c.name as 'Kurs',
	count(s.name) AS 'Number of students',
	ISNULL(STRING_AGG(s.name, ', '), '-') AS 'List of students'
from
	courses c
	left join coursesStudents cs on c.id = cs.courseId -- left join och inte bara join för att få kurser utan studenter
	left join students s on s.id = cs.studentId
group by
	c.name

select
	s.name as 'Student',
	count(c.name) AS 'Number of courses',
	ISNULL(STRING_AGG(c.name, ', '), '-') AS 'List of courses'
from
	courses c
	right join coursesStudents cs on c.id = cs.courseId -- right join för att få med Maria som gick 0 kurser
	right join students s on s.id = cs.studentId
group by
	s.id, s.name -- id för att säkert unikt, name för att kunna ta ut name

SELECT
    s.Name,
    COUNT(c.Name) AS '# Courses',
    STRING_AGG(c.Name, ', ') AS 'Courses'
FROM
    Students s
    LEFT JOIN coursesStudents cs ON s.ID = cs.studentID
    LEFT JOIN Courses c ON c.ID = cs.courseID
GROUP BY
    s.ID,
    s.Name