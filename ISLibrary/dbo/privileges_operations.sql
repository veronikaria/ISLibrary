
USE ISLibrary
CREATE LOGIN Librarian WITH PASSWORD = 'asd';
CREATE USER Librarian FOR LOGIN Librarian; 



USE ISLibrary
GRANT SELECT ON Accounting TO Librarian;
GRANT SELECT ON Author TO Librarian;
GRANT SELECT ON Book TO Librarian;
GRANT SELECT ON Book_Author TO Librarian;
GRANT SELECT ON Edition TO Librarian;
GRANT SELECT ON Reader TO Librarian;
GRANT SELECT ON Room TO Librarian;
GRANT SELECT ON Room_Book TO Librarian;
GRANT INSERT ON Reader TO Librarian;
GRANT UPDATE ON Reader TO Librarian;
GRANT DELETE ON Reader TO Librarian;
GRANT INSERT ON Book TO Librarian;
GRANT UPDATE ON Book TO Librarian;
GRANT DELETE ON Book TO Librarian;

EXECUTE AS USER='Librarian'
SELECT b.Name FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE r.Ticket_Number=2
AND DateReturnBook IS NULL
REVERT
GO



-- Какие книги закреплены за определенным читателем?

-- за читателем  2
EXECUTE AS USER='Librarian'
SELECT b.Name FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE r.Ticket_Number=2
AND DateReturnBook IS NULL
REVERT
GO

-- за читателем  3
EXECUTE AS USER='Librarian'
SELECT b.Name FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE r.Ticket_Number=3
AND DateReturnBook IS NULL
REVERT
GO


-- Как называется книга с заданным шифром?

-- с шифром 1
EXECUTE AS USER='Librarian'
SELECT Name FROM Book
WHERE Code=1
REVERT
GO


-- с шифром 3
EXECUTE AS USER='Librarian'
SELECT Name FROM Book
WHERE Code=3
REVERT
GO



-- Какой шифр у книги с заданным названием?

-- с названием "Пригоди Тома Сойєра"
EXECUTE AS USER='Librarian'
SELECT Code FROM Book
WHERE Name=N'Пригоди Тома Сойєра'
REVERT
GO


-- с названием "Республіка Шкід"
EXECUTE AS USER='Librarian'
SELECT Code FROM Book
WHERE Name=N'Республіка Шкід'
REVERT
GO



-- Когда книга была закреплена за читателем?


-- книга "Тореадори з Васюківки" за читателем  2
EXECUTE AS USER='Librarian'
SELECT a.DateGetBook FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE r.Ticket_Number=2
AND b.Name=N'Тореадори з Васюківки'
REVERT
GO


-- книга "Маруся Чурай" за читателем  4
EXECUTE AS USER='Librarian'
SELECT a.DateGetBook FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE r.Ticket_Number=4
AND b.Name=N'Маруся Чурай'
REVERT
GO



-- Кто из читателей взял книгу больше месяца назад?

-- книга "Республіка Шкід"
EXECUTE AS USER='Librarian'
SELECT r.Ticket_Number, r.Lastname, r.Phone FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE a.DateGetBook < DateAdd(month, -1, Convert(date, GetDate()))
AND b.Name=N'Республіка Шкід'
REVERT
GO


-- книга "Анжеліка"
EXECUTE AS USER='Librarian'
SELECT r.Ticket_Number, r.Lastname, r.Phone FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE a.DateGetBook < DateAdd(month, -1, Convert(date, GetDate()))
AND b.Name=N'Анжеліка'
REVERT
GO



-- За кем из читателей закреплены книги, количество экземпляров которых в библиотеке не превышает 2?
EXECUTE AS USER='Librarian'
SELECT DISTINCT r.Ticket_Number, r.Lastname, r.Phone FROM Reader r
JOIN Accounting a ON a.Ticket_Number=r.Ticket_Number
JOIN Book b ON b.Code=a.Code_Book
WHERE b.Code IN (SELECT t.Code_Book FROM 
(SELECT Code_Book, SUM(Quantity) AllQuantity
FROM Room_Book
GROUP BY Code_Book
HAVING SUM(Quantity) <= 2
) AS t ) 
AND a.DateReturnBook IS NULL
REVERT
GO



-- Какое количество читателей пользуется библиотекой?
EXECUTE AS USER='Librarian'
SELECT COUNT(*) AS ReadersWhoUseTheLibrary FROM Reader 
WHERE IsExclusion=0
REVERT
GO



-- Сколько в библиотеке читателей младше 20 лет?
EXECUTE AS USER='Librarian'
SELECT COUNT(*) AS ReadersYounger20Years FROM Reader 
WHERE ((CONVERT(int,CONVERT(char(8), GETDATE(),112))-CONVERT(char(8), Birthdate,112))/10000)
	< 20
REVERT
GO



-- Сколько читателей в процентном отношении имеют начальное образование, среднее, высшее, научную степень?
EXECUTE AS USER='Librarian'
DECLARE @cnt_all INT
SELECT @cnt_all = COUNT(*) FROM Reader
SELECT 
(SELECT CAST(COUNT(*) AS FLOAT)/CAST(@cnt_all AS FLOAT)*100 AS PrimaryEducation FROM Reader 
WHERE Education=N'початкова') PrimaryEducation,
(SELECT CAST(COUNT(*) AS FLOAT)/CAST(@cnt_all AS FLOAT)*100 AS SecondaryEducation FROM Reader 
WHERE Education=N'середня') SecondaryEducation,
(SELECT CAST(COUNT(*) AS FLOAT)/CAST(@cnt_all AS FLOAT)*100 AS HigherEducation FROM Reader 
WHERE Education=N'вища') HigherEducation,
(SELECT CAST(COUNT(*) AS FLOAT)/CAST(@cnt_all AS FLOAT)*100 AS DegreeScientific FROM Reader 
WHERE IsDegreeScientific=1) DegreeScientific
REVERT
GO

