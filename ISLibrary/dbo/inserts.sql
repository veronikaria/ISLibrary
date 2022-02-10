
INSERT INTO Edition
(Name)
VALUES
(N'Біла сова'),
(N'Аверс'),
(N'Астра'),
(N'Кальварія'),
(N'Веселка')




INSERT INTO Book
(Code, Name, EditionId, Year)
VALUES
(1, N'Маруся Чурай', 1, 1979),
(2, N'Тореадори з Васюківки', 2, 2020),
(3, N'Пригоди Тома Сойєра', 3, 2019),
(4, N'Триста поезій', 3, 2019),
(5, N'Анжеліка', 4, 1999),
(6, N'Республіка Шкід', 5, 1960),
(7, N'Річка Геракліта', 1, 2011)



INSERT INTO Author
(Lastname, Firstname, Middlename)
VALUES
(N'Голон',N'Анн', NULL),
(N'Голон',N'Серж', NULL),
(N'Бєлих',N'Григорій', N'Григорович'),
(N'Єрмеєв',N'Олексій', N'Іванович'),
(N'Нестайко',N'Всеволод', N'Зіновійович'),
(N'Твен',N'Марк',NULL),
(N'Костенко',N'Ліна', N'Василівна')



INSERT INTO Book_Author
(Code_Book, Id_Author)
VALUES
(1, 7),
(2, 5),
(3, 6),
(4, 7),
(5, 1),
(5, 2),
(6, 3),
(6, 4),
(7, 7)



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
	DateReRegistration
)
VALUES
(1, N'Іванов', '989342871', '2000-01-18', N'Київ, вул. Шевченка 87/23', '+380952987645', N'середня', 0, '2021-07-10'),
(2, N'Петров', '679972551', '1994-12-23', N'Київ, вул. Магнітогорська 17/56', '+380979897634', N'вища', 0, '2021-07-10'),
(3, N'Малинов', '769388873', '2000-11-28', N'Львів, вул. Маршака 11/7', '+3801989001', N'середня', 0, '2021-07-10'),
(4, N'Шумейко', '889776875', '2008-11-21', N'Харків, вул. Метрологічна 119/33', '+380955986646', N'початкова', 0, '2020-07-10'),
(5, N'Сердюк', '895742851', '2005-08-23', N'Київ, вул. Миронівська 9/55', '+380682007688', N'середня', 0, '2021-12-10'),
(6, N'Ярешко', '709546874', '1998-02-10', N'Київ, вул. Михайлівська 144/91', '+380982181611', N'вища', 0, '2021-11-16'),
(7, N'Лев', '801236888', '1888-12-13', N'Київ, вул. Маршака 89/12', '+380982878633', N'вища', 1, '2021-07-15'),
(8, N'Яремко', '301236348', '1881-09-29', N'Київ, вул. Метрологічна 21/23', '+380982458111', N'вища', 1, '2021-08-17'),
(9, N'Костів', '899236073', '1889-10-22', N'Київ, вул. Маршака 78/12', '+380982368222', N'вища', 1, '2020-05-10')



INSERT INTO Room
(Name, Roominess)
VALUES
(N'Зал зарубіжної літератури', 5),
(N'Зал української літератури', 7),
(N'Зал шкільної літератури', 8),
(N'Зал літератури для внз', 4)



INSERT INTO Room_Book
(Number_Room, Code_Book, Quantity)
VALUES
(1, 5, 3),
(1, 6, 4),
(2, 1, 3),
(2, 2, 4),
(2, 3, 3),
(2, 4, 4),
(2, 7, 1),
(3, 1, 3),
(3, 2, 3),
(3, 3, 2),
(3, 4, 5)



INSERT INTO Accounting
(
	Number_Room,
	Code_Book,
	Ticket_Number,
	DateGetBook,
	DateReturnBook
)
VALUES
(1, 5, 1, CONVERT(DATETIME, '2021-10-01 11:29:00'), CONVERT(DATETIME, '2021-10-01 13:40:00')),
(1, 6, 2, CONVERT(DATETIME, '2021-10-01 11:22:00'), CONVERT(DATETIME, '2021-10-01 14:11:00')),
(1, 5, 1, CONVERT(DATETIME, '2021-12-24 10:04:00'), CONVERT(DATETIME, '2021-12-24 12:30:00')),
(1, 6, 2, CONVERT(DATETIME, '2021-12-24 10:12:00'), CONVERT(DATETIME, '2021-12-24 11:38:00')),
(2, 1, 3, CONVERT(DATETIME, '2021-12-24 11:12:00'), CONVERT(DATETIME, '2021-12-24 14:43:00')),
(2, 1, 4, CONVERT(DATETIME, '2021-12-24 11:14:00'), CONVERT(DATETIME, '2021-12-24 15:55:00')),
(1, 5, 5, CONVERT(DATETIME, '2021-12-24 10:14:00'), CONVERT(DATETIME, '2021-12-24 13:00:00')),
(2, 1, 7, CONVERT(DATETIME, '2021-12-24 11:17:00'), CONVERT(DATETIME, '2021-12-24 14:30:00')),
(2, 3, 6, CONVERT(DATETIME, '2021-12-24 18:05:00'), CONVERT(DATETIME, '2021-12-24 19:35:00')),
(2, 3, 1, CONVERT(DATETIME, '2021-12-24 18:09:00'), CONVERT(DATETIME, '2021-12-24 20:00:00')),
(2, 3, 2, CONVERT(DATETIME, '2021-12-24 18:00:00'), CONVERT(DATETIME, '2021-12-24 19:21:00'))



INSERT INTO Accounting
(
	Number_Room,
	Code_Book,
	Ticket_Number,
	DateGetBook
)
VALUES
(3, 1, 2, CONVERT(DATETIME, '2021-12-23 12:05:00')),
(3, 2, 2, CONVERT(DATETIME, '2021-12-23 12:00:00')),
(3, 1, 3, CONVERT(DATETIME, '2021-12-24 13:11:00')),
(3, 3, 3, CONVERT(DATETIME, '2021-12-24 13:12:00')),
(2, 7, 1, CONVERT(DATETIME, '2021-12-20 15:22:00'))



SELECT * FROM Book
SELECT * FROM Author
SELECT * FROM Book_Author
SELECT * FROM Edition
SELECT * FROM Reader
SELECT * FROM Room
SELECT * FROM Room_Book
SELECT * FROM Accounting




-- Перевірка роботи тригера AccountingInsert
INSERT INTO Accounting
(
	Number_Room,
	Code_Book,
	Ticket_Number,
	DateGetBook
)
VALUES
(2, 1, 6, CONVERT(DATETIME, '2021-12-24 12:52:00')),
(2, 3, 1, CONVERT(DATETIME, '2021-12-24 19:01:00'))


SELECT * FROM Accounting




