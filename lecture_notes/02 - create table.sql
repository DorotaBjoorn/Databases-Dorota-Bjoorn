-- Create new table

--DROP TABLE Teachers;

CREATE TABLE Teachers
(
	Id int primary key,
	Name nvarchar(max) not null,
	Age int
);

INSERT INTO Teachers values (1, 'Peter', 28);
INSERT INTO Teachers values (2, 'Anna', 29);
SELECT * FROM Teachers;