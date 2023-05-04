DECLARE @name AS nvarchar(10) = 'Dorota';
PRINT @name;
SET @name = 'Kamilla';
PRINT @name;
SET @name = (SELECT top 1 FirstName from Users);
PRINT @name;

------------------
DECLARE @username AS nvarchar(max) = 'sigpet';
DECLARE @email AS nvarchar(max);

SET @email = (SELECT top 1 Email FROM users WHERE UserName = @username); -- kräver top 1 för att få ut 1 värde
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
SELECT top 1 @firstname = FirstName FROM Users; --sätter @firstname till 1a värdet i FirstName
SELECT @firstname;

DECLARE @firstname AS nvarchar(max);
SELECT @firstname = FirstName FROM Users; --sätter @firstname till alla värden i tur och ordning i FirstName därför returnerar sista
SELECT @firstname;

DECLARE @firstname AS nvarchar(max); -- varibeln är NULL
SELECT @firstname += FirstName FROM Users; --concatinerar alla @firstname men returnerar NULL då variabeln är NULL 
SELECT @firstname;

DECLARE @firstname AS nvarchar(max) = ''; -- måste ha en tom sträng att spara concatineringen i, dvs variablen är inte NULL
SELECT @firstname += FirstName FROM Users;
-- SELECT @firstname;
PRINT @firstname;

--=================================================================================================
-- Variabel som är av typen Table
-- aktiv bara när skriptet körs
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
-- Temporära tabeller
-- namnges med #tempTable
-- kan bara nås från samma session, tas bort automatiskt när sessionen stängs
-- syns inte i databasens lista över tabeller utan finns i System Databases

-----------------------------------------------------------------
-- Temporära globala tabeller
-- ##TempTable är global temporär tabell:
-- tas bort när man stänger av sessionen som har skapat den
-- men kan kommas åt från andra sessioner

-------------------------------------------------

