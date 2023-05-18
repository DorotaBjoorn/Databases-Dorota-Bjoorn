-- Create and polulate database---------------------------------------------
CREATE TABLE Authors
(
	AuthorId int PRIMARY KEY,
	AuthorFirstName nvarchar(50),
	AuthorLastName nvarchar(50),
	AuthorBirthDate date
);

INSERT INTO
	Authors
VALUES
	(1, 'Anna', 'Andersson', '1976-03-20'),
	(2, 'Bertil', 'Boström', '1944-12-25'),
	(3, 'Cesar', 'Carlsson', '2000-02-13'),
	(4, 'Dinea', 'Dostrovska', '1952-08-05');


CREATE TABLE Books
(
	BookId nvarchar(13) CHECK (BookId LIKE REPLICATE('[0-9]', 13)) PRIMARY KEY,
	BookTitle nvarchar(50) NOT NULL,
	BookLanguage nvarchar(50),
	BookPrice int NOT NULL,
	BookReleaseDate date,
	FormatId int NOT NULL
);

INSERT INTO
	Books
VALUES
	('9781399713770', 'Things we hide', 'English', '127', '2022-02-21', '2'),
	('9781399725489', 'Things we find', 'English', '185', '2020-01-11', '2'),
	('9780266690066', 'What things?', 'English', '255', '2020-05-06', '2'),
	('9783846925485', 'The invisible life of Mr Gray', 'English', '52', '2012-06-03', '2'),
	('9781387549322', 'Too many reasons why', 'English', '199', '1999-05-10', '2'),
	('9785897111589', '100 reasons why', 'English', '485', '1944-06-12', '3'),
	('9781399700279', 'Bajki', 'Polish', '369', '1985-07-07', '4'),
	('9781391875509', 'The white elephant', 'English', '399', '2022-12-18', '4'),
	('9725843325409', 'Red, white, blue', 'English', '129', '2022-05-05', '1'),
	('9781300285460', 'Allt om yrsel', 'Swedish', '85', '2020-04-28', '2');

CREATE TABLE Shops
(
	ShopId int primary key,
	ShopName nvarchar(20),
	ShopCity nvarchar(20)
);

INSERT INTO
	Shops
VALUES
	(1, 'The Book Heaven', 'Mora'),
	(2, 'The Dusty Bookshelf', 'Strömstad'),
	(3, 'Twice Sold Tales', 'Mora');

CREATE TABLE Inventory
(
	ShopId int NOT NULL,
	BookId nvarchar(13) NOT NULL CHECK (BookId LIKE REPLICATE('[0-9]', 13)),
	BooksInStock int NOT NULL DEFAULT 0
);

INSERT INTO
	Inventory
VALUES
	(1, '9781399713770', 257),
	(2, '9781399713770', 22),
	(3, '9781399725489', 5),
	(1, '9781399725489', 7),
	(3, '9780266690066', 65),
	(2, '9780266690066', 8),
	(1, '9780266690066', 32),
	(3, '9783846925485', 0),
	(2, '9781387549322', 25),
	(3, '9781387549322', 7),
	(1, '9781387549322', 17),
	(1, '9785897111589', 3),
	(2, '9781399700279', 4),
	(2, '9781391875509', 6),
	(1, '9781391875509', 12),
	(3, '9781391875509', 6),
	(2, '9725843325409', 6),
	(3, '9725843325409', 8),
	(2, '9781300285460', 6),
	(1, '9781300285460', 4);

CREATE TABLE BooksAuthors
(
	BookId nvarchar(13) CHECK (BookId LIKE REPLICATE('[0-9]', 13)),
	AuthorId int
);

INSERT INTO BooksAuthors
VALUES
	('9781399713770', 1),
	('9781399713770', 2),
	('9781399713770', 3),
	('9781399725489', 1),
	('9781399725489', 2),
	('9781399725489', 3),
	('9780266690066', 1),
	('9780266690066', 2),
	('9783846925485', 4),
	('9781387549322', 3),
	('9781387549322', 4),
	('9785897111589', 1),
	('9785897111589', 3),
	('9785897111589', 4),
	('9781399700279', 1),
	('9781391875509', 1),
	('9725843325409', 3),
	('9781300285460', 3),
	('9781300285460', 1),
	('9781300285460', 4);

CREATE TABLE [Format]
(
	FormatId int PRIMARY KEY,
	FormatName nvarchar(50) NOT NULL,
);

INSERT INTO [Format]
VALUES
	(1, 'paperback'),
	(2, 'bound'),
	(3, 'e-book'),
	(4, 'audiobook');

CREATE TABLE Customers
(
	CustomerId int PRIMARY KEY,
	CustomerName nvarchar(50),
	CustomerCity nvarchar(50)
);
INSERT INTO Customers
VALUES
	(1, 'Maria Mårtensson', 'Malmö'),
	(2, 'Nils Nilsson', 'Nässjö'),
	(3, 'Örjan Österkrans', 'Örebro');

CREATE TABLE Orders_customers
(
	OrderId int PRIMARY KEY,
	CustomerId int NOT NULL,
	OrderDate date
);

INSERT INTO Orders_customers
VALUES
	(1, 1, '2023-01-01'),
	(2, 3, '2023-01-02'),
	(3, 3, '2023-01-03'),
	(4, 1, '2023-01-04'),
	(5, 2, '2023-01-05'),
	(6, 2, '2023-01-06'),
	(7, 3, '2023-01-09'),
	(8, 1, '2023-01-11'),
	(9, 2, '2023-01-12'),
	(10, 1, '2023-01-13'),

CREATE TABLE Orders_products
(
	OrderId int NOT NULL,
	BookId nvarchar(13) CHECK (BookId LIKE REPLICATE('[0-9]', 13)) NOT NULL,
	UnitPrice int NOT NULL,
	OrderQuantity int NOT NULL
);

INSERT INTO Orders_products
VALUES
	(1, '9781399713770', 150, 1),
	(1, '9781399725489', 150, 1),
	(1, '9780266690066', 150, 1),
	(2, '9781399713770', 150, 1),
	(2, '9781399725489', 150, 1),
	(2, '9780266690066', 150, 1),
	(2, '9783846925485', 145, 2),
	(3, '9781399713770', 150, 1),
	(4, '9781399700279', 369, 2),
	(5, '9781387549322', 99, 1),
	(5, '9785897111589', 399, 1),
	(6, '9781300285460', 99, 1),
	(7, '9781391875509', 399, 1),
	(8, '9781391875509', 399, 2),
	(9, '9725843325409', 129, 1),
	(10, '9781399725489', 185, 2)

--View -----------------------------------------------------
CREATE VIEW TitlarPerFörfattare AS
SELECT
	CONCAT(a.AuthorFirstName, ' ', a.AuthorLastName) AS [Name],
	CONCAT(DATEDIFF(YEAR, a.AuthorBirthdate, GETDATE()), ' years') AS Age,
	CONCAT(COUNT(DISTINCT b.BookId), ' pcs') AS Titles,
	CONCAT(SUM(b.BookPrice * i.BooksInStock), ' kr') AS [Stock value]
FROM
	Authors a
	JOIN BooksAuthors ba ON a.AuthorId = ba.AuthorId
	JOIN Books b ON b.BookId = ba.BookId
	JOIN Inventory i ON b.BookId = i.BookId
GROUP BY
	CONCAT(a.AuthorFirstName, ' ', a.AuthorLastName),
	CONCAT(DATEDIFF(YEAR, a.AuthorBirthdate, GETDATE()), ' years')

--View ------------------------------------------------------
/*
View showing summary for each customer and their order history,
Customer activity could motivate discouts or targeted campaigns, also non-active users could be removed
*/

CREATE VIEW OrdersPerCustomer AS
SELECT
	c.CustomerId,
	c.CustomerName,
	COUNT(DISTINCT oc.OrderId) AS [Number of orders],
	SUM(op.OrderQuantity) AS [Number of books ordered],
	SUM(op.UnitPrice * op.OrderQuantity) AS [Total value (SEK)]
FROM
	Books b
	JOIN Orders_products op ON b.BookId = op.BookId
	JOIN Orders_customers oc ON op.OrderId = oc.OrderId
	JOIN Customers c ON c.CustomerId = oc.CustomerId
GROUP BY
	c.CustomerId, c.CustomerName

--SP ----------------------------------------------------------------
/*
Dataintegrity to consider is correct data type for variables, nvarchar length, removing and adding books within a transaction
*/
CREATE procedure MoveBook @StoreIdFrom int, @StoreIdTo int, @BookId nvarchar(13), @NumberBooks int = 1 AS
BEGIN
	IF @BookId NOT IN (SELECT BookId FROM Inventory)
	BEGIN
		THROW 50001, 'Provided ISBN does not match any book in inventory', 1;
		RETURN
	END

	IF @BookId NOT IN (SELECT BookId FROM Inventory WHERE ShopId = @StoreIdFrom)
	BEGIN
		THROW 50006, 'Current store does not hold book with provided ISBN', 1;
		RETURN
	END

	IF @BookId NOT LIKE REPLICATE('[0-9]', 13)
	BEGIN
		THROW 50002, 'Provided number is not a valid ISBN', 1;
		RETURN
	END
	
	IF @NumberBooks > (SELECT BooksInStock FROM Inventory WHERE ShopId = @StoreIdFrom AND BookId = @BookId)
	BEGIN
		THROW 50003, 'There are too few books in stock', 1;
		RETURN
	END

	IF @NumberBooks <= 0
	BEGIN
		THROW 50004, 'Number of books has to be a positive number', 1;
		RETURN
	END

	IF @StoreIdFrom NOT IN (SELECT ShopId FROM Inventory) OR @StoreIdTo NOT IN (SELECT ShopId FROM Inventory)
	BEGIN
		THROW 50005, 'Provided store Id does not exist', 1;
		RETURN
	END

	BEGIN TRANSACTION
		UPDATE Inventory
		SET BooksInStock = BooksInStock - @NumberBooks
		WHERE ShopId = @StoreIdFrom AND BookId = @BookId;

		IF EXISTS (SELECT * FROM Inventory WHERE ShopId = @StoreIdTo AND BookId = @BookId)
		BEGIN
			UPDATE Inventory
			SET BooksInStock = BooksInStock + @NumberBooks
			WHERE ShopId = @StoreIdTo AND BookId = @BookId;
		END
		ELSE
		BEGIN
			INSERT INTO Inventory (ShopId, BookId, BooksInStock)
			VALUES (@StoreIdTo, @BookId, @NumberBooks)
		END

		PRINT 'Books have been moved successfully';
	COMMIT
END
-- EXECUTE MoveBook 2, 1, 9780266690066, 0


--Query for Python excercise ------------------------
DECLARE @SearchedTitle nvarchar(max) = 'white'
SELECT
	b.BookTitle,
	i.BooksInStock,
	s.ShopName
FROM
	Books b
	JOIN Inventory i ON b.BookId = i.BookId
	JOIN Shops s ON i.ShopId = s.ShopId
WHERE
	b.BookTitle LIKE ('%' + @SearchedTitle + '%')
