
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




-- Записать в библиотеку нового читателя.
EXECUTE AS USER='Librarian'
INSERT INTO Reader
(
	Ticket_Number,
	Lastname,
	Passport,
	Birthdate,
	Address,
	Phone,
	Education,
	IsDegreeScientific,
	DateRegistration
)
VALUES
(10, N'Марков', '971142112', '2000-03-11', N'Київ, вул. Стуса 17/13', '+380951981001', N'середня', 0, '2021-12-20')
REVERT
GO


EXECUTE AS USER='Librarian'
SELECT * FROM Reader
REVERT
GO


-- Исключить из списка читателей людей, которые записались в библиотеку больше года назад и не прошли перерегистрацию.
-- TRIGGER DeleteReaderNotReregisteredMoreYear (в папке Triggers)
-- Проверка работы триггера:
EXECUTE AS USER='Librarian'
DELETE FROM Reader
WHERE DATEDIFF(yy, DateRegistration, GETDATE())>=1
AND DateReRegistration IS NULL
REVERT
GO


EXECUTE AS USER='Librarian'
SELECT * FROM Reader
REVERT
GO



-- Списать старую или утраченную книгу.
-- TRIGGER DeleteOldOrLostBook (в папке Triggers)
-- Проверка работы триггера:
EXECUTE AS USER='Librarian'
DELETE FROM Book
WHERE Code=7
REVERT
GO


EXECUTE AS USER='Librarian'
SELECT * FROM Book
REVERT
GO


-- Принять книгу в библиотеке фонда.
EXECUTE AS USER='Librarian'
INSERT INTO Book
(Code, Name, EditionId, Year)
VALUES
(8, N'Берестечко', 2, 2015)
REVERT
GO


EXECUTE AS USER='Librarian'
SELECT * FROM Book
REVERT
GO



-- Выдача справки о количестве книг автора в читальном зале


-- поиск автора по идентификатору
-- FUNCTION QuantityBooksByAuthorId(@id INT) - в папке Functions
-- Проверка работы функции:

SELECT dbo.QuantityBooksByAuthorId(4) AS QuantityBooks
SELECT dbo.QuantityBooksByAuthorId(7) AS QuantityBooks


-- поиск автора по ФИО
-- FUNCTION QuantityBooksByAuthorPIB(@lastname NVARCHAR(50), @firstname NVARCHAR(50), @middlename NVARCHAR(50))
-- Проверка работы функции:

SELECT dbo.QuantityBooksByAuthorPIB(N'Голон', N'Анн', NULL) AS QuantityBooks
SELECT dbo.QuantityBooksByAuthorPIB(N'Костенко', N'Ліна', N'Василівна') AS QuantityBooks


-- отчет о работе библиотеки в течение месяца
-- количество книг и читателей на текущий день в каждом из залов и в библиотеке в целом
-- PROCEDURE ReportQuantityBooksAndReaders(@month INT)
-- Проверка работы процедуры:

EXEC ReportQuantityBooksAndReaders 12 



-- количество читателей, записавшихся в библиотеку за отчетный месяц
-- FUNCTION QuantityReadersByMonth(@month INT)
-- Проверка работы функции:

SELECT dbo.QuantityReadersByMonth(12) AS QuantityReaders



-- какие книги и сколько раз были взяты за отчетный месяц
-- PROCEDURE ReportNameAndQuantityBooksByMonth(@month INT)
-- Проверка работы процедуры:

EXECUTE ReportNameAndQuantityBooksByMonth 12 
EXECUTE ReportNameAndQuantityBooksByMonth 10 



-- кто из читателей не брал книг
-- PROCEDURE ReportReadersNotTakeBooks
-- Проверка работы процедуры:

EXECUTE ReportReadersNotTakeBooks





