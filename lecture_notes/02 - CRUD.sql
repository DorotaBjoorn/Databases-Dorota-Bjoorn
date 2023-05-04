SELECT * INTO users2 FROM users; -- koperar �ver hela tabellen i en koppia, prim�rnycklar h�nger inte med medan datatyperna h�nger med

SELECT ID, UserName, Password, FirstName + ' ' + LastName as 'FulllName', Email, Phone from users2;
SELECT ID, UserName, Password, FirstName + ' ' + LastName as 'FulllName', Email, Phone INTO users3 FROM users2;

SELECT * FROM users3;
SELECT * FROM users2;

INSERT INTO users3 (ID, FulllName) values('490703-2345', 'Frida Karlsson');
SELECT * FROM users3 ORDER BY ID;

-- DELETE FROM users3 WHERE id = '490703-2345'

INSERT INTO users3 (ID, FulllName, Email) values('460815-2345', 'Karl Karlsson', 'karl@kalrsson.com');
-- INSERT INTO users3 (FulllName, Email) values('Erik Karlsson', 'erik@kalrsson.com'); kommer ej g� d� ID �r primary Key och dessutom till�ts inte NULL i ID
INSERT INTO users3 values('450815-2345', 'karkar', 'hemligt', 'Karl Karlsson', 'karl@kalrsson.com', '0123456789'); -- beh�ver ej lista kolumnnamn om s�tter in full rad

SELECT Title FROM GameOfThrones WHERE Season = 1;
-- SELECT satsen k�rver att antal kolumner och datatyp �r samma
INSERT INTO users2 (ID) SELECT left (Title, 12) FROM GameOfThrones WHERE Season = 1; --left 12 plockar bara 12 1:a tecknen

SELECT * FROM Users2;
-- UPDATE users2 SET Email = 'johanna@hotmail.com' skulle byta mailadress p� alla raderna
UPDATE users2 SET Email = 'johanna@hotmail.com' WHERE  ID = '500603-4268';

-------------------------------------------------------------------------------------------
-- Miniuppgift: uppdatera  email till '-' f�r alla personer med ett f�rnamn p� 4 bokst�ver
SELECT * INTO users2b FROM users2;
SELECT * FROM users2b;
UPDATE users2b SET Email = '-' WHERE len(FirstName) = 4;

-- Miniuppgift: ers�tt alla - med [f�rnamn]@gmail.com
UPDATE users2b SET Email = FirstName + '@gmail.com' WHERE len(FirstName) = 4;

---------------------------------------------------------------------------------------------
-- Ta bort poster, data, tabeller
DELETE FROM users2 WHERE len(FirstName) = 4; -- ta bort rader som uppfyllter ett visst villkor
TRUNCATE TABLE users2b; -- ta bort data
DROP TABLE users2b; -- ta bort tabellen

