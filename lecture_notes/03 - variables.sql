DECLARE @name AS nvarchar(10) = 'Dorota';
PRINT @name;
SET @name = 'Kamilla';
PRINT @name;
SET @name = (SELECT top 1 FirstName from Users);
PRINT @name;

------------------
DECLARE @username AS nvarchar(max) = 'sigpet';
DECLARE @email AS nvarchar(max);

SET @email = (SELECT top 1 Email FROM users WHERE UserName = @username); -- kr�ver top 1 f�r att f� ut 1 v�rde
PRINT concat('Email for user ', @username, ' is ', @email);

---------------------
DECLARE @username AS nvarchar(max) = 'sigpet';
DECLARE @email AS nvarchar(max);
DECLARE @firstname AS nvarchar(max);
DECLARE @lastname AS nvarchar(max);

SELECT top 1 @firstname = FirstName, @lastname = LastName, @email = Email FROM users WHERE UserName = @username;
PRINT concat('Email for user ', @firstname, ' ', @lastname, ' is ', @email);

------------------------
DECLARE @firstname AS nvarchar(max);
SELECT top 1 @firstname = FirstName FROM Users; --s�tter @firstname till 1a v�rdet i FirstName
SELECT @firstname;

DECLARE @firstname AS nvarchar(max);
SELECT @firstname = FirstName FROM Users; --s�tter @firstname till alla v�rden i tur och ordning i FirstName d�rf�r returnerar sista
SELECT @firstname;

DECLARE @firstname AS nvarchar(max); -- varibeln �r NULL
SELECT @firstname += FirstName FROM Users; --concatinerar alla @firstname men returnerar NULL d� variabeln �r NULL 
SELECT @firstname;

DECLARE @firstname AS nvarchar(max) = ''; -- m�ste ha en tom str�ng att spara concatineringen i, dvs variablen �r inte NULL
SELECT @firstname += FirstName FROM Users;
-- SELECT @firstname;
PRINT @firstname;

--=================================================================================================
-- Variabel som �r av typen Table
-- aktiv bara n�r skriptet k�rs
DECLARE @pople AS Table
(
	col,
	col
);


-- Globala variabler
SELECT * FROM Users
SELECT * FROM users len(FirstName) = 5;
SELECT @@ROWCOUNT

create Table test
(
	id int primary key identity(1, 1),
	name nvarchar(max)
)

insert into test (name) values('Fredrik')
select * from test;

select @@IDENTITY

---------------------------------------------------------------
-- konfigurationsvariabler
set nocount on; -- skriver inte ut (X rows affected)
kod
set nocount off;

---------------------------------------------------------------
-- Tempor�ra tabeller
-- namnges med #tempTable
-- kan bara n�s fr�n samma session, tas bort automatiskt n�r sessionen st�ngs
-- syns inte i databasens lista �ver tabeller utan finns i System Databases

-----------------------------------------------------------------
-- Tempor�ra globala tabeller
-- ##TempTable �r global tempor�r tabell:
-- tas bort n�r man st�nger av sessionen som har skapat den
-- men kan kommas �t fr�n andra sessioner

-------------------------------------------------

